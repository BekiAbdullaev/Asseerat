//
//  RoundedWhiteBtn.swift
//  NewIOSApp
//
//  Created by Bekzod Abdullaev on 13/06/25.
//

import SwiftUI

public struct RoundedWhiteBtn: View {
    
    public var onClick:() -> Void
    private var image:String
    private var needFull:Bool
    private var needShadow:Bool
    
    public init(image:String, needFull:Bool = false, needShadow:Bool = true, onClick: @escaping () -> Void) {
        self.onClick = onClick
        self.image = image
        self.needFull = needFull
        self.needShadow = needShadow
    }
    
    public var body: some View {
        ZStack{
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:  needFull ? 30 : 22, height: needFull ? 30 : 22)
        }.frame(width: 42, height: 42, alignment: .center)
            .background(
                RoundedRectangle(cornerRadius: 21, style: .continuous).fill(needShadow ? Colors.green : .clear)
            )
            .onTapGesture {
                self.onClick()
            }
    }
}

