//
//  BorderedButton.swift
//  NewIOSApp
//
//  Created by Bekzod Abdullaev on 13/06/25.
//

import Foundation
import SwiftUI

public struct BorderedButton: View {
    
    @State private var isPressed = false
    public let btnTitle: String
    public let btnImage: String
    public var onClick:() -> Void
    
    
    public init(btnTitle: String, btnImage: String, onClick: @escaping () -> Void) {
        self.btnTitle = btnTitle
        self.btnImage = btnImage
        self.onClick = onClick
    }
    
    public var body: some View {
        ZStack(alignment: .center){
            if btnTitle.isNotEmpty {
                TextFactory.text(type: .medium(text: btnTitle.localized, font: AppFonts.med16))
                    .frame(maxWidth:.infinity)
            } else {
                Image(btnImage)
                    .resizable()
                    .frame(width: 24, height: 24, alignment: .center)
            }
        }.frame(height:50).frame(maxWidth:.infinity)
            .background(
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(Colors.background)
                    .stroke( Colors.inputStroke, lineWidth: 1)
                    .frame(height: 50)
            )
            .scaleEffect(isPressed ? 0.95 : 1.0)
            .animation(.easeOut(duration: 0.15), value: isPressed)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in isPressed = true }
                    .onEnded { _ in
                        isPressed = false
                        onClick()
                    }
                )
        
    }
}
