//
//  ButtonFactory.swift
//  NewIOSApp
//
//  Created by Bekzod Abdullaev on 11/06/25.
//

import Foundation
import UIKit
import SwiftUI

public enum ButtonTypes {
    case rounded(image:String = "ic_row_right", size:Int = 50, onClick: () -> Void)
    case roundedWhite(image:String, needFull:Bool = false, needShedow:Bool = true, onClick: () -> Void)
    case primery(text:String, isActive: Binding<Bool>, onClick: () -> Void)
    case secondary(text:String, onClick: () -> Void)
    case bordered(text:String = "", image:String = "", onClick: () -> Void)
    case textBtn(text:String, btnText:String, onClick: () -> Void)
}

@MainActor
public struct ButtonFactory {
    @ViewBuilder
    static public func button(type: ButtonTypes) -> some View {
        switch type {
        case .rounded(let image,let size, let onClick):
            RoundedButton(image: image, size: size ,onClick:onClick)
        case .primery(let text, let isActive, let onClick):
            PrimeryButton(btnTitle: text, isActive: isActive,onClick: onClick)
        case .secondary(let text, let onClick):
            SecondaryButton(btnTitle: text, onClick: onClick)
        case .bordered(let text, let image, let onClick):
            BorderedButton(btnTitle: text, btnImage: image, onClick: onClick)
        case .roundedWhite(let image, let needFull, let needShedow, let onClick):
            RoundedWhiteBtn(image: image, needFull: needFull, needShadow: needShedow,onClick:onClick)
        case .textBtn(let text, let btnText, let onClick):
            TextButton(leftTitle: text, btnTitle: btnText, onClick: onClick)
        }
    }
}
