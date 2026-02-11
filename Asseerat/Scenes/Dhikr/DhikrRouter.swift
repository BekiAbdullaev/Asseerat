//
//  DhikrRouter.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 18/06/25.
//

import SwiftUI

extension MainRouter {
    enum Dhikr {
        case dhikrCounter
        case dhikrRating
        case addFriend
    }
    
    @ViewBuilder
    public func DhikrRoute(_ type: Dhikr)-> some View {
        switch type {
        case .dhikrCounter:
            DhikrCounterListView()
        case .dhikrRating:
            DhikrRatingView()
        case .addFriend:
            AddFriendsView()
        }
    }
}
