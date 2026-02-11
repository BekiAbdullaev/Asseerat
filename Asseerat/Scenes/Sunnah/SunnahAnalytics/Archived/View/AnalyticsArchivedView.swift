//
//  AnalyticsArchivedView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 16/07/25.
//

import SwiftUI

struct AnalyticsArchivedView: View {
    @ObservedObject private var viewModel = SunnahAnalyticsViewModel()
    @State private var userArchivedHabits:[SunnahModel.GetClientHabitsRows]
    init(userHabits: [SunnahModel.GetClientHabitsRows]) {
        self.userArchivedHabits = userHabits
    }
    
    var body: some View {
        VStack(spacing:10){
            
            if userArchivedHabits.isEmpty {
                EmptyView(title: Localize.noUnarchivedEmptyTittle, subtitle: Localize.noUnarchivedEmptySubtittle)
            } else {
                ScrollView(.vertical, showsIndicators: false){
                    ForEach(userArchivedHabits.indices, id:\.self) { i in
                        ArchivedInfoItemView(item: userArchivedHabits[i]) { type in
                            switch type {
                            case .unarchive:
                                infoActionAlert(title: Localize.unarchiveSunnahActionTitle, subtitle: Localize.unarchiveSunnahActionSubtitle, lBtn: Localize.back, rBtn: Localize.unarchive) {
                                    let habit = self.userArchivedHabits[i]
                                    self.viewModel.unarchiveHabit(habitId: "\(habit.id ?? 0)") {
                                        showTopAlert(title:Localize.successefullyUnarchived, status: .success)
                                        userArchivedHabits.removeAll(where: {$0.id == habit.id})
                                        NotificationCenter.default.post(name: .updateHabitList, object: nil)
                                    }
                                }
                            case .delete:
                                infoActionAlert(title:Localize.deleteSunnahActionTitle, subtitle: Localize.deleteSunnahActionSubtitle, lBtn: Localize.back, rBtn: Localize.delete) {
                                    let habit = self.userArchivedHabits[i]
                                    self.viewModel.unarchiveHabit(habitId: "\(habit.id ?? 0)") {
                                        showTopAlert(title:Localize.successefullyDeleted, status: .success)
                                        userArchivedHabits.removeAll(where: {$0.id == habit.id})
                                        NotificationCenter.default.post(name: .updateHabitList, object: nil)
                                    }
                                }
                            }
                        }
                    }
                }.padding(.top,5)
            }
        }.background(Colors.background)
    }
}

