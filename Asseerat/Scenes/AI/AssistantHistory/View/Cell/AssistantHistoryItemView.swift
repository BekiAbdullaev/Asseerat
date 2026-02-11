//
//  AssistantHistoryItemView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 07/08/25.
//

import SwiftUI

struct AssistantHistoryItemView: View {
   
    private var title:String
    private var onClick:() -> Void
    private var onDelete:() -> Void
    
    init(title: String, onClick: @escaping () -> Void = {}, onDelete: @escaping () -> Void = {}) {
        self.title = title
        self.onClick = onClick
        self.onDelete = onDelete
    }
    
    var body: some View {
        HStack(alignment:.center, spacing: 10){
            Image("ic_recent")
                .resizable()
                .scaledToFill()
                .frame(width: 22, height: 22, alignment: .center)
                .padding(.leading,18)
            
            TextFactory.text(type: .regular(text: title, font: .reg16, line: 1))
            Spacer()
            Image("ic_gray_delete")
                .resizable()
                .scaledToFill()
                .frame(width: 22, height: 22, alignment: .center)
                .padding(.trailing,18)
                .onTapGesture(perform: self.onDelete)
            
        }.frame(maxWidth:.infinity).frame(height: 50)
            .background(Colors.green)
            .cornerRadius(16, corners: .allCorners)
            .padding(.horizontal)
            .onTapGesture(perform: self.onClick)
    }
}

