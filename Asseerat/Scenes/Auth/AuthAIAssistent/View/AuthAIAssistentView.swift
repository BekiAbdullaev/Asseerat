//
//  AuthAIAssistentView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 16/06/25.
//

import SwiftUI

struct AuthAIAssistentView: View {
    
    @EnvironmentObject var coordinator: Coordinator<MainRouter>
    private var viewModel = AuthAIAssistentViewModel()
    @State private var currentQuestionIndex = 0
    @State private var userAnswer = ""
    @State private var messages: [AuthAIAssistentMessage] = []
    @State private var answers: [String: String] = [:]
    @State private var isReady:Bool = true
    @FocusState private var isInputFocused: Bool
    
    var body: some View {
        VStack {
            self.navigationView()
            ScrollView(.vertical, showsIndicators: false){
                TextFactory.text(type: .regular(text: "Let's get to know\neach other!", font: .reg20, line: 2))
                    .multilineTextAlignment(.center)
                    .lineSpacing(5)
                self.bodyView()
            }.frame(maxHeight: .infinity)
                .onTapGesture {
                keyboardEndEditing()
            }
            self.textInputView()
        }.background(Colors.background)
            .navigationBarHidden(true)
            .onAppear {
                self.initFuncs()
            }
    }
    
    private func initFuncs(){
        self.isInputFocused = true
        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
            messages.append(AuthAIAssistentMessage(text: "Hi! 👋 Let me remember you so that I can recognize you at first sight next time!", isUser: false))
            if !viewModel.questions.isEmpty {
                messages.append(AuthAIAssistentMessage(text: viewModel.questions[0].text, isUser: false))
            }
        }
    }
    
    @ViewBuilder
    private func navigationView() -> some View {
        ZStack {
            HStack(alignment:.center){
                Image("ic_ai")
                    .resizable()
                    .frame(width: 18, height: 18, alignment: .center)
                TextFactory.text(type: .regular(text: "AI Assistent", font: .reg14))
            }.padding(.horizontal)
            .background(
                Capsule().fill(Colors.green).frame(height: 30)
            )
            if currentQuestionIndex < viewModel.questions.count {
                HStack{
                    Spacer()
                    Button(action: clickSkip) {
                        TextFactory.text(type: .medium(text: "Skip", font: .med18, line: 1))
                    }.padding(.trailing,16)
                }
            }
        }.frame(height: 50).frame(maxWidth:.infinity)
    }

    @ViewBuilder
    private func bodyView() -> some View {
        ScrollViewReader { scrollView in
            LazyVStack(alignment: .leading, spacing: 10) {
                ForEach(messages) { message in
                    AIAssistentChatBubble(text: message.text, isUser: message.isUser)
                        .id(message.id)
                        .transition(.asymmetric(
                            insertion: .opacity.combined(with: .move(edge: .bottom)),
                            removal: .opacity
                        ))
                }
            }
            .padding()
            .onChange(of: messages) { newValue, _ in
                withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                    scrollView.scrollTo(messages.last?.id, anchor: .bottom)
                }
            }
        }
    }
    
    @ViewBuilder
    private func textInputView() -> some View {
       
        if currentQuestionIndex < viewModel.questions.count {
            HStack {
                ZStack {
                    TextField("", text: $userAnswer)
                        .foregroundColor(Colors.seccondary)
                        .background(Colors.green)
                        .padding(.horizontal)
                        .focused($isInputFocused)
                    if !isInputFocused || userAnswer.isEmpty {
                        HStack {
                            TextFactory.text(type: .regular(text: "Send message", font: .reg14, color: .seccondary, line: 1)).padding(.horizontal, 16)
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
            } .background(Colors.green)
            //.cornerRadius(15, corners: [.topLeft, .topRight])
        } else {
            ButtonFactory.button(type: .primery(text: "Ready", isActive: $isReady, onClick: clickSkip)).padding([.horizontal, .bottom], 16).padding(.top, 5)
        }
    }
    
    private func submitAnswer() {
        guard !userAnswer.isEmpty else { return }
        
        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
            messages.append(AuthAIAssistentMessage(text: userAnswer, isUser: true))
            if currentQuestionIndex < viewModel.questions.count {
                answers[viewModel.questions[currentQuestionIndex].text] = userAnswer
            }
            if currentQuestionIndex < viewModel.questions.count - 1 {
                currentQuestionIndex += 1
                messages.append(AuthAIAssistentMessage(text: viewModel.questions[currentQuestionIndex].text, isUser: false))
            } else {
                currentQuestionIndex += 1
                messages.append(AuthAIAssistentMessage(text: "Thanks for answering all questions!", isUser: false))
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                if let lastId = messages.last?.id {
                    scrollToBottom(lastId)
                }
            }
        }
        userAnswer = ""
    }
    
    private func scrollToBottom(_ id: UUID) {
        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
            if let windowScene = UIApplication.shared.connectedScenes.first(where: { $0 is UIWindowScene }) as? UIWindowScene,
               let scrollView = windowScene.windows.first?.rootViewController?.view.subviews.first(where: { $0 is UIScrollView }) as? UIScrollView {
                    scrollView.setContentOffset(
                    CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.height), animated: true
                    )
                }
        }
    }
    
    private func clickSkip() {
        self.coordinator.navigate(type: .auth(.tabView))
    }
}

#Preview {
    AuthAIAssistentView()
}
