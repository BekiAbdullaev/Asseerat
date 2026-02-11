//
//  EditHabitView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 12/07/25.
//

import SwiftUI

struct EditHabitView: View {
    
  
    @ObservedObject private var vmSunnah = SunnahsViewModel()
    @ObservedObject private var vmEdit = EditHabitViewModel()
    @EnvironmentObject var coordinator: Coordinator<MainRouter>
    
    @State private var habitLists: [[SunnahModel.GetClientHabitsRows]]
    @State private var showActions = false
    @State var isDone: Bool = true
    @State private var selectedHabit: SunnahModel.GetClientHabitsRows?
    
    init(habitLists: [[SunnahModel.GetClientHabitsRows]]) {
        self.habitLists = habitLists
    }
    

    var body: some View {
        VStack(spacing:8){
            if habitLists.isEmpty {
                EmptyView(title: Localize.noSunnahEmptyTitle, subtitle: Localize.noSunnahEmptySubtitle)
            } else {
                ScrollView(.vertical, showsIndicators: false){
                    self.sunnahsGridView()
                }.padding(.top,16)
                Spacer()
                self.footerView()
            }
        }.background(Colors.background)
            .navigationBarHidden(false)
            .navigationTitle(Localize.editSunnahs)
            .presentModal(displayPanModal: $showActions, viewHeight: 0.3) {
                EditHabitActionsView(items: vmEdit.habitEditActionList) { type in
                    switch type {
                    case .archive:
                        infoActionAlert(title: Localize.archiveSunnahActionTitle, subtitle: Localize.archiveSunnahActionSubtitle, lBtn: Localize.back, rBtn: Localize.archive) {
                            let habitId = selectedHabit?.id ?? 0
                            self.vmEdit.archiveHabit(habitId: "\(habitId)") {
                                showTopAlert(title:Localize.successefullyArchived, status: .success)
                                self.habitLists = self.removeHabit(habit: self.selectedHabit, habitGroups:  self.habitLists)
                                NotificationCenter.default.post(name: .updateHabitList, object: nil)
                            }
                        }
                    case .delete:
                        infoActionAlert(title: Localize.deleteSunnahActionTitle, subtitle: Localize.deleteSunnahActionSubtitle, lBtn: Localize.back, rBtn: Localize.delete) {
                            let habitId = selectedHabit?.id ?? 0
                            self.vmEdit.deleteHabit(habitId: "\(habitId)") {
                                showTopAlert(title:Localize.successefullyDeleted, status: .success)
                                self.habitLists = self.removeHabit(habit: self.selectedHabit, habitGroups:  self.habitLists)
                                NotificationCenter.default.post(name: .updateHabitList, object: nil)
                            }
                        }
                    }
                }
            }
    }
    
    @ViewBuilder
    private func sunnahsGridView() -> some View {
        VStack(spacing: 20) {
            ForEach(["D", "W", "M"], id: \.self) { type in
                if let habits = habitLists.first(where: { $0.first?.frequency_type == type }),
                   let title = self.vmEdit.frequencyTitles[type] {
                    setHabitsListItem(title: title, items: habits)
                }
            }
        }
    }
    
    @ViewBuilder
    private func setHabitsListItem(title:String, items:[SunnahModel.GetClientHabitsRows]) -> some View {
        VStack(alignment: .leading){
            if title.isNotEmpty {
                TextFactory.text(type: .medium(text: title, font: .med18)).padding([.bottom, .horizontal])
            }
            ForEach(items.indices, id:\.self) { i in
                EditHabitItemView(item: items[i]) {
                    self.selectedHabit = items[i]
                    showActions = true
                }
            }
        }.padding(.bottom, 16)
    }
    
    @ViewBuilder
    private func footerView() -> some View {
        VStack(spacing:16){
            ButtonFactory.button(type: .primery(text: Localize.done, isActive: $isDone, onClick: {
                self.coordinator.pop()
            })).padding([.horizontal, .bottom])
        }
    }
    
    func removeHabit(habit: SunnahModel.GetClientHabitsRows?, habitGroups: [[SunnahModel.GetClientHabitsRows]]) -> [[SunnahModel.GetClientHabitsRows]] {
        if let habit = habit {
            let updated = habitGroups.compactMap { group -> [SunnahModel.GetClientHabitsRows]? in
                let filtered = group.filter { $0.id != habit.id }
                return filtered.isEmpty ? nil : filtered
            }
            return updated
        }
        return habitGroups
    }
}
