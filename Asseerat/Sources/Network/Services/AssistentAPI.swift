//
//  AssistentAPI.swift
//  Asseerat
//
//  Created by Nargiza Rahimova on 13/09/25.
//

import Foundation
import UIKit
import Moya

enum AssistentAPI {
    case askAIQuestion(body:AssistantAIModel.Request.AIAskQuestion, modelName:String)
    case getClientChat(userId:String)
    case getClientMessage(chatId:String?)
    case deleteAIHistory(id:String)
}

// MARK: - TargetType Protocol Implementation
extension AssistentAPI: BaseService {
    var path: String {
        switch self {
        case let .getClientChat(userId):
            return "client-chats/client/get/\(userId)"
        case let .getClientMessage(chatId):
            if let chatId = chatId {
                return "client-messages/get/\(chatId)"
            } else {
                return "client-messages/get"
            }
        case let .askAIQuestion(_, model):
            return model.isEmpty ? "ai/ask-question" : "ai/ask-question/\(model)"
        case let .deleteAIHistory(id):
            return "client-chats/client/delete-history/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .askAIQuestion:
            return .post
        case .deleteAIHistory:
            return .delete
        default:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getClientChat:
            return .requestPlain
        case .getClientMessage:
            return .requestPlain
        case let .askAIQuestion(body,_):
            return .requestJSONEncodable(body)
        case .deleteAIHistory:
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
