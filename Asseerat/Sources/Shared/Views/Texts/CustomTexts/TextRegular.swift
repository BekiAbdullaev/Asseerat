//
//  TextB1Regular.swift
//  NewIOSApp
//
//  Created by Bekzod Abdullaev on 11/06/25.
//

import SwiftUI

struct TextRegular: View {
    
    private var text: String
    private var font: Font
    private var color: Color
    private var line:Int?
    
    public init(text: String, font:Font, color:Color = Colors.white, line: Int? = nil) {
        self.text = text
        self.font = font
        self.color = color
        self.line = line
    }
   
    var body: some View {
        Text(text.localized)
            .font(font)
            .lineLimit(line)
            .foregroundColor(color)
    }
}
