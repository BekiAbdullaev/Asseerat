//
//  TabBarItem.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 18/06/25.
//

import SwiftUI

struct TabBarItem: View {
    @Binding var currentView: Tab
    let imageName: String
    let title:String
    let tab: Tab
    
    var body: some View {
        VStack(spacing:4) {
            Image(imageName)
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24, alignment: .center)
                .foregroundColor(self.currentView == tab ? Colors.white : Colors.seccondary)
            TextFactory.text(type: .regular(text: title.localized, font: .reg12, color: self.currentView == tab ? Colors.white : Colors.seccondary, line: 1))
        }
        .frame(width: (UIScreen.main.bounds.width-20)/4, height: 60)

        .onTapGesture { self.currentView = self.tab }
    }
}
