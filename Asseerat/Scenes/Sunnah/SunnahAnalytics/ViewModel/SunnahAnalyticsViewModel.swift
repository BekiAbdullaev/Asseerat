//
//  SunnahAnalytics.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 05/10/25.
//

import Foundation
import SwiftUI

enum ArchivedHabitType {
    case unarchive
    case delete
}

class SunnahAnalyticsViewModel: ObservableObject {
    
    @Published private(set) var habitList = [SunnahModel.GetClientHabitsRows]()

    func getClientHabits(onComplete:@escaping(([SunnahModel.GetClientHabitsRows])->())) {
        let userID = SecurityBean.shared.userId
        NetworkManager(hudType: .authorized).request(SunnahAPI.getClentHabits(userId: userID)) { (response:SunnahModel.Response.GetClientHabitsResponse) in
            self.habitList = response.rows ?? []
            onComplete(response.rows ?? [])
        } failure: { error in
            showTopAlert(title: error?.reason ?? "Something wrong...")
        }
    }
    
    func unarchiveHabit(habitId:String, onComplete:@escaping(()->())) {
        NetworkManager(hudType: .authorized).request(SunnahAPI.unarchiveHabit(id: habitId)) { (response:DefaultResponse) in
            onComplete()
        } failure: { error in
            showTopAlert(title: error?.reason ?? "Something wrong...")
        }
    }
    
    func deleteHabit(habitId:String, onComplete:@escaping(()->())) {
        NetworkManager(hudType: .authorized).request(SunnahAPI.deleteHabit(id: habitId)) { (response:DefaultResponse) in
            onComplete()
        } failure: { error in
            showTopAlert(title: error?.reason ?? "Something wrong...")
        }
    }
    
}
