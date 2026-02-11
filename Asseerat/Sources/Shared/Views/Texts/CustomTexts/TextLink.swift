//
//  TextLink.swift
//  NewIOSApp
//
//  Created by Bekzod Abdullaev on 11/06/25.
//

import SwiftUI

struct TextLink: View {
    
    private var text: String
    private var linkText: String
    private var color: Color
    private var linkColor: Color
    private var urlString: String
    
    public init(text: String, linkText: String, color: Color, linkColor: Color, urlString: String) {
        self.text = text
        self.linkText = linkText
        self.color = color
        self.linkColor = linkColor
        self.urlString = urlString
    }
   
    var body: some View {
        if URL(string: urlString) != nil {
            HStack {
                Text(attributedString(left: text, right: linkText, link: urlString))
                    .font(AppFonts.reg14)
                    .foregroundColor(color)
            }
        }
    }
    
    private func attributedString(left:String, right:String, link:String) -> AttributedString {

        var attrString = AttributedString("\(left) \(right)")
        if let range = attrString.range(of: right) {
            attrString[range].link = URL(string: link)!
            attrString[range].foregroundColor = Colors.white
            attrString[range].font = .system(.body, design: .rounded, weight: .semibold)
            attrString[range].underlineStyle = .none
        }
        return attrString
    }
}
