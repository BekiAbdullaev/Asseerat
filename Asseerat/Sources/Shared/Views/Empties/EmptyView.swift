//
//  EmptyView.swift
//  Asseerat
//
//  Created by Nargiza Rahimova on 23/11/25.
//

import SwiftUI

enum EmtpyType {
    case signIn
    case create
    case none
}

struct EmptyView: View {
    
    @State var title:String
    @State var subtitle:String
    @State var type:EmtpyType
    private var onClick:() -> Void
    @State var isActive:Bool = true
    
    init(title: String, subtitle: String, type:EmtpyType = .none, onClick: @escaping () -> Void = {}) {
        self.title = title
        self.subtitle = subtitle
        self.type = type
        self.onClick = onClick
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .center,spacing: 10) {
                Spacer()
                TextFactory.text(type: .medium(text: title, font: .med20, line: 2))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, UIScreen.main.bounds.width * 0.18)
                    .lineSpacing(6)
                TextFactory.text(type: .regular(text: subtitle, font: .reg14, line: 5))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, UIScreen.main.bounds.width * 0.18)
                    .lineSpacing(6)
                if type == .signIn {
                    ButtonFactory.button(type: .primery(text: Localize.logIn, isActive: $isActive, onClick: {
                        self.onClick()
                    })).padding(30)
                } else if type == .create {
                    ButtonFactory.button(type: .primery(text: Localize.create, isActive: $isActive, onClick: {
                        self.onClick()
                    })).padding(30)
                }
                Spacer()
            }
        }.ignoresSafeArea(.all)
            .frame(maxWidth:.infinity, maxHeight: .infinity)
    }
}
