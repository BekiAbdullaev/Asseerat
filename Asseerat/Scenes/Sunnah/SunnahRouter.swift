//
//  SunnahRouter.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 18/06/25.
//

import Foundation
import SwiftUI

extension MainRouter {
    enum Sunnah {
        case edit(habits:[[SunnahModel.GetClientHabitsRows]])
        case newHabit(item:AddHabitModel.SunnahTemplatesRows?, types:[SunnahTypeRows]?)
        case editHabit(item:SunnahModel.GetClientHabitsRows?, types:[SunnahTypeRows]?)
        case analytics
    }
    
    @ViewBuilder
    public func SunnahRoute(_ type: Sunnah)-> some View {
        switch type {
        case .edit(let habits):
            EditHabitView(habitLists: habits)
        case .newHabit(let item, let types):
            AddHabitView(tempItem: item, sunnahList: types)
        case .editHabit(let item, let types):
            AddHabitView(editItem: item, sunnahList: types)
        case .analytics:
            SunnahAnalyticsView()
        }
    }
}
