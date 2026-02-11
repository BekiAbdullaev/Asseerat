//
//  HomeHorizontalView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 18/06/25.
//

import SwiftUI

struct HomeHorizontalView: View {
    
    @State private var isPressed = false
    private var onClick:() -> Void
    private var item:HomeItems
    init(item:HomeItems, onClick: @escaping () -> Void){
        self.item = item
        self.onClick = onClick
    }
    
    var body: some View {
        ZStack {
            Colors.green
            if let image = item.image {
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .cornerRadius(14, corners: .allCorners)
            }
            HStack {
                VStack(alignment:.leading) {
                    TextFactory.text(type: .semibold(text: item.title, font: .sem18, line: 2))
                        .lineSpacing(7).padding([.leading,.top], 14)
                    Spacer()
                    Image(item.icon)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 24, height: 24, alignment: .center)
                        .padding([.leading,.bottom], 14)
                }
                Spacer()
                VStack {
                    Spacer()
                    TextFactory.text(type: .regular(text: item.description, font: .reg12, line: 3))
                        .multilineTextAlignment(.trailing)
                        .padding([.trailing,.bottom], 14)
                        .lineSpacing(7)
                }
            }.frame(height: 140)
        }.frame(maxWidth:.infinity).frame(height: 140)
            .cornerRadius(16, corners: .allCorners)
            .padding(.horizontal, 16)
            .onTapGesture {
                self.onClick()
            }
    }
}
