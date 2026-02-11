//
//  TextButton.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 16/06/25.
//

import Foundation
import SwiftUI

public struct TextButton: View {
    public let leftTitle:String
    public let btnTitle: String
    public var onClick:() -> Void
    
    public init(leftTitle:String, btnTitle: String, onClick: @escaping () -> Void) {
        self.leftTitle = leftTitle
        self.btnTitle = btnTitle
        self.onClick = onClick
    }
    
    public var body: some View {
        
        HStack(spacing:6) {
            TextFactory.text(type: .regular(text: leftTitle.localized, font: .med16, color: .seccondary, line: 1))
                .multilineTextAlignment(.trailing)
            Button(action: onClick) {
                TextFactory.text(type: .semibold(text: btnTitle.localized, font: .sem16, line: 1))
                    .multilineTextAlignment(.leading)
            }
        }.frame(height:50).frame(maxWidth:.infinity)
    }
}
