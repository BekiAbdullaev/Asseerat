//
//  AuthAIAssistentChatBubble.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 17/06/25.
//

import SwiftUI

struct AIAssistentChatBubble: View {
    let text: String
    let isUser: Bool
    
    var body: some View {
        HStack {
            if isUser {
                Spacer()
                Text(text)
                    .padding()
                    .font(.system(size: 14,weight: .regular))
                    .background(Colors.green)
                    .foregroundColor(Colors.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .frame(maxWidth: 300, alignment: .trailing)
            } else {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Asseerat AI")
                        .font(.caption)
                        .foregroundColor(.green)
                        .padding(.horizontal, 5)
                    Text(text)
                        .padding()
                        .background(Colors.green)
                        .foregroundColor(Colors.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .frame(maxWidth: 300, alignment: .leading)
                }
                Spacer()
            }
        }
    }
}
