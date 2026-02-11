//
//  OverviewInfoView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 16/07/25.
//

import SwiftUI

struct OverviewInfoItemView: View {
    
    private var image:String
    private var title:String
    private var message:String
    
    init(image: String, title: String, message: String) {
        self.image = image
        self.title = title
        self.message = message
    }
    
    var body: some View {
        VStack(alignment:.center,spacing: 8) {
            ZStack{
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }.frame(width: 45, height: 45, alignment: .center)
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                ).foregroundColor(Colors.background).padding(.top, 12)
            
            TextFactory.text(type: .semibold(text: title, font: .sem20))
            
            TextFactory.text(type: .regular(text: message, font: .reg12, color: .seccondary, line: 2))
                .padding(.bottom, 10).padding(.horizontal,16).multilineTextAlignment(.center)
            
        }.frame(width: (UIScreen.main.bounds.size.width-48)/3, height: 140)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Colors.green)
        )
    }
}
