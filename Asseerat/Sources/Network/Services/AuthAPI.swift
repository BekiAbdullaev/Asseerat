//
//  File.swift
//  MyLibrary
//
//  Created by Bekzod Abdullaev on 02/06/25.
//

import Foundation
import UIKit
import Moya

enum AuthAPI {
    case registration(body: SignUpModel.Request.Registration)
    case login(body:LoginModel.Request.SignIn)
    case chackVersion(body:LoginModel.Request.VersionCheck)
    case resetPassword(body:ForgetPasswordModel.Request.Password)
    case resetPasswordVerify(body:ForgetPasswordModel.Request.PasswordVerify)
}

// MARK: - TargetType Protocol Implementation
extension AuthAPI: BaseService {
    var path: String {
        switch self {
        case .registration:
            return "register"
        case .login:
            return "sign-in"
        case .chackVersion:
            return "versions/check"
        case .resetPassword:
            return "reset-password"
        case .resetPasswordVerify:
            return "reset-password-verify"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Task {
        switch self {
        case let .registration(body):
            return .requestJSONEncodable(body)
        case let .login(body):
            return .requestJSONEncodable(body)
        case let .chackVersion(body):
            return .requestJSONEncodable(body)
        case let .resetPassword(body):
            return .requestJSONEncodable(body)
        case let .resetPasswordVerify(body):
            return .requestJSONEncodable(body)
        }
    }
    
    var sampleData: Data {
        //TODO: Add real sample data for test cases!!!
        return Data()
    }
    
    var headers: [String : String]? {
        var header: [String: String] = ["Accept": "application/json",
                                        "Content-Type": "application/json",
                                        "Accept-Language":UDManager.shared.getString(key: .currentLanguageKey),
                                        "devicecode":SecurityBean.shared.getDeviceID(),
                                        "device":"I",
                                        "version": "1"]
        switch self {
        case .chackVersion:
            header.updateValue("Bearer \(SecurityBean.shared.token)", forKey: "Authorization")
            return header
        default:
            return header
        }
    }
}
