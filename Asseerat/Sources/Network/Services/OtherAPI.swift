//
//  OtherAPI.swift
//  Asseerat
//
//  Created by Nargiza Rahimova on 06/09/25.
//

import Foundation
import UIKit
import Moya

enum OtherAPI {
    case getPrayTiming(lati:Double, long:Double, date:String)
    case getPrayTimingRange(lati:Double, long:Double, startDate:String, endDate:String)
    case getDeviceList(userId:String)
    case deleteAccount(userId:String)
    case editUserInfo(body:ProfileEditModel.Request.EditUserInfo)
    case getCities(name:String)
}

// MARK: - TargetType Protocol Implementation
extension OtherAPI: BaseService {
    var path: String {
        switch self {
        case .getPrayTiming:
            return "pray-timings"
        case .getPrayTimingRange:
            return "pray-timings/by-range"
        case let .getDeviceList(userID):
            return "user-devices/\(userID)"
        case let .deleteAccount(userID):
            return "users/client/delete-account/\(userID)"
        case .editUserInfo:
            return "users/client/edit-acc-info"
        case .getCities:
            return "cities/client/get"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPrayTiming, .getPrayTimingRange, .getDeviceList,.getCities:
            return .get
        case .deleteAccount:
            return .delete
        case .editUserInfo:
            return .put
        }
       
    }
    
    var task: Task {
        switch self {
        case let .getCities(name):
            return .requestParameters(parameters: ["name":name], encoding: URLEncoding.default)
        case let .getPrayTiming(lati, long, date):
            return .requestParameters(parameters: ["latitude":lati,"longitude":long,"date":date], encoding: URLEncoding.default)
        case let .getPrayTimingRange(lati, long, start, end):
            return .requestParameters(parameters: ["latitude":lati,"longitude":long,"date_from":start, "date_to":end], encoding: URLEncoding.default)
        case .getDeviceList:
            return .requestPlain
        case let .editUserInfo(body):
            return .requestJSONEncodable(body)
        case .deleteAccount:
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
        case .getDeviceList, .editUserInfo, .deleteAccount, .getCities :
            header.updateValue("Bearer \(SecurityBean.shared.token)", forKey: "Authorization")
            return header
        default:
            return header
        }
    }

}
