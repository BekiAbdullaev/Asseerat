//
//  AnalyticsHabitsView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 16/07/25.
//

import SwiftUI

struct AnalyticsHabitsView: View {
    
    @State private var userHabits:[SunnahModel.GetClientHabitsRows]
    init(userHabits: [SunnahModel.GetClientHabitsRows]) {
        self.userHabits = userHabits
    }
    
    var body: some View {
        VStack(){
            if userHabits.isEmpty {
                EmptyView(title: Localize.noSunnahEmptyTitle, subtitle: Localize.noSunnahEmptySubtitle)
            } else {
                ScrollView(.vertical, showsIndicators: false){
                    ForEach(userHabits.indices, id:\.self) { i in
                        HabitInfoItemView(item: userHabits[i])
                    }
                }.padding(.top,5)
            }
        }.background(Colors.background)
    }
}

