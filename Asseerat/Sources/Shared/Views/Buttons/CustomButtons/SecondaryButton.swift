//
//  File.swift
//  MyLibrary
//
//  Created by Bekzod Abdullaev on 10/06/25.
//

import Foundation
import SwiftUI

public struct SecondaryButton: View {
    
    public let btnTitle: String
    public var onClick:() -> Void
    public let foregroundColor: Color
    
    public init(btnTitle: String, foregroundColor: Color = Colors.white, onClick: @escaping () -> Void) {
        self.btnTitle = btnTitle
        self.onClick = onClick
        self.foregroundColor = foregroundColor;
    }
    
    public var body: some View {
        Button(action: onClick) {
            TextFactory.text(type: .medium(text: btnTitle.localized, font: .med16, line: 1))
                .frame(maxWidth:.infinity)
        }.frame(height:50)
    }
}
