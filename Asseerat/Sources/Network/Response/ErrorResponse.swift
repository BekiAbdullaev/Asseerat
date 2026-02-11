//
//  File.swift
//  
//
//  Created by Bekzod Abdullaev on 10/17/22.
//

import Foundation
public struct ErrorResponse {
    
    public var reason: String
    public var errorType: ErrorResponseType?
    public var statusCode:Int
    public var code:Int
    public var devMessage: String?
    
    public var name: String {
        switch self.errorType {
        case .internalServerError?:
            return "connection_error"
        default:
            return "error"
        }
    }
    
    public init (reason: String?, statusCode: Int?,code: Int?, devMessage: String? ) {
        
        self.reason = reason ?? ""
        self.devMessage = devMessage
        self.statusCode = statusCode ?? 400
        self.code = code ?? 0
        switch statusCode {
        case 500:
            self.errorType = .internalServerError(reason: "Произошла ошибка при подключении к серверу. Повторите попытку позже.")
        case 401:
            self.errorType = .defaultServerError(reason: "Token ustarel")
        case 502:
            self.errorType = .internalServerError(reason: "Что-то пошло не так, пожалуйста, повторите позже")
        case 503:
            self.errorType = .internalServerError(reason: "Проблема при подключении к системе.\nПожалуйста, обратитесь к администратору.")
        default:
            self.errorType = .defaultServerError(reason: reason ?? "")
        }
    }
    
}

public enum ErrorResponseType: Error {
    case defaultServerError(reason: String?)
    case internalServerError(reason: String)
}
