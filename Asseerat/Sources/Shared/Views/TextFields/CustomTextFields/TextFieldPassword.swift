//
//  TextFieldPassword.swift
//  NewIOSApp
//
//  Created by Bekzod Abdullaev on 12/06/25.
//

import SwiftUI
import AnyFormatKitSwiftUI

struct TextFieldPassword: View {
    
    private var title: String
    @State private var info: String
    @Binding var text: String
    @Binding var passwordValidationString: String
    @Binding var isValid: Bool
    @State var isSecure: Bool = true
    @Binding private var hasError: Bool
    @Binding private var passwordMissmatch: Bool
    @State private var password = ""
    @State private var passwordIsNotValid = true
    @State private var errorMessage = ""
    @FocusState private var isFocused: Bool
    
    init(title: String, info: String = "", text: Binding<String>, isValid: Binding<Bool>, hasError: Binding<Bool>, passwordMissmatch: Binding<Bool>, passwordValidationString: Binding<String>) {
        self.title = title
        self.info = info
        self._text = text
        self._isValid = isValid
        self._passwordMissmatch = passwordMissmatch
        self._hasError = hasError
        self._passwordValidationString = passwordValidationString
    }
    
    func isValidPassword(_ password: String) -> Bool {
        // Regular expression for password validation including the new characters
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&~'^()\\-_+={}\\[\\];:\"<>,./])[A-Za-z\\d@$!%*#?&~'^()\\-_+={}\\[\\];:\"<>,./]{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        
        return passwordPredicate.evaluate(with: password)
    }
    
    func passwordCheck() {
        Task {
            // Delay of 2 seconds (1 second = 1_000_000_000 nanoseconds)
            try await Task.sleep(nanoseconds: 2_000_000_000)
            if text.isEmpty {
                errorMessage = ""
                isValid = false
            } else {
                isValid = isValidPassword(text)
                if isValid {
                    errorMessage = ""
                    passwordIsNotValid = false
                    isValid = true
                } else {
                    errorMessage = self.passwordValidationString
                    isValid = false
                    passwordIsNotValid = true
                    hasError = true
                }
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ZStack {
                VStack(alignment: .leading, spacing: 0) {
                    TextFactory.text(type: .regular(text: title.localized, font: isFocused || text.isNotEmpty ? .reg11 : .med16, color: .seccondary, line: 1))
                        .padding(.horizontal, 16)
                        .offset(y: isFocused || text.isNotEmpty ? 7 : 14)
                        .animation(.snappy(duration: 0.1), value: isFocused || text.isNotEmpty)

                    HStack(alignment: .center) {
                        if isSecure{
                            SecureField("", text: $text)
                                .onChange(of: text) { _ ,newValue in
                                    info = ""
                                    errorMessage = ""
                                    hasError = false
                                    passwordCheck()
                                }
                                .textContentType(.password)
                                .padding(.bottom, 7)
                                .padding(.top, isFocused || text.isNotEmpty ? 8 : 0)
                                .padding(.horizontal, 16)
                                .font(AppFonts.reg16)
                                .disableAutocorrection(true)
                                .foregroundColor(Colors.white)
                                .focused($isFocused)
                        } else {
                            TextField("", text: $text)
                                .onChange(of: text) { _ ,newValue in
                                    info = ""
                                    errorMessage = ""
                                    hasError = false
                                    passwordCheck()
                                }
                                .textContentType(.password)
                                .padding(.bottom, 7)
                                .padding(.top, isFocused || text.isNotEmpty ? 8 : 0)
                                .padding(.horizontal, 16)
                                .font(AppFonts.reg16)
                                .disableAutocorrection(true)
                                .foregroundColor(Colors.white)
                                .focused($isFocused)
                        }
                        
                        Image(isSecure ? "ic_eye_closed" : "ic_eye_opened")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 24, height: 24)
                            .foregroundColor(Colors.seccondary)
                            .padding(.trailing, 16)
                            .offset(y:isFocused || text.isNotEmpty ? -6 : -10)
                            .onTapGesture {
                                self.isSecure.toggle()
                            }
                    }
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Colors.inputBackground)
                    .stroke(hasError ? Colors.textError : Colors.inputStroke, lineWidth: 1)
                    .frame(height: 50)
            ).onTapGesture {
                isFocused.toggle()
            }
            
            
            
            if info.isNotEmpty {
                TextFactory.text(type: .regular(text: info, font: .reg11, color: Colors.textError))
                    .padding(.vertical, 2)
            }
            
            if passwordIsNotValid && errorMessage.isNotEmpty {
                TextFactory.text(type: .regular(text: errorMessage, font: .reg11, color: Colors.textError))
                    .padding(.vertical, 2)
                
            } else if hasError && info.isEmpty && !passwordMissmatch {
                TextFactory.text(type: .regular(text: NSLocalizedString("invalidInput", comment: "Invalid input!"), font: .reg11, color: hasError ? Colors.textError : Colors.seccondary))
                    .padding(.vertical, 2)
                
            } else if passwordMissmatch && hasError {
                TextFactory.text(type: .regular(text: NSLocalizedString("passwordMismatch", comment: "Password missmatch!"), font: .reg11, color: hasError ? Colors.textError : Colors.seccondary))
                    .padding(.vertical, 2)

            }
        }
    }
}



