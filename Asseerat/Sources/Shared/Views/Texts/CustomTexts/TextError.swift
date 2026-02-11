//
//  TextError.swift
//  NewIOSApp
//
//  Created by Bekzod Abdullaev on 11/06/25.
//

import Foundation
import SwiftUI

struct TextError: View {
    
    private var text: String
    private var line: Int?
    
    public init(text: String, line: Int? = nil) {
        self.text = text
        self.line = line
    }
   
    var body: some View {
        VStack (alignment: .leading){
            Text(text)
                .font(AppFonts.reg16)
                .lineLimit(line)
                .multilineTextAlignment(.leading)
                .foregroundColor(Colors.white)
                .padding(.all, 16)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Colors.background)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(.clear ,lineWidth: 0)
        )
    }
}
