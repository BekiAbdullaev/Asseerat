//
//  File.swift
//  MyLibrary
//
//  Created by Bekzod Abdullaev on 10/06/25.
//

import Foundation
import SwiftUI

public struct PrimeryButton: View {
    
    public let btnTitle: String
    @Binding var isActive: Bool
    public var onClick:() -> Void
    @State private var isPressed = false
    
    public init(btnTitle: String, isActive: Binding<Bool>, onClick: @escaping () -> Void) {
        self.btnTitle = btnTitle
        self.onClick = onClick
        self._isActive = isActive
    }
    
    public var body: some View {
        ZStack(alignment: .center){
            TextFactory.text(type: .medium(text: btnTitle.localized, font: AppFonts.med16, color: Colors.background, line: 1))
                .frame(maxWidth:.infinity)
        }.frame(height:50)
            .background(
                RoundedRectangle(cornerRadius: 15, style: .continuous)
            ).foregroundColor(isActive ? Colors.btnColor : Colors.btnColorLight)
            .scaleEffect(isPressed ? 0.95 : 1.0)
            .animation(.easeOut(duration: 0.15), value: isPressed)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in isPressed = true }
                    .onEnded { _ in
                        isPressed = false
                        if isActive{
                            onClick()
                        }
                    }
                )
    }
}
