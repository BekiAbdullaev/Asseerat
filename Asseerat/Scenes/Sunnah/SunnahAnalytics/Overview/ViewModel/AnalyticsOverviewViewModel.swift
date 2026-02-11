//
//  AnalyticsOverviewViewModel.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 08/08/25.
//

import SwiftUI

class AnalyticsOverviewViewModel:ObservableObject {
    var persentages:[Double] = [0.0, 0.0, 0.0, 0.0, 10.0, 15.0, 25.0, 20.0 ,35.0,20.0, 10,0, 0.0, 0.0, 0.0,10.0, 20.0, 15.0, 30.0, 40.0, 50.0, 60.0, 40.0, 45.0, 0.0, 0.0, 0.0, 0.0]
    
    func pastSevenDaysInfo() -> (days: [String], range: String) {
        let calendar = Calendar.current
        let today = Date()
        var days: [String] = []

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE" // Mon, Tue, Wed, etc.

        
        for i in (0..<7).reversed() {
            if let date = calendar.date(byAdding: .day, value: -i, to: today) {
                if calendar.isDateInToday(date) {
                    days.append("Today")
                } else {
                    days.append(dateFormatter.string(from: date))
                }
            }
        }

        // Build date range (e.g. "29 – 5 Oct, 2025")
        let startDate = calendar.date(byAdding: .day, value: -6, to: today)!
        let rangeFormatter = DateFormatter()
        rangeFormatter.dateFormat = "d"
        let monthYearFormatter = DateFormatter()
        monthYearFormatter.dateFormat = "MMM, yyyy"

        let startDay = rangeFormatter.string(from: startDate)
        let endDay = rangeFormatter.string(from: today)
        let endMonthYear = monthYearFormatter.string(from: today)
        let rangeString = "\(startDay) - \(endDay) \(endMonthYear)"
        return (days, rangeString)
    }
}
