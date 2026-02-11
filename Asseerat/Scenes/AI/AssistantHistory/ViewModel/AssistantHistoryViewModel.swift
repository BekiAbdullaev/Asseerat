//
//  AssistantHistoryViewModel.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 07/08/25.
//

import SwiftUI

class AssistantHistoryViewModel: ObservableObject {
  // var histories = ["How did Prophet Muhammad (S.A.W.)...", "What were the most important values...", "How did he approach decision-makin..."]
    
    func getClientChat(onComplete:@escaping(()->())) {
        let userID = SecurityBean.shared.userId
        NetworkManager(hudType: .noHud).request(AssistentAPI.getClientChat(userId: userID)) { (response:AssistantAIModel.Response.ClientChatResponse) in
            onComplete()
        } failure: { error in
            showTopAlert(title: error?.reason ?? "Something wrong...")
        }
    }
}
