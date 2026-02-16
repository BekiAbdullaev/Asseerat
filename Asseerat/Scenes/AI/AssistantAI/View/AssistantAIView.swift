//
//  AIAssistentView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 18/06/25.
//

// MARK: - Main View
import SwiftUI

// MARK: - Message Model
struct Message: Identifiable, Hashable {
    let id: UUID
    var content: String
    let isCurrentUser: Bool
    let timestamp: Date
    var isStreaming: Bool

    init(content: String,
         isCurrentUser: Bool,
         timestamp: Date,
         id: UUID = UUID(),
         isStreaming: Bool = false) {
        self.id = id
        self.content = content
        self.isCurrentUser = isCurrentUser
        self.timestamp = timestamp
        self.isStreaming = isStreaming
    }
}

// MARK: - Main View
struct AssistantAIView: View {
    @EnvironmentObject var coordinator: Coordinator<MainRouter>
    @ObservedObject private var viewModel = AssistantAIViewModel()
    
    @State private var messages: [Message] = []
    @State private var topTitle = ""
    @State private var userAnswer = ""
    @State private var textEditorHeight: CGFloat = 40
    @State private var pendingMessage: Message? = nil
    @State private var needChatHistory = false
    @State private var needAIType = false
    @State private var chatId:Int? = nil
    @State private var needSaveChat:String = "N"
    
    @State private var scrollProxy: ScrollViewProxy? = nil
    @State private var typingTimers: [UUID: Timer] = [:]

    private let tokenInterval: TimeInterval = 0.035
    @State private var userChats:[AssistantAIModel.ChatRows] = []
    @State private var recommendationsList:[String] = []
    
    public var isGlobalChat:Bool = true
    public var firstPrompt:String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            if isGlobalChat {
                navigationView()
            }
            if MainBean.shared.userSignedIn() {
                bodyMessages()
                recommendations()
                textInputView()
            } else {
                EmptyView(title: Localize.registerRequiredTitle, subtitle: Localize.registerRequiredSubtitle, type: .signIn) {
                    UDManager.shared.clear()
                    coordinator.dismiss {
                        self.coordinator.popToRoot()
                    }
                }
            }
        }
        .background(Colors.background)
        .navigationBarHidden(isGlobalChat)
        .navigationTitle(Localize.aiAssistant)
        .onDidLoad {
            if isGlobalChat {
                self.topTitle = Localize.whatCanIDo
                self.getAllClientChats()
            } else {
                self.topTitle = String(format: Localize.letChatAbout, firstPrompt)
                userAnswer = String(format: Localize.tellAbout, firstPrompt)
                self.viewModel.modelID = "0"
                submitAnswer()
            }
            if UDManager.shared.getString(key: .aiType) == "" {
                UDManager.shared.setSting(key: .aiType, object: "0")
                self.viewModel.modelID = "0"
            } else {
                self.viewModel.modelID = UDManager.shared.getString(key: .aiType)
            }
        }
        .onDisappear {
            typingTimers.values.forEach { $0.invalidate() }
            typingTimers.removeAll()
        }
        .presentModal(displayPanModal: $needChatHistory, viewHeight: 0.9) {
            AssistantHistoryView(userChats: userChats) { chatID in
                self.viewModel.getClientMessage(chatID: "\(chatID)") { messages in
                    self.chatId = chatID
                    self.setMessages(messages)
                }
            } onDelete: { chatID in
                let chatID:String = String(chatID)
                self.viewModel.deleteClientMessage(chatID: chatID) {
                    self.topTitle = Localize.whatCanIDo
                    self.getAllClientChats()
                }
            }
        }
        .presentModal(displayPanModal: $needAIType) {
            AssistentAITypeView(listId: self.viewModel.modelID, vmModel: self.viewModel) { modelID in
                self.viewModel.modelID = modelID
                UDManager.shared.setSting(key: .aiType, object: modelID)
            }
        }
    }
}

// MARK: - Subviews va yordamchi funksiyalar
extension AssistantAIView {
    
    private func setMessages(_ messages: [AssistantAIModel.ClientMessageRows]) {
        self.messages.removeAll()
        for message in messages {
            let userMesage =  Message(content: message.request ?? "", isCurrentUser: true, timestamp: Date())
            self.messages.append(userMesage)
            
            let aiId = UUID(uuidString: message.id ?? "")
            let responseMessage = Message(content: message.response ?? "", isCurrentUser: false, timestamp: Date(), id: aiId ?? UUID(), isStreaming: true)
            self.messages.append(responseMessage)
        
        }
    }
    
