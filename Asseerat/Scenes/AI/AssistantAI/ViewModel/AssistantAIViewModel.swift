//
//  AssistantAIViewModel.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 07/08/25.
//

import Foundation
import SwiftUI

struct AITypes:Hashable{
    let name:String
    let id:String
}

class AssistantAIViewModel: ObservableObject {
    let listGridColumns = [GridItem(.flexible())]
    @Published var listAITypes = [AITypes(name: "Vector", id: "0"),
                                  AITypes(name: "Stream", id: "1"),
                                  AITypes(name: "Global", id: "2"),
                                  AITypes(name: "Default",id: "3")]
    
    @Published var responseText: String = ""
    @Published var isStreaming: Bool = false
    private let networkManager: ChatStreamNetworkManager
    var modelID:String = ""
    
    
    init(networkManager: ChatStreamNetworkManager = ChatStreamNetworkManager()) {
        self.networkManager = networkManager
    }
    
    func stopStreaming() {
        networkManager.stop()
        isStreaming = false
    }
    

    func getClientChat(onComplete:@escaping(([AssistantAIModel.ChatRows])->())) {
        let userID = SecurityBean.shared.userId
        NetworkManager(hudType: .noHud).request(AssistentAPI.getClientChat(userId: userID)) { (response:AssistantAIModel.Response.ClientChatResponse) in
            let sorted = response.rows?.sorted{$0.created_at ?? "" > $1.created_at ?? ""}
            onComplete(sorted ?? [])
        } failure: { error in
            showTopAlert(title: error?.reason ?? "Something wrong...")
        }
    }
    
    func getClientMessage(chatID:String?, onComplete:@escaping(([AssistantAIModel.ClientMessageRows])->())) {
        NetworkManager(hudType: .noHud).request(AssistentAPI.getClientMessage(chatId: chatID)) { (response:AssistantAIModel.Response.ClientMessageResponse) in
            onComplete(response.rows ?? [])
        } failure: { error in
            showTopAlert(title: error?.reason ?? "Something wrong...")
        }
    }
    
    func deleteClientMessage(chatID:String, onComplete:@escaping(()->())) {
        NetworkManager(hudType: .noHud).request(AssistentAPI.deleteAIHistory(id: chatID)) { (response:DefaultResponse) in
            onComplete()
        } failure: { error in
            showTopAlert(title: error?.reason ?? "Something wrong...")
        }
    }
    
    
    func askQuestion(text:String, chatId:Int?, needSaveChat:String = "N", onComplete:@escaping((Int, String, [String])->())) {
        
        let userID = SecurityBean.shared.userId
        let reqBody = AssistantAIModel.Request.AIAskQuestion(question: text, client_id: userID, chat_id: chatId, save_to_history:needSaveChat)
        
        if getModelName() == "stream" {
            responseText = ""
            isStreaming = true
            var messages = ""
            networkManager.startStream(with: reqBody) { result in
                messages += result
            } onComplete: { result in
                switch result {
                case .success:
                    onComplete(chatId ?? 0, messages.removingChatID(), [])
                    self.stopStreaming()
                case .failure(let error):
                    self.stopStreaming()
                    showTopAlert(title: error.localizedDescription)
                }
            }
            
        } else {
            NetworkManager(hudType: .noHud).request(AssistentAPI.askAIQuestion(body: reqBody, modelName: self.getModelName())) { (response:AssistantAIModel.Response.AIAskQuestionResponse) in
    
                let chatId = response.body?.chatId
                let fullAnswer = response.body?.aiResponse?.answer ?? "Berilgan Savol bo'yicha menda ma'lumot yo'q"
                let recommendationsList = response.body?.aiResponse?.recommendations ?? []
                onComplete(chatId ?? 0, fullAnswer, recommendationsList)
                
            } failure: { error in
                showTopAlert(title: error?.reason ?? "Something wrong...")
            }
        }
    }
    
    private func getModelName() -> String {
        switch modelID {
        case "0":
            return "vector"
        case "1":
            return "stream"
        case "2":
            return "global"
        default :
            return ""
        }
    }
}
