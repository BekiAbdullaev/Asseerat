//
//  DhikrAPI.swift
//  Asseerat
//
//  Created by Nargiza Rahimova on 13/09/25.
//

import Foundation
import UIKit
import Moya

enum DhikrAPI {
    case getDhikrTemplates(userId:String)
    case addDhikrTemplates(body:DhikrCounterModel.AddDhikr)
    case deleteDhikrTemplates(clientId:String, id:String)
    
    case getBindedDhikrs(userId:String)
    case getBindedDhikrsStatistics(userId:String, period:String)
    case bindDhikr(body:DhikrsModel.Request.DhikrBind)
    case unbindDhikr(id:String)
    case incrementBindedDhikr(body:DhikrsModel.Request.DhikrIncrement)
}

// MARK: - TargetType Protocol Implementation
extension DhikrAPI: BaseService {
    var path: String {
        switch self {
        case let .getDhikrTemplates(userId):
            return "dhikr-templates/client/get/\(userId)"
        case .addDhikrTemplates:
            return "dhikr-templates/client/add"
        case let .deleteDhikrTemplates(clientId, id):
            return "dhikr-templates/client/delete/\(clientId)/\(id)"
            
        case let .getBindedDhikrs(userId):
            return "dhikr-binds/client/get/\(userId)"
        case let .getBindedDhikrsStatistics(userId, period):
            return "dhikr-binds/client/statistics/\(userId)/\(period)"
        case .bindDhikr:
            return "dhikr-binds/client/bind"
        case let .unbindDhikr(id):
            return "dhikr-binds/client/unbind/\(id)"
        case .incrementBindedDhikr:
            return "dhikr-binds/client/increment"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .addDhikrTemplates, .bindDhikr, .incrementBindedDhikr, .unbindDhikr:
            return .post
        case .deleteDhikrTemplates:
            return .delete
        default:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getDhikrTemplates:
            return .requestPlain
        case let .addDhikrTemplates(body):
            return .requestJSONEncodable(body)
        case .deleteDhikrTemplates:
            return .requestPlain
            
        case .getBindedDhikrs:
            return .requestPlain
        case .getBindedDhikrsStatistics:
            return .requestPlain
        case let .bindDhikr(body):
            return .requestJSONEncodable(body)
        case .unbindDhikr:
            return .requestPlain
        case let .incrementBindedDhikr(body):
            return .requestJSONEncodable(body)
        }
    }
    
    var sampleData: Data {
        //TODO: Add real sample data for test cases!!!
        return Data()
    }
    
    var headers: [String : String]? {
        
        let header: [String: String] = ["Accept": "application/json",
                                        "Content-Type": "application/json",
                                        "Accept-Language":UDManager.shared.getString(key: .currentLanguageKey),
                                        "devicecode":SecurityBean.shared.getDeviceID(),
                                        "Authorization":"Bearer \(SecurityBean.shared.token)",
                                        "device":"I",
                                        "version": "1"]
        return header
    }
}