    private func scrollToBottom() {
        guard let proxy = scrollProxy else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            if let lastId = (pendingMessage?.id ?? messages.last?.id) {
                withAnimation {
                    proxy.scrollTo(lastId, anchor: .bottom)
                }
            }
        }
    }
    
    private func getAllClientChats() {
        self.viewModel.getClientChat { chats in
            if !chats.isEmpty {
                self.userChats = chats
                if let chatID = chats.first?.id {
                    self.chatId = chatID
                    self.viewModel.getClientMessage(chatID: "\(chatID)") { messages in
                        self.setMessages(messages)
                    }
                }
            } else {
                self.needSaveChat = "Y"
            }
        }
    }
    
    @ViewBuilder
    private func navigationView() -> some View {
        ZStack {
            HStack {
                ButtonFactory.button(type: .roundedWhite(image: "ic_back", onClick: {
                    coordinator.dismiss()
                }))
                ButtonFactory.button(type: .roundedWhite(image: "ic_drag_drop", onClick: {
                    needAIType.toggle()
                }))
                Spacer()
                
                ButtonFactory.button(type: .roundedWhite(image: "ic_new_chat", onClick: {
                    typingTimers.values.forEach { $0.invalidate() }
                    typingTimers.removeAll()
                    messages.removeAll()
                    pendingMessage = nil
                    self.chatId = nil
                    self.needSaveChat = "Y"
                }))
                ButtonFactory.button(type: .roundedWhite(image: "ic_repeat", onClick: {
                    needChatHistory.toggle()
                }))
            }
            .padding(.horizontal)
            
            HStack {
                Image("ic_ai")
                    .resizable()
                    .frame(width: 18, height: 18)
                TextFactory.text(type: .regular(text: Localize.aiAssistant, font: .reg14)).padding(.vertical, 8)
            }
            .padding(.horizontal, 12)
            .background(Capsule().fill(Colors.green))
        }
        .frame(height: 42)
        .padding(.top, 8)
    }
    
    @ViewBuilder
    private func bodyMessages() -> some View {
        ScrollViewReader { proxy in
            Color.clear
                .frame(height: 0)
                .onAppear { scrollProxy = proxy }
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 8) {
                    TextFactory.text(type: .regular(text: topTitle, font: .reg20, line: 3))
                        .multilineTextAlignment(.center)
                        .lineSpacing(10)
                        .padding(.horizontal, 40)
                        .padding(.bottom, 20).padding(.top, 10)
                    ForEach(messages) { message in
                        MessageBubble(message: message)
                            .id(message.id)
                    }
                    if let pending = pendingMessage {
                        LoadingIndicator()
                            .id(pending.id)
                    }
                }
                .padding(.vertical, 10)
            }
            .onChange(of: messages) { _, _ in
                scrollToBottom()
            }
            .onChange(of: pendingMessage) { _, _ in
                scrollToBottom()
            }
        }.onTapGesture { keyboardEndEditing() }
    }
    
    @ViewBuilder
    private func recommendations() -> some View {
        if !recommendationsList.isEmpty {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(self.recommendationsList, id: \.self) { item in
                        TextItemView(text: item)
                            .onTapGesture {
                                userAnswer = item
                                submitAnswer()
                                self.recommendationsList.removeAll()
                            }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
            }
        }
    }
    
    @ViewBuilder
    private func textInputView() -> some View {
        HStack(alignment: .center, spacing: 5) {
            ZStack(alignment: .leading) {
                
                Text(userAnswer.isEmpty ? " " : userAnswer)
                    .font(.system(size: 18))
                    .lineLimit(6)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(GeometryReader { geometry in
                        Color.clear
                            .onChange(of: userAnswer) { (_,_)  in
                                let newHeight = min(max(40, geometry.size.height), 120)
                                if abs(textEditorHeight - newHeight) > 1 {
                                    textEditorHeight = newHeight
                                }
                            }
                    })
                    .opacity(0)

                TextEditor(text: $userAnswer)
                    .scrollContentBackground(.hidden) // <- Hide it
                    .background(.clear) // To see this
                    .font(.system(size: 16))
                    .padding(.horizontal, 13)
                    .padding(.top, 3)
                    .frame(height: textEditorHeight)
                    .foregroundColor(.white)
                    .scrollIndicators(.hidden)
                    .autocorrectionDisabled()
                
                   
                if userAnswer.isEmpty {
                    HStack {
                        TextFactory.text(type: .regular(text: Localize.sendMessage, font: .reg16, color: .seccondary, line: 1)).padding(.horizontal, 16)
                        Spacer()
                    }
                }
            }
            
            Button(action: submitAnswer) {
                Image("ic_top_row")
            }.frame(width: 36, height: 36, alignment: .center)
                .background(
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                ).foregroundColor(Colors.white)
            .disabled(userAnswer.isEmpty)
            .padding()
            
            
        }.frame(maxWidth:.infinity).frame(height: textEditorHeight + 25)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
            ).foregroundColor(Colors.green).padding([.horizontal, .bottom], 10)
    }
}

