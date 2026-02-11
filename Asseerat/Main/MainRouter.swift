//
//  MainRouter.swift
//  NewIOSApp
//
//  Created by Bekzod Abdullaev on 11/06/25.
//

import SwiftUI


enum MainRouter: NavigationRouter {
    
    case auth(Auth)
    case home(Home)
    case other(Others)
    case dhikr(Dhikr)
    case sunnah(Sunnah)
    case ai(AIAssistent)
    
    public var transition: NavigationTranisitionStyle {
        return .push
    }
    
    @ViewBuilder
    public func view() -> some View {
        switch self {
        case .auth(let auth):
            AuthRoute(auth)
        case .home(let home):
            HomeRoute(home)
        case .other(let other):
            OthersRoute(other)
        case .dhikr(let dhikr):
            DhikrRoute(dhikr)
        case .sunnah(let sunnah):
            SunnahRoute(sunnah)
        case .ai(let ai):
            AIRouter(ai)
        }
    }
}

