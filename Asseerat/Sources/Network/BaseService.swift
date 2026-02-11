//
//  File.swift
//  MyLibrary
//
//  Created by Bekzod Abdullaev on 02/06/25.
//

import Foundation
import Moya
import UIKit

public protocol BaseService:TargetType, AccessTokenAuthorizable{}

extension BaseService {
    public var environmentBaseURL:String {
        switch NetworkConfig().baseURL {
        case .production:
            return "http://194.135.85.227:8081/api/"
        case .debug:
            return "custom api"
        case .custom:
            return "custom api"
        }
    }
    
    public var baseURL: URL {
        guard let url = URL(string:environmentBaseURL) else { fatalError("Base url could not be configured") }
        return url
    }
    
    public var sampleData: Data {
        Data()
    }
    public var headers: [String: String]? {
        let header: [String: String] = [ "Accept": "application/json",
                                         "Content-Type": "application/json",
                                         "Accept-Language": UDManager.shared.getString(key: .currentLanguageKey),
                                         //"Authorization": "Bearer \(MainBean.shared.token)",
                                         "devicecode": SecurityBean.shared.getDeviceID(),
                                         "device": "I"]
        return header
    }
    
    public var authorizationType: AuthorizationType? {
        return .bearer
    }
}


public enum APIBase {
    case debug
    case production
    case custom
}

public struct NetworkConfig {
    public var baseURL: APIBase
    
    public init(baseURL:APIBase = .production) {
        self.baseURL = baseURL
    }
}

enum NetworkPlugins:PluginType{
    case Logger
    case Hud
    case Authorized
    
    var plugin:PluginType{
        switch self {
        case .Authorized:
            return RequestLoadingPlugin()
        case .Logger:
            return NetworkLoggerPlugin(
                configuration: .init(
                    formatter: .init(),
                    output: NetworkLoggerPlugin.Configuration.defaultOutput(target:items:),
                    logOptions: .verbose))
        case .Hud:
            return RequestLoadingPlugin()
        }
    }
}