// MARK: - Submit + Streaming
extension AssistantAIView {
    private func submitAnswer() {
        guard !userAnswer.isEmpty else { return }
        let question = userAnswer.trimmingCharacters(in: .whitespacesAndNewlines)
        let userMessage = Message(content: question, isCurrentUser: true, timestamp: Date())
        
        messages.append(userMessage)
        userAnswer = ""
        pendingMessage = Message(content: Localize.thinking, isCurrentUser: false, timestamp: Date())
        needSaveChat = isGlobalChat ? "Y" : "N"
        
        viewModel.askQuestion(text: question, chatId: self.chatId, needSaveChat: needSaveChat) { (chatID, fullAnswer, recommendations) in
            self.chatId = chatID
            recommendationsList = recommendations
            
            DispatchQueue.main.async {
                pendingMessage = nil
                
                let aiId = UUID()
                let placeholder = Message(content: "", isCurrentUser: false, timestamp: Date(), id: aiId, isStreaming: true)
                messages.append(placeholder)
                scrollToBottom()

                startStreaming(answer: fullAnswer, for: aiId)
            }
         
        }
    }
    
    private func startStreaming(answer: String, for messageId: UUID) {
        var tokens = answer.split(separator: " ").map(String.init)
        if tokens.isEmpty { tokens = [answer] }
        
        let timer = Timer.scheduledTimer(withTimeInterval: tokenInterval, repeats: true) { t in
            guard let idx = messages.firstIndex(where: { $0.id == messageId }) else {
                t.invalidate()
                typingTimers[messageId] = nil
                return
            }
            if tokens.isEmpty {
                messages[idx].isStreaming = false
                t.invalidate()
                typingTimers[messageId] = nil
                return
            }
            
            let next = tokens.removeFirst()
            if messages[idx].content.isEmpty {
                messages[idx].content = next
            } else {
                messages[idx].content += " " + next
            }
            scrollToBottom()
        }
        typingTimers[messageId] = timer
    }
}

struct TextItemView: View {
    let text: String
    var body: some View {
        Text(text)
            .frame(width: UIScreen.main.bounds.width * 0.55)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(RoundedRectangle(cornerRadius: 16).fill(Colors.green))
            .foregroundColor(Colors.white)
            .font(.system(size: 12))
            .lineLimit(2)
//            .fixedSize(horizontal: false, vertical: true)
//            .frame(maxWidth: UIScreen.main.bounds.width * 0.6, alignment: .leading)
    }
}

struct MessageBubble: View {
    let message: Message
    var body: some View {
        HStack {
            if message.isCurrentUser { Spacer() }
            Text(message.content)
                .padding(16)
                .font(.system(size: 14))
                .foregroundColor(.white)
                .background(message.isCurrentUser ? Colors.green : .clear)
                .cornerRadius(12)
                .lineSpacing(8)
                .animation(.linear(duration: 0.02), value: message.content) // kichik animatsiya
            if !message.isCurrentUser { Spacer() }
        }
        .padding(.horizontal, 8)
        .transition(.asymmetric(
            insertion: .move(edge: .bottom).combined(with: .opacity),
            removal: .opacity
        ))
    }
}

struct LoadingIndicator: View {
    @State private var colorPhase: CGFloat = 0.3
    
    var body: some View {
        HStack {
            Image("ic_ai")
                .foregroundColor(.white)
                .font(.system(size: 14))

            Text(Localize.thinking)
                .foregroundColor(Color(white: Double(colorPhase)))
                .font(.caption)
                .animation(
                    Animation.easeInOut(duration: 1.0)
                        .repeatForever(autoreverses: true),
                    value: colorPhase
                )
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
        .transition(.asymmetric(
            insertion: .move(edge: .bottom).combined(with: .opacity),
            removal: .opacity
        ))
        .onAppear {
            colorPhase = 1.0
        }
    }
}
