//
//  TextFieldPhone12.swift
//  NewIOSApp
//
//  Created by Bekzod Abdullaev on 11/06/25.
//

import SwiftUI
import AnyFormatKitSwiftUI

struct TextFieldPhone12: View {
    private var title: String
    @State private var info: String
    @Binding var number: String
    @Binding var isValid: Bool
    @State var hasError: Bool = false
    @FocusState private var isFocused: Bool
    
    init(title: String, info: String = "", number: Binding<String>, isValid: Binding<Bool>) {
        self.title = title
        self.info = info
        self._number = number
        self._isValid = isValid
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            VStack(alignment: .leading, spacing: 0) {
                
                TextFactory.text(type: .regular(text: title.localized, font: isFocused || number.isNotEmpty ? .reg11 : .med16, color: .seccondary, line: 1))
                    .padding(.horizontal, 16)
                    .offset(y: isFocused || number.isNotEmpty ? 7 : 14)
                    .animation(.snappy(duration: 0.1), value: isFocused || number.isNotEmpty)
            
                FormatTextField(unformattedText: $number, textPattern: "+### ## ### ## ##")
                    .onEditingEnd { no in
                        guard let number = no?.removeSpaces() else { return }
                        if number.count < 12 {
                            isValid = false
                            hasError = true
                            info = NSLocalizedString("invalidPhoneNumber", comment: "")
                        } else {
                            isValid = true
                            hasError = false
                            info = ""
                        }
                    }
                    .keyboardType(.phonePad)
                    .foregroundColor(Colors.white)
                    .font(AppFonts.reg16)
                    .numbersOnly($number)
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
                TextFactory.text(type: .regular(text: info, font: .reg11, color: hasError ? Colors.textError : Colors.seccondary))
                    .padding(.vertical, 2)
            }
        }
    }
}

