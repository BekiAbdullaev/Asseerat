//
//  TextFieldFactory.swift
//  NewIOSApp
//
//  Created by Bekzod Abdullaev on 11/06/25.
//

import Foundation
import SwiftUI

public struct TextFieldFactory {
    @ViewBuilder
    static public func textField(type: TextFieldTypes) -> some View {
        switch type {
        case .phone9(let title, let info, let number, let isValid):
            TextFieldPhone9(title: title, info: info, number: number, isValid: isValid)
                .padding(.horizontal, 0.5)
        case .phone12(let title, let info, let number, let isValid):
            TextFieldPhone12(title: title, info: info, number: number, isValid: isValid)
                .padding(.horizontal, 0.5)
        case .sms(let info, let code, let isValid):
            TextFieldSMS(code: code, info: info, isValid: isValid)
                .padding(.horizontal, 0.5)
        case .date(let title, let date, let isValid, let hasError):
            TextFieldDate(title: title, date: date, isValid: isValid, hasError: hasError)
                .padding(.horizontal, 0.5)
        case .password(let title, let info, let text, let isValid, let hasError, let passwordMissmatch, let passwordValidationString):
            TextFieldPassword(title: title, info: info, text: text, isValid: isValid, hasError: hasError, passwordMissmatch: passwordMissmatch, passwordValidationString: passwordValidationString)
        case .email(let title, let info, let email, let hasError, let isValid):
            TextFieldEmail(title: title, info: info, number: email, hasError: hasError, isValid: isValid)
                .padding(.horizontal, 0.5)
        case .defaultTF(let title, let placeholder, let info, let text, let keyboard, let charactersCount, let hasError, let didEndEditing):
            TextFieldDefault(title: title, placeholder: placeholder, info: info, text: text, keyboard: keyboard, characterCount: charactersCount, hasError: hasError, didEndEditing: didEndEditing)
                .padding(.horizontal, 0.5)
        }
    }
}


public enum TextFieldFormatType {
    case phoneNumber9
    case phoneNumber12
    case sms
    case date
    case none
    
   public func getFormatType() -> String {
        return switch self {
        case .phoneNumber9:
            "998 ## ### ## ##"
        case .phoneNumber12:
            "### ## ### ## ##"
        case .sms:
            "#  #  #  #  #  #  #  #"
        case .date:
            "##.##.####"
        case .none:
            "########################"
        }
    }
}

public enum TextFieldTypes {
    case phone9(title: String, info: String = "", number: Binding<String>, isValid: Binding<Bool>)
    case phone12(title: String, info: String = "", number: Binding<String>, isValid: Binding<Bool>)
    case sms(info: String = "", code: Binding<String>, isValid: Binding<Bool>)
    case date(title: String, date: Binding<String>, isValid: Binding<Bool>, hasError: Binding<Bool> = .constant(false))
    case password(title: String, info: String = "", text: Binding<String>, isValid: Binding<Bool>, hasError: Binding<Bool> = .constant(false), passwordMissmatch: Binding<Bool> = .constant(false), passwordValidationString: Binding<String>)
    case email(title: String, info: String = "", email: Binding<String>, hasError: Binding<Bool> = .constant(false), isValid: Binding<Bool>)
    case defaultTF(title: String, placeholder: String = "", info: String = "", text: Binding<String>, keyboard: UIKeyboardType = .default, charactersCount: Int? = nil, hasError: Binding<Bool> = .constant(false), didEndEditing: () -> () = {})
}
