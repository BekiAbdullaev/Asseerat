//
//  Auth.swift
//  NewIOSApp
//
//  Created by Bekzod Abdullaev on 11/06/25.
//

import SwiftUI

extension MainRouter {
    enum Auth {
        case launch
        case onboarding
        case login
        case forgetPassword(passInitType:PasswordInitType)
        case forgetPasswordOTP(phone:String)
        case setPassword(type:PasswordType)
        case signUp
        case authAiAssistent
        case tabView
    }
    
    @ViewBuilder
    public func AuthRoute(_ type: Auth)-> some View {
        switch type {
        case .launch:
            LaunchView()
        case .onboarding:
            OnboardingView()
        case .login:
            LoginView()
        case .forgetPassword(let type):
            ForgetPasswordView(type: type)
        case .forgetPasswordOTP(let phone):
            ForgetPasswordOTP(phone: phone)
        case .setPassword(let type):
            ResetPasswordView(type: type)
        case .signUp:
            SignUpView()
        case .authAiAssistent:
            AuthAIAssistentView()
        case .tabView:
            MainTabView()
        }
    }
}
