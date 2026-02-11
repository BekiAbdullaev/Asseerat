//
//  TextFieldSMS.swift
//  NewIOSApp
//
//  Created by Bekzod Abdullaev on 11/06/25.
//

import SwiftUI
import AnyFormatKitSwiftUI

struct TextFieldSMS: View {
    @Binding var code: String
    @State private var info: String
    @Binding var isValid: Bool
    @State var hasError: Bool = false
    
    private var numberOfField: Int = 4
    @FocusState private var fieldFocus: Int?
    @State var enterValue: [String]
    @State var oldValue = ""
    let fieldWidth:CGFloat = CGFloat((Int(UIScreen.main.bounds.width)-75)/4)
    
    init(code: Binding<String>, info: String = "", isValid: Binding<Bool>) {
        self.info = info
        self._code = code
        self.enterValue = Array(repeating: "", count: numberOfField)
        self._isValid = isValid
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 15) {
                ForEach(0..<numberOfField, id: \.self) { index in
                    TextField("", text: $enterValue[index]) { editing in
                        if editing {
                            oldValue = enterValue[index]
                        }
                    }
                    .keyboardType(.numberPad)
                    .frame(width: fieldWidth, height: 1.5 * fieldWidth)
                    .font(.system(size: 44))
                    //.background(Colors.inputBackground)
                    .foregroundStyle(Colors.seccondary)
                    .accentColor(Colors.white)
                    .multilineTextAlignment(.center)
                    .focused($fieldFocus, equals: index)
                    .tag(index)
                    .textContentType(.oneTimeCode)
                    .onChange(of: enterValue[index]) { _ ,newValue in
                    
                        var currentValue = newValue
                        if currentValue.count > numberOfField {
                            currentValue = String(currentValue.prefix(numberOfField))
                        }
                             
                        if currentValue.count > 1 && currentValue.count <= numberOfField {
                            var i = index
                            for otpNumber in currentValue {
                                enterValue[i] = String(otpNumber)
                                if (numberOfField - 1 > i) {
                                    i += 1
                                }
                                fieldFocus = (fieldFocus ?? 0) + 1
                            }
                            updateOTPString()
                        } else {
                            if !currentValue.isEmpty {
                                if enterValue[index].count > 1 {
                                    let currentValue = Array(enterValue[index])
                                    
                                    if let oldValueFirstCharacter = oldValue.first {
                                        if currentValue[0] == Character(extendedGraphemeClusterLiteral: oldValueFirstCharacter) {
                                            enterValue[index] = String(enterValue[index].suffix(1))
                                        } else {
                                            enterValue[index] = String(enterValue[index].prefix(1))
                                        }
                                    }
                                }
                                     
                                if index == numberOfField - 1 {
                                    fieldFocus = nil
                                } else {
                                    fieldFocus = (fieldFocus ?? 0) + 1
                                }
                            } else {
                                fieldFocus = (fieldFocus ?? 0) - 1
                            }
                            updateOTPString()
                        }
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Colors.inputBackground)
                            .stroke(fieldFocus == index ? Colors.white : Colors.inputStroke, lineWidth: 2)
                    )
                }
            }
            
            if info.isNotEmpty {
                TextFactory.text(type: .regular(text: info, font: .reg11, color: hasError ? Colors.textError : Colors.seccondary))
                    .padding(.vertical, 2)
            }
        }.onDidLoad {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                enterValue = ["1", "2", "3", "4"]
                updateOTPString()
            }
        }
    }
    
    private func updateOTPString() {
        code = enterValue.joined()
        self.isValid = code.count == 4
    }

}

