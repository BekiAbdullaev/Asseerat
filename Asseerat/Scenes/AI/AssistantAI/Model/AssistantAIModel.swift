//
//  AssistantAIModel.swift
//  Asseerat
//
//  Created by Nargiza Rahimova on 13/09/25.
//

import Foundation

enum AssistantAIModel {
    struct Request{
        struct AIAskQuestion: Codable {
            let question: String
            let client_id: String
            let chat_id: Int?
            let theme_id: Int?
            let save_to_history:String?
            
            init(question: String, client_id: String, chat_id: Int?, theme_id: Int? = nil, save_to_history: String?) {
                self.question = question
                self.client_id = client_id
                self.chat_id = chat_id
                self.theme_id = theme_id
                self.save_to_history = save_to_history
            }
        }
    }
    
    struct Response {
        
        struct AIAskQuestionResponse:APIData {
            var code: Int?
            var msg: String?
            var body:ChatBody?
        }
        
        struct ClientChatResponse:APIData {
            var code: Int?
            var msg: String?
            var total: Int?
            var rows:[ChatRows]?
        }
        
        struct ClientMessageResponse:APIData {
            var code: Int?
            var msg: String?
            var total: Int?
            var rows:[ClientMessageRows]?
        }
    }
    
    struct ChatRows:Codable, Hashable {
        let id:Int?
        let name:String?
        let state:String?
        let created_at:String?
        let updated_at:String?
        let client_id:String?
    }
    
    struct ClientMessageRows:Codable, Hashable {
        let id:String?
        let client_id:String?
        let chat_id:Int?
        let request:String?
        let response:String?
        let state:Int?
        let created_at:String?
        let updated_at:String?
        
    }
}

struct ChatBody:Codable, Hashable {
    let chatId:Int?
    let createdAt:String?
    let aiResponse:ChatAIResponse?
    init(chatId: Int?, createdAt: String?, aiResponse: ChatAIResponse?) {
        self.chatId = chatId
        self.createdAt = createdAt
        self.aiResponse = aiResponse
    }
}

struct ChatAIResponse:Codable, Hashable {
    let code:Int?
    let answer:String?
    let recommendations:[String]?
    init(code: Int?, answer: String?, recommendations: [String]?) {
        self.code = code
        self.answer = answer
        self.recommendations = recommendations
    }
}
