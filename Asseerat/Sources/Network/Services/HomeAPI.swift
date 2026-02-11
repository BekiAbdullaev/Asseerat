//
//  HomeAPI.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 03/09/25.
//

import Foundation
import UIKit
import Moya

enum HomeAPI {
    case getHomeAllGroups
    case getHomeGroupItem(groupId:String)
    
    case getAllAR
    case getClientAR(arID:String)
    
    case getMapsAndLocationsAll
    case getMapsAndLocationsClient(id:String)
    case downloadMapsAndLocations(hashId:String)
    
}

// MARK: - TargetType Protocol Implementation
extension HomeAPI: BaseService {
    var path: String {
        switch self {
        case .getHomeAllGroups:
            return "hm-groups/client/all"
        case let .getHomeGroupItem(groupId):
            return "hm-groups-items/client/get/\(groupId)"
        case .getAllAR:
            return "ar-experiences/client/all"
        case let .getClientAR(arID):
            return "ar-experiences/client/get/\(arID)"
        case .getMapsAndLocationsAll:
            return "maps-and-locations/client/all"
        case let .getMapsAndLocationsClient(id):
            return "maps-and-locations/client/get/\(id)"
        case let .downloadMapsAndLocations(hashId):
            return "maps-and-locations/client/download/\(hashId)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .getHomeAllGroups:
            return .requestPlain
        case .getHomeGroupItem:
            return .requestPlain
        case .getAllAR:
            return .requestPlain
        case .getClientAR:
            return .requestPlain
        case .getMapsAndLocationsAll, .getMapsAndLocationsClient, .downloadMapsAndLocations:
            return .requestPlain
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
        case .getAllAR, .getClientAR, .getMapsAndLocationsAll, .getMapsAndLocationsClient, .downloadMapsAndLocations:
            header.updateValue("Bearer \(SecurityBean.shared.token)", forKey: "Authorization")
            return header
        default:
            return header
        }
    }
    
}
