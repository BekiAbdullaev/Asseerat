//
//  TextFieldDate.swift
//  NewIOSApp
//
//  Created by Bekzod Abdullaev on 13/06/25.
//

import SwiftUI
import AnyFormatKitSwiftUI

struct TextFieldDate: View {
    private var title: String
    @State private var info: String
    @Binding var date: String
    @Binding var isValid: Bool
    @Binding var hasError: Bool
    @FocusState private var isFocused: Bool
    
    @State private var showDatePicker = false
    let formatter = DateFormatter()
    @State private var time = Date()
    
    init(title: String, info: String = "", date: Binding<String>, isValid: Binding<Bool>, hasError: Binding<Bool>) {
        self.title = title
        self.info = info
        self._date = date
        self._isValid = isValid
        self._hasError = hasError
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            ZStack {
                VStack(alignment: .leading, spacing: 0) {
                    
                    TextFactory.text(type: .regular(text: title.localized, font: isFocused || date.isNotEmpty ? .reg11 : .med16, color: .seccondary, line: 1))
                        .padding(.horizontal, 16)
                        .offset(y: isFocused || date.isNotEmpty ? 7 : 14)
                        .animation(.snappy(duration: 0.1), value: isFocused || date.isNotEmpty)
                    
                    HStack(alignment:.center, spacing:3) {
                        FormatTextField(unformattedText: $date, textPattern: "##.##.####")
                            .keyboardType(.decimalPad)
                            .foregroundColor(Colors.white)
                            .font(AppFonts.reg16)
                            .numbersOnly($date)
                            .onChange(of: date, { oldValue, newValue in
                                if date.count == 8 {
                                    isValid = true
                                    isFocused.toggle()
                                } else {
                                    isValid = false
                                }
                            })
                            .padding(.bottom, 7)
                            .padding(.top, isFocused || date.isNotEmpty ? 7 : 0)
                            .padding(.horizontal, 16)
                            .disableAutocorrection(true)
                            .focused($isFocused)
                        
                        Image("ic_calendar")
                            .resizable()
                            .frame(width: 24, height: 24, alignment: .center)
                            .padding(.trailing, 16)
                            .offset(y: isFocused || date.isNotEmpty ? -6 : -10)
                            .onTapGesture {
                                isFocused = false
                                showDatePicker.toggle()
                            }
                    }
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Colors.inputBackground)
                    .stroke(hasError ? Colors.textError : Colors.inputStroke, lineWidth: 1)
                    .frame(height: 50)
            )
            .onTapGesture {
                self.isFocused.toggle()
            }
           
            if showDatePicker {
                VStack(spacing:1){
                    DatePicker("", selection: $time.onChange({ dd in
                        formatter.dateFormat = "dd.MM.yyyy"
                        date = formatter.string(from: dd)
                    }), displayedComponents: .date)
                    .environment(\.locale, Locale.init(identifier: UDManager.shared.getString(key: .currentLanguageKey)))
                    .environment(\.colorScheme, .light)
                    .datePickerStyle(.wheel)
                    .padding(.trailing,biometricType() == .touch ? 14 : 26)
                    .colorInvert()
                    .colorMultiply(.white)
                    
                    ButtonFactory.button(type: .bordered(text: "Select date", onClick: {
                        showDatePicker.toggle()
                        isValid = true
                    }))
                }
            }
            
            if info.isNotEmpty {
                TextFactory.text(type: .regular(text: info, font: .reg11, color: hasError ? Colors.textError : Colors.seccondary))
                    .padding(.vertical, 2)
            
            } else if hasError && info.isEmpty {
                TextFactory.text(type: .regular(text: NSLocalizedString("Invalid date", comment: ""), font: .reg11, color: hasError ? Colors.textError : Colors.seccondary))
                    .padding(.vertical, 2)
                
            }
        }
    }
}

public extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}
