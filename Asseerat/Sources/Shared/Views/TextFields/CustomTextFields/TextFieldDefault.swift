//
//  TextFieldDefault.swift
//  NewIOSApp
//
//  Created by Bekzod Abdullaev on 11/06/25.
//

import SwiftUI
import AnyFormatKitSwiftUI

struct TextFieldDefault: View {
    private var title: String
    private var placeholder: String
    @State private var info: String
    @Binding var text: String
    @Binding private var hasError: Bool
    @State private var hasInfo = false
    @State private var keyboard: UIKeyboardType
    private var characterCount: Int?
    var didEndEditing: () -> () = {}
    @FocusState private var isFocused: Bool
    
    init(title: String, placeholder: String = "", info: String = "", text: Binding<String>, keyboard: UIKeyboardType = .default, characterCount: Int? = nil, hasError: Binding<Bool>, didEndEditing: @escaping (() -> ()) = {}) {
        self.title = title
        self.placeholder = placeholder
        self.info = info
        self._text = text
        self.keyboard = keyboard
        self.characterCount = characterCount
        self._hasError = hasError
        self.didEndEditing = didEndEditing
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ZStack {
                VStack(alignment: .leading, spacing: 0) {
                    TextFactory.text(type: .regular(text: title.isNotEmpty ? title.localized : "", font: isFocused || text.isNotEmpty ? .reg11 : .med16, color: .seccondary, line: 1))
                        .padding(.horizontal, 16)
                        .offset(y: isFocused || text.isNotEmpty ? 7 : 14)
                        .animation(.snappy(duration: 0.1), value: isFocused || text.isNotEmpty)
                    
                    HStack {
                        TextField("", text: $text, onEditingChanged: { (changed) in
                            didEndEditing()
                        })
                            .onChange(of: text) { oldValue, newValue in
                                hasError = !(newValue.count > 0)
                                if let characterLimit = characterCount, characterLimit < text.count {
                                    text = String(text.prefix(characterLimit))
                                }
                            }
                            .keyboardType(keyboard)
                            .padding(.bottom, 7)
                            .padding(.top, isFocused || text.isNotEmpty ? 7 : 0)
                            .padding(.horizontal, 16)
                            .font(AppFonts.reg16)
                            .disableAutocorrection(true)
                            .foregroundColor(Colors.white)
                            .focused($isFocused)
                            
                        if let maxChars = characterCount {
                            TextFactory.text(type: .regular(text: "\(text.count)/\(maxChars)", font: .reg14, line: 1))
                                .padding(.trailing, 16)
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
                self.isFocused.toggle()
            }
            
            if info.isNotEmpty {
                TextFactory.text(type: .regular(text: info, font: .reg11, color: hasError ? Colors.textError : Colors.seccondary))
                    .padding(.vertical, 2)
            } else if hasError && info.isEmpty {
                TextFactory.text(type: .regular(text: NSLocalizedString("invalidInput", comment: "Invalid input!"), font: .reg11, color: hasError ? Colors.textError : Colors.seccondary))
                    .padding(.vertical, 2)
                
           }
        }
    }
}
