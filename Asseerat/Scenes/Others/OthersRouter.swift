//
//  OthersRouter.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 18/06/25.
//

import SwiftUI

extension MainRouter {
    enum Others {
        case editProfile
        case theme
        case lang
        case security
        case myDevices
    }
    
    @ViewBuilder
    public func OthersRoute(_ type: Others)-> some View {
        switch type {
        case .editProfile:
            ProfileEditVIew()
        case .theme:
            ProfileThemeView()
        case .lang:
            ProfileLanguageView()
        case .security:
            SecurityView()
        case .myDevices:
            MyDevicesView()
        }
    }
}
