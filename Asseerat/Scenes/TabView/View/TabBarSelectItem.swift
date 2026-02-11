//
//  TabBarSelectItem.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 07/08/25.
//

import Foundation
import SwiftUI

struct TabBarSelectItem: View {
    let imageName: String
    let title:String
    let action: () -> Void
    
    var body: some View {
        VStack(spacing:4) {
            Image(imageName)
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24, alignment: .center)
                .foregroundColor(Colors.seccondary)
            TextFactory.text(type: .regular(text: title.localized, font: .reg12, color: Colors.seccondary, line: 1))
        }
        .frame(width: (UIScreen.main.bounds.width-20)/4, height: 60)

        .onTapGesture(perform: action)
    }
}
