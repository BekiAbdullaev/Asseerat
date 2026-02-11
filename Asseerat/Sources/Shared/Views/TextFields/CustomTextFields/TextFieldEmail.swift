//
//  TextFieldEmail.swift
//  NewIOSApp
//
//  Created by Bekzod Abdullaev on 13/06/25.
//

import SwiftUI

struct TextFieldEmail: View {
    
    private var title: String
    @State private var info: String
    @Binding var number: String
    @Binding var isValid: Bool
    @FocusState private var isFocused: Bool
    @Binding private var hasError: Bool {
        didSet {
            if !hasError {
                isValid = true
            }
        }
    }
    
    init(title: String, info: String = "", number: Binding<String>, hasError: Binding<Bool>, isValid: Binding<Bool>) {
        self.title = title
        self.info = info
        self._number = number
        self._hasError = hasError
        self._isValid = isValid
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            VStack(alignment: .leading, spacing: 0) {
                TextFactory.text(type: .regular(text: title.localized, font: isFocused || number.isNotEmpty ? .reg11 : .med16, color: .seccondary, line: 1))
                    .padding(.horizontal, 16)
                    .offset(y: isFocused || number.isNotEmpty ? 7 : 14)
                    .animation(.snappy(duration: 0.1), value: isFocused || number.isNotEmpty)
            
                TextField("", text: $number)
                    .onChange(of: number) {_,newValue in
                        print(newValue)
                        hasError = false
                        Task {
                            try await Task.sleep(nanoseconds: 1_000_000_000)
                            isValid = isValidEmailFormat(number)
                            if isValid {
                                isValid = true
                                hasError = false
                                info = ""
                            } else {
                                isValid = false
                                hasError = true
                                info = NSLocalizedString("incorrectEmail", comment: "Incorrect Email!")
                            }
                        }
                    }
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .foregroundColor(Colors.white)
                    .font(AppFonts.reg16)
                    .padding(.bottom, 7)
                    .padding(.top, isFocused || number.isNotEmpty ? 8 : 0)
                    .padding(.horizontal, 16)
                    .disableAutocorrection(true)
                    .focused($isFocused)
            }
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Colors.inputBackground)
                    .stroke(hasError ? Colors.textError : Colors.inputStroke, lineWidth: 1)
                    .frame(height: 50)
            )
            
            if info.isNotEmpty {
                TextFactory.text(type: .regular(text: info, font: .reg11, color: isValid ? Colors.seccondary : Colors.textError))
                    .padding(.vertical, 2)
            } else if hasError && info.isEmpty {
                TextFactory.text(type: .regular(text: NSLocalizedString("incorrectEmail", comment: "Incorrect Email"), font: .reg11, color: hasError ? Colors.seccondary : Colors.textError))
                    .padding(.vertical, 2)
            }
        }
    }
    
    func isValidEmailFormat(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

