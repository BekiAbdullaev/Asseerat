//
//  SunnahAnalytics.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 12/07/25.
//

import SwiftUI
import PagerTabStripView

struct SunnahAnalyticsView: View {
    @ObservedObject private var viewModel = SunnahAnalyticsViewModel()
    @State private var userHabits: [SunnahModel.GetClientHabitsRows] = []
    @State private var selectedSegment = 0
    
    var body: some View {
        VStack(spacing:16){
            self.topView()
            switch selectedSegment {
            case 0:
                AnalyticsOverviewView()
            case 1:
                AnalyticsHabitsView(userHabits: userHabits.filter({$0.status != 3}))
            default:
                AnalyticsArchivedView(userHabits: userHabits.filter({$0.status == 3}))
            }
        }.background(Colors.background)
            .navigationTitle(Localize.analytics)
            .navigationBarHidden(false)
            .onDidLoad {
                self.getUserHabits()
            }
    }
    
    
    @ViewBuilder
    private func topView() -> some View {
        CustomSegmentedControl(preselectedIndex: $selectedSegment,
                               options: [Localize.overview, Localize.sunnahs, Localize.archived]).padding([.top,.horizontal],16).padding(.top,6)
    }
    
    private func getUserHabits() {
        self.viewModel.getClientHabits { userHabits in
            self.userHabits = userHabits
        }
    }
}

#Preview {
    SunnahAnalyticsView()
}
