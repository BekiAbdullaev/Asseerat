//
//  AssistantHistoryView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 07/08/25.
//

import SwiftUI

struct AssistantHistoryView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject private var viewModel = AssistantHistoryViewModel()
    
    @State private var userChats:[AssistantAIModel.ChatRows]
    private var onClick:(Int) -> Void
    private var onDelete:(Int) -> Void
    
    init(userChats:[AssistantAIModel.ChatRows], onClick: @escaping (Int) -> Void, onDelete: @escaping (Int) -> Void) {
        self.userChats = userChats
        self.onClick = onClick
        self.onDelete = onDelete
    }
    
    var body: some View {
        VStack {
            self.navigationView()
            if userChats.isEmpty {
                EmptyView(title: Localize.noChatHistoryTitle, subtitle: Localize.noChatHistorySubtitle)
            } else {
                self.bodyView()
            }
           
        }.background(Colors.background)
    }
    
    @ViewBuilder
    private func bodyView() -> some View {
        ScrollView(.vertical, showsIndicators: false){
            ForEach(userChats, id: \.self) { chat in
                AssistantHistoryItemView(title: chat.name ?? "", onClick: {
                    onClick(chat.id ?? 0)
                    self.presentationMode.wrappedValue.dismiss()
                }, onDelete: {
                    infoActionAlert(title: Localize.deleteChatActionTittle, subtitle: Localize.deleteChatActionSubtittle, lBtn: Localize.back, rBtn: Localize.delete) {
                        self.onDelete(chat.id ?? 0)
                        self.deleteChat(id: chat.id ?? 0)
                    }
                }).padding(.bottom, 5)
            }
        }
    }
    
    @ViewBuilder
    private func navigationView() -> some View {
        ZStack {
            TextFactory.text(type: .regular(text: Localize.chatHistory, font: .reg20))
            
            HStack(alignment:.center, spacing:10){
                ButtonFactory.button(type: .roundedWhite(image: "ic_gray_cancel", onClick: {
                    self.presentationMode.wrappedValue.dismiss()
                })).padding(.leading, 14)
                Spacer()
            }
        }.frame(height: 42).frame(maxWidth:.infinity).padding(.vertical,16)
    }
    
    private func deleteChat(id:Int) {
        self.userChats.removeAll(where: {$0.id == id})
    }
}
