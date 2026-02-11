//
//  HomeVerticalView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 18/06/25.
//

import SwiftUI

struct HomeVerticalView: View {
    
    @State private var isPressed = false
    private var onClick:() -> Void
    private var item:HomeItems
    init(item:HomeItems, onClick: @escaping () -> Void){
        self.item = item
        self.onClick = onClick
    }
    
    var body: some View {
        VStack(alignment:.leading) {
            Image(item.icon)
                .resizable()
                .scaledToFill()
                .frame(width: 32, height: 32, alignment: .center)
                .padding([.leading,.top], 14)
            Spacer()
            TextFactory.text(type: .semibold(text: item.title, font: .sem16, line: 2))
                .lineSpacing(5).padding(.horizontal, 14)
            TextFactory.text(type: .regular(text: item.description, font: .reg12, color: .seccondary, line: 3))
                .lineSpacing(5).padding([.horizontal,.bottom], 14).padding(.top,6)
        
        }.frame(width: 147,height: 174)
        .background(
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Colors.green)
        )
        .onTapGesture {
            self.onClick()
        }
    }
}

