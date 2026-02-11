//
//  AIRouter.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 18/06/25.
//

import Foundation
import SwiftUI

extension MainRouter {
    enum AIAssistent {
        case aichat(isGlobalChat:Bool = true, firstPrompt:String = "")
    }
    
    @ViewBuilder
    public func AIRouter(_ type: AIAssistent)-> some View {
        switch type {
        case .aichat(let isGlobalChat, let firstPrompt):
            AssistantAIView(isGlobalChat: isGlobalChat, firstPrompt: firstPrompt)
        }
    }
}
