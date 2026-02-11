//
//  TextB1Semibold.swift
//  NewIOSApp
//
//  Created by Bekzod Abdullaev on 11/06/25.
//

import SwiftUI

struct TextSemibold: View {
    private var text: String
    private var line: Int?
    private var color: Color
    private var font: Font
    
    public init(text: String, font:Font, color: Color = Colors.white, line: Int? = nil) {
        self.text = text
        self.line = line
        self.color = color
        self.font = font
    }
   
    var body: some View {
        Text(text.localized)
            .font(font)
            .lineLimit(line)
            .foregroundColor(color)
    }
}
