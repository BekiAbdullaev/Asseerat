//
//  LaunchView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 28/08/25.
//

import SwiftUI

struct LaunchView: View {
    
    @EnvironmentObject var coordinator: Coordinator<MainRouter>
    @ObservedObject private var viewModel = LoginViewModel()
    @State private var isAnimating = false
    var body: some View {
        ZStack {
            Colors.background
            Image("launch_logo")
                .resizable()
                .scaledToFill()
                .frame(width: 152, height: 152, alignment: .center)
            if isAnimating {
                ProgressView()
                    .padding(.top, 110)
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(2.0)
            }
        }.ignoresSafeArea(.all)
            .background(
                Image("splash_background")
                    .resizable()
                    .scaledToFill()
            ).onDidLoad {
                let login = UDManager.shared.getString(key: .userLogin)
                let password = UDManager.shared.getString(key: .userPassword)
                let loginType = UDManager.shared.getString(key: .userLoginType)
                
                if login.isNotEmpty && password.isNotEmpty && loginType.isNotEmpty {
                    isAnimating = true
                    let reqBody = LoginModel.Request.SignIn(login: login, password: password, login_type: loginType)
                    viewModel.postSignIn(reqBody: reqBody, isLaunch: true) {
                        viewModel.checkVersion { dbUpdate, appUpdate in
                            isAnimating = false
                            self.coordinator.navigate(type: .auth(.tabView))
                        }
                    } onError: {
                        isAnimating = false
                        self.coordinator.navigate(type: .auth(.login))
                    }
                } else {
                    self.coordinator.navigate(type: .auth(.onboarding))
                }
            }
            .onAppear {
                self.setLanguage()
            }
    }
    
    private func setLanguage(){
        var lang = UDManager.shared.getString(key: .currentLanguageKey)
        if lang.isEmpty {
            lang = Locale.current.language.languageCode?.identifier ?? "ru"
        }
        UDManager.shared.setSting(key: .currentLanguageKey, object: lang)
        Bundle.setLanguage(lang)
    }
}


#Preview {
    LaunchView()
}
