//
//  TextTypes.swift
//  NewIOSApp
//
//  Created by Bekzod Abdullaev on 11/06/25.
//

import Foundation
import SwiftUI

public enum TextTypes {
    
    case regular(text:String, font:Font, color: Color = Colors.white, line:Int = 0)
    case medium(text:String, font:Font, color: Color = Colors.white, line:Int = 0 )
    case semibold(text:String, font:Font, color: Color = Colors.white, line:Int = 0)
    case bold(text:String, font:Font, color: Color = Colors.white, line:Int = 0)
    case link(text: String, linkText: String, color: Color = Colors.white, linkColor: Color = Colors.white, url: String)
    case textError(text: String, line: Int = 0)
}

@MainActor
public struct TextFactory {
    @ViewBuilder
    static public func text(type: TextTypes) -> some View {
        switch type {
        case .regular(let text, let font, let color, let line):
            TextRegular(text: text, font: font, color: color, line: line)
        case .medium(let text, let font, let color, let line):
            TextMedium(text: text, font: font, color: color, line: line)
        case .semibold(let text, let font, let color, let line):
            TextSemibold(text: text, font: font, color: color, line: line)
        case .bold(let text, let font, let color, let line):
            TextBold(text: text, font: font, color: color, line: line)
        case .link(let text, let linkText, let color, let linkColor, let url):
            TextLink(text: text, linkText: linkText, color: color, linkColor: linkColor, urlString: url)
        case .textError(let text, let line):
            TextError(text: text, line: line)
        }
    }
}

