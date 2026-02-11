//
//  File.swift
//  MyLibrary
//
//  Created by Bekzod Abdullaev on 10/06/25.
//

import SwiftUI

public struct RoundedButton: View {
    
    public var onClick:() -> Void
    private var size:Int
    private var image:String
    
    public init(image:String,size:Int, onClick: @escaping () -> Void) {
        self.onClick = onClick
        self.image = image
        self.size = size
    }
    
    public var body: some View {
        Button(action: onClick) {
            Image(image)
        }.frame(width: CGFloat(size), height: CGFloat(size), alignment: .center)
            .background(
                RoundedRectangle(cornerRadius: CGFloat(size)/2, style: .continuous)
            ).foregroundColor(Colors.btnColor)
    }
}

