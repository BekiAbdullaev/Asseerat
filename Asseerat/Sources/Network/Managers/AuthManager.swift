//
//  AuthManager.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 22/11/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore
import GoogleSignIn
import AuthenticationServices
import CryptoKit

final class AuthManager: NSObject, ObservableObject {
    @Published var user: User?
    @Published var isLoading: Bool = false
    @Published var authError: Error?

    private var currentNonce: String?

    override init() {
        super.init()
        self.user = Auth.auth().currentUser

        // Listen auth state changes (auto updates user)
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            self?.user = user
        }
    }

    // MARK: - GOOGLE SIGN IN
    func signInWithGoogle(presenting vc: UIViewController,
                          completion: @escaping (Result<User, Error>) -> Void) {

        isLoading = true
        authError = nil

        guard let clientID = FirebaseApp.app()?.options.clientID else {
            let err = NSError(domain: "NoClientID", code: -1)
            isLoading = false
            completion(.failure(err))
            return
        }

        GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientID)

        // Google Sign-In UI
        GIDSignIn.sharedInstance.signIn(withPresenting: vc) { [weak self] result, error in
            guard let self else { return }

            if let error = error {
                self.isLoading = false
                self.authError = error
                completion(.failure(error))
                return
            }

            guard
                let googleUser = result?.user,
                let idToken = googleUser.idToken?.tokenString
            else {
                let err = NSError(domain: "NoGoogleToken", code: -1)
                self.isLoading = false
                self.authError = err
                completion(.failure(err))
                return
            }

            let accessToken = googleUser.accessToken.tokenString
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                          accessToken: accessToken)

            // Firebase Sign-In
            Auth.auth().signIn(with: credential) { authResult, error in
                self.isLoading = false

                if let error = error {
                    self.authError = error
                    completion(.failure(error))
                    return
                }

                guard let user = authResult?.user else {
                    let err = NSError(domain: "NoFirebaseUser", code: -1)
                    self.authError = err
                    completion(.failure(err))
                    return
                }

                self.user = user
                completion(.success(user))
            }
        }
    }

    // MARK: - APPLE SIGN IN
    func signInWithApple(completion: @escaping (Result<User, Error>) -> Void) {
        isLoading = true
        authError = nil

        let nonce = randomNonceString()
        currentNonce = nonce

        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self

        // store callback
        self.appleCompletion = completion

        controller.performRequests()
    }

    private var appleCompletion: ((Result<User, Error>) -> Void)?

    // MARK: - SIGN OUT
    func signOut() {
        do {
            try Auth.auth().signOut()
            GIDSignIn.sharedInstance.signOut()
            self.user = nil
        } catch {
            self.authError = error
        }
    }
}

// MARK: - Apple Delegate
extension AuthManager: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {

    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {

        defer { isLoading = false }

        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            let err = NSError(domain: "NoAppleCredential", code: -1)
            authError = err
            appleCompletion?(.failure(err))
            return
        }

        guard let nonce = currentNonce else {
            let err = NSError(domain: "NoNonce", code: -1)
            authError = err
            appleCompletion?(.failure(err))
            return
        }

        guard let tokenData = appleIDCredential.identityToken,
              let idTokenString = String(data: tokenData, encoding: .utf8) else {
            let err = NSError(domain: "NoAppleIDToken", code: -1)
            authError = err
            appleCompletion?(.failure(err))
            return
        }

        // Firebase Apple Credential (nonce required)
        let credential = OAuthProvider.appleCredential(
            withIDToken: idTokenString,
            rawNonce: nonce,
            fullName: appleIDCredential.fullName
        )

        Auth.auth().signIn(with: credential) { [weak self] authResult, error in
            guard let self else { return }

            if let error = error {
                self.authError = error
                self.appleCompletion?(.failure(error))
                return
            }

            guard let user = authResult?.user else {
                let err = NSError(domain: "NoFirebaseUser", code: -1)
                self.authError = err
                self.appleCompletion?(.failure(err))
                return
            }

            self.user = user
            self.appleCompletion?(.success(user))
        }
    }

    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithError error: Error) {
        isLoading = false
        authError = error
        appleCompletion?(.failure(error))
    }

    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }!
    }
}

// MARK: - Nonce helpers (Apple requirement)
private func randomNonceString(length: Int = 32) -> String {
    let charset = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
    var result = ""
    var remaining = length

    while remaining > 0 {
        var randoms = [UInt8](repeating: 0, count: 16)
        let status = SecRandomCopyBytes(kSecRandomDefault, randoms.count, &randoms)
        if status != errSecSuccess { fatalError("Unable to generate nonce") }

        randoms.forEach { random in
            if remaining == 0 { return }
            if random < charset.count {
                result.append(charset[Int(random)])
                remaining -= 1
            }
        }
    }
    return result
}

private func sha256(_ input: String) -> String {
    let data = Data(input.utf8)
    let hashed = SHA256.hash(data: data)
    return hashed.map { String(format: "%02x", $0) }.joined()
}
