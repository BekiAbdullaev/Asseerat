//
//  TextFieldPhone9.swift
//  NewIOSApp
//
//  Created by Bekzod Abdullaev on 11/06/25.
//

import SwiftUI
import AnyFormatKitSwiftUI

struct TextFieldPhone9: View {
    private var title: String
    @State private var info: String
    @Binding var number: String
    @Binding var isValid: Bool
    @FocusState private var isFocused: Bool
    @State private var hasError:Bool = false
    
    
    init(title: String, info: String = "", number: Binding<String>, isValid: Binding<Bool>) {
        self.title = title
        self.info = info
        self._number = number
        self._isValid = isValid
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ZStack {
                VStack(alignment: .leading, spacing: 0) {
                    TextFactory.text(type: .regular(text: title.localized, font: isFocused || number.isNotEmpty ? .reg11 : .med16, color: .seccondary, line: 1))
                        .padding(.horizontal, 16)
                        .offset(y: isFocused || number.isNotEmpty ? 7 : 14)
                        .animation(.snappy(duration: 0.1), value: isFocused || number.isNotEmpty)
                
                    HStack(spacing:3) {
                        Text(isFocused || number.isNotEmpty ? "+998" : "")
                            .font(.system(size: 17))
                            .foregroundColor(Colors.white)
                            .padding(.leading, 16)
                        FormatTextField(unformattedText: $number, textPattern: "## ### ## ##")
                            .keyboardType(.phonePad)
                            .foregroundColor(Colors.white)
                            .font(AppFonts.reg16)
                            .numbersOnly($number)
                            .onChange(of: number, { oldValue, newValue in
                                if newValue.count == 9 {
                                    isFocused.toggle()
                                    isValid = true
                                }else {
                                    isValid = false
                                }
                            })
                            .padding(.bottom, 7)
                            .padding(.top, isFocused || number.isNotEmpty ? 7 : 0)
                            .padding(.trailing, 16)
                            .disableAutocorrection(true)
                            .focused($isFocused)
                    }
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Colors.inputBackground)
                    .stroke(hasError ? Colors.textError : Colors.inputStroke, lineWidth: 1)
                    .frame(height: 50)
            ).onTapGesture {
                self.isFocused.toggle()
            }
           
            if info.isNotEmpty {
                TextFactory.text(type: .regular(text: info, font: .reg11, color: hasError ? Colors.textError : Colors.seccondary))
                    .padding(.vertical, 2)
            }
        }
    }
}

