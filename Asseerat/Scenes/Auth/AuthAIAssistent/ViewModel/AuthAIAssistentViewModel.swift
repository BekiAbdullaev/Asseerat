//
//  AuthAIAssistentViewModel.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 17/06/25.
//

import Foundation

struct AuthAIAssistentQuestion: Identifiable {
    let id = UUID()
    let text: String
}

struct AuthAIAssistentMessage: Identifiable, Equatable {
    let id = UUID()
    let text: String
    let isUser: Bool
    
    static func == (lhs: AuthAIAssistentMessage, rhs: AuthAIAssistentMessage) -> Bool {
        return lhs.id == rhs.id && lhs.text == rhs.text && lhs.isUser == rhs.isUser
    }
}

struct AuthAIAssistentViewModel {
    let questions = [
        AuthAIAssistentQuestion(text: "What's your favorite color?"),
        AuthAIAssistentQuestion(text: "What's your favorite food?"),
        AuthAIAssistentQuestion(text: "What's your favorite hobby?"),
        AuthAIAssistentQuestion(text: "Where would you like to travel?"),
        AuthAIAssistentQuestion(text: "What's your favorite movie?")
    ]
}
