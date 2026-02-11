//
//  AnalyticsOverviewView.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 16/07/25.
//

import SwiftUI

struct AnalyticsOverviewView: View {
    
    @State private var selectedSegment = 0
    @ObservedObject private var vm = AnalyticsOverviewViewModel()
    
    var body: some View {
        VStack{
            ScrollView(.vertical, showsIndicators: false){
                self.overviewInfo()
                Divider().background(Colors.seccondary).padding(16)
                self.daySegmentView()
                self.statisticsView()
            }
        }.background(Colors.background)
    }
    
    
    @ViewBuilder
    private func overviewInfo() -> some View {
        HStack(alignment:.center) {
            OverviewInfoItemView(image: "ic_check", title: "0", message: Localize.completedInTotal)
            OverviewInfoItemView(image: "ic_water", title: "0", message: Localize.longestStreakEver)
            OverviewInfoItemView(image: "ic_prise", title: "0", message: Localize.currentLongestStreak)
        }
    }
    
    @ViewBuilder
    private func daySegmentView() -> some View {
        VStack{
            CustomSegmentedControl(preselectedIndex: $selectedSegment,
                                   options: ["7D", "4W", "12M"])
        }.padding([.horizontal, .bottom],16)
    }
    
    
    @ViewBuilder
    private func statisticsView() -> some View {
        VStack(alignment:.leading,spacing: 8) {
            HStack(alignment:.top) {
                VStack(alignment:.leading,spacing:8){
                    TextFactory.text(type: .semibold(text: Localize.daily, font: .med16))
                    TextFactory.text(type: .regular(text: vm.pastSevenDaysInfo().range, font: .reg12, color: .seccondary, line: 1))
                }
                Spacer()
                TextFactory.text(type: .semibold(text: "Avg. 19%", font: .med16))
            }.padding()
            LineChartView(model: vm)
        }.frame(height: 320).frame(maxWidth:.infinity)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Colors.background)
                .stroke(Colors.inputStroke, lineWidth: 1)
                
        ).padding(.horizontal,16)
    }
}

#Preview {
    AnalyticsOverviewView()
}
