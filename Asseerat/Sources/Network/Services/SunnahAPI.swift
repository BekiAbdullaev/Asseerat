//
//  SunnahAPI.swift
//  Asseerat
//
//  Created by Nargiza Rahimova on 07/09/25.
//

import Foundation
import UIKit
import Moya

enum SunnahAPI {
    case getSunnahTypes(userId:String)
    case getSunnahTemplates
    case getClentHabits(userId:String)
    case addSunnah(body:AddHabitModel.Request.Add)
    //========
    case incrementHabitRecord(body:SunnahModel.Request.IncrementHabitRecord)
    case getHabitRecords(client_id:String, habit_id:Int, from_date:String, to_date:String)
    case editHabit(body:EditHabitModel.Request.EditHabit)
    case archiveHabit(id:String)
    case unarchiveHabit(id:String)
    case skipHabit(id:String)
    case unskipHabit(id:String)
    case deleteHabit(id:String)
    
}

// MARK: - TargetType Protocol Implementation
extension SunnahAPI: BaseService {
    var path: String {
        switch self {
        case.getSunnahTypes:
            return "habit-types/client/all"
        case .getSunnahTemplates:
            return "habit-templates/client/all"
        case let .getClentHabits(userId):
            return "habits/client/get/\(userId)"
        case .addSunnah:
            return "habits/client/add"
        case .incrementHabitRecord:
            return "habit-records/client/increment"
        case.getHabitRecords:
            return "habit-records/client/get"
        case.editHabit:
            return "habits/client/edit"
        case let .archiveHabit(id):
            return "habits/client/archive/\(id)"
        case let .unarchiveHabit(id):
            return "habits/client/unarchive/\(id)"
        case let .skipHabit(id):
            return "habits/client/skip/\(id)"
        case let .unskipHabit(id):
            return "habits/client/unskip/\(id)"
        case let .deleteHabit(id):
            return "habits/client/delete/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .addSunnah, .incrementHabitRecord:
            return .post
        case .editHabit, .archiveHabit, .unarchiveHabit, .skipHabit, .unskipHabit:
            return .put
        case .deleteHabit:
            return .delete
        default:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case let .getSunnahTypes(userId):
            return .requestParameters(parameters: ["client_id":userId], encoding: URLEncoding.default)
        case .getSunnahTemplates:
            return .requestPlain
        case .getClentHabits:
            return .requestPlain
        case let .addSunnah(body):
            return .requestJSONEncodable(body)
        case let .incrementHabitRecord(body):
            return .requestJSONEncodable(body)
        case let .getHabitRecords(client_id, habit_id, from_date, to_date):
            return .requestParameters(parameters: ["client_id":client_id, "habit_id":habit_id, "from_date":from_date, "to_date":to_date], encoding: URLEncoding.default)
        case let .editHabit(body):
            return .requestJSONEncodable(body)
        case .archiveHabit:
            return .requestPlain
        case .unarchiveHabit:
            return .requestPlain
        case .skipHabit:
            return .requestPlain
        case .unskipHabit:
            return .requestPlain
        case .deleteHabit:
            return .requestPlain
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
