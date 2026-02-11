//
//  SunnahsViewModel.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 06/07/25.
//

import Foundation
import SwiftUI

struct SunnahItems:Hashable {
    let image:String
    let title:String
    let subtitle:String
    let messeage:String
    let isCompleted:Bool
    let isSkiped:Bool
    let skipedTo:String
}

struct HabitGroup {
    let frequencyType: String
    let habits: [SunnahModel.GetClientHabitsRows]
}

class SunnahsViewModel: ObservableObject {
    @Published private(set) var sunnahList: [SunnahTypeRows] = [SunnahTypeRows(id: 0, state: "A", name_en: Localize.all, created_at: "", updated_at: "")]
    @Published private(set) var habitList = [[SunnahModel.GetClientHabitsRows]]()
    @Published private var inithabitList:[SunnahModel.GetClientHabitsRows]?
    
    @Published var progressCount = 0.0
    @Published var progressPercent = "0"
    var recuiredCount = 0
    var currentCount = 0
    let columns = [ GridItem(.flexible())]
    
    func setInitProgress() {
        if let dayHabits = inithabitList?.filter({$0.frequency_type == "D"}){
            recuiredCount = 0
            currentCount = 0
            for habit in dayHabits {
                recuiredCount += habit.required_count ?? 0
                currentCount += habit.current_count ?? 0
            }
            self.changeInitProgress(curCount: currentCount, reqCount: recuiredCount)

        } else if let dayHabits = inithabitList?.filter({$0.frequency_type == "W"}){
            recuiredCount = 0
            currentCount = 0
            for habit in dayHabits {
                recuiredCount += habit.required_count ?? 0
                currentCount += habit.current_count ?? 0
            }
            self.changeInitProgress(curCount: currentCount, reqCount: recuiredCount)
        } else if let dayHabits = inithabitList?.filter({$0.frequency_type == "M"}) {
            recuiredCount = 0
            currentCount = 0
            for habit in dayHabits {
                recuiredCount += habit.required_count ?? 0
                currentCount += habit.current_count ?? 0
            }
            self.changeInitProgress(curCount: currentCount, reqCount: recuiredCount)
        }
    }
    
    func changeInitProgress(curCount:Int, reqCount:Int) {
        if reqCount != 0 {
            let percent = "\(Int((Double(curCount)/Double(reqCount)) * 100))"
            let count = Double((Double(curCount)/Double(reqCount)))
            self.progressPercent = percent
            withAnimation(.easeInOut(duration: 0.4)) {
                self.progressCount = count
            }
        }
    }
    
    
    func getListNameById(id:Int) -> String {
        let item = self.sunnahList.filter({$0.id == id}).first
        return item?.name_en ?? ""
    }
    
    func groupHabitsByFrequency(_ habits: [SunnahModel.GetClientHabitsRows]) -> [[SunnahModel.GetClientHabitsRows]] {
        
        let filteredHabits = habits.filter { $0.status != 3 }
        let grouped: [String: [SunnahModel.GetClientHabitsRows]] = Dictionary(grouping: filteredHabits, by: { $0.frequency_type ?? ""})
        let frequencyOrder: [String: Int] = ["D": 0, "W": 1, "M": 2]
        let sortedGroups = grouped.map { HabitGroup(frequencyType: $0.key, habits: $0.value) }
            .sorted { (group1, group2) -> Bool in
                let order1 = frequencyOrder[group1.frequencyType] ?? Int.max
                let order2 = frequencyOrder[group2.frequencyType] ?? Int.max
                return order1 < order2
            }
            .map { $0.habits }
        return sortedGroups
    }
    
    func filterHabitsByTypeId(typeId: Int, habitLists: [[SunnahModel.GetClientHabitsRows]]) -> [[SunnahModel.GetClientHabitsRows]] {
        if typeId == 0 { return habitLists }
        return habitLists.compactMap { subarray in
            let filtered = subarray.filter { $0.type_id == typeId }
            return filtered.isEmpty ? nil : filtered
        }
    }
    

    func getSunnahTypes() {
        let userID = SecurityBean.shared.userId
        NetworkManager(hudType: .authorized).request(SunnahAPI.getSunnahTypes(userId: userID)) { (response:SunnahModel.Response.SunnahTypeResponse) in
            if let rows = response.rows, !rows.isEmpty {
                for item in rows {
                    self.sunnahList.append(item)
                }
            }
        } failure: { error in
            showTopAlert(title: error?.reason ?? "Something wrong...")
        }
    }
    
    func getClientHabits(onComplete:@escaping(([[SunnahModel.GetClientHabitsRows]])->())) {
        let userID = SecurityBean.shared.userId
        NetworkManager(hudType: .authorized).request(SunnahAPI.getClentHabits(userId: userID)) { (response:SunnahModel.Response.GetClientHabitsResponse) in
            self.inithabitList = response.rows ?? []
            let groupedHabits = self.groupHabitsByFrequency(response.rows ?? [])
            self.habitList = groupedHabits
            onComplete(groupedHabits)
        } failure: { error in
            showTopAlert(title: error?.reason ?? "Something wrong...")
        }
    }
    
    func getSunnahTemplates(onComplete:@escaping(([AddHabitModel.SunnahTemplatesRows])->())) {
        NetworkManager(hudType: .authorized).request(SunnahAPI.getSunnahTemplates) { (response:AddHabitModel.Response.SunnahTemplatesResponse) in
            if let rows = response.rows, !rows.isEmpty {
                onComplete(rows)
            }
        } failure: { error in
            onComplete([])
        }
    }
    
    func incrementHabitRecord(reqBody:SunnahModel.Request.IncrementHabitRecord, onComplete:@escaping(()->())) {
        NetworkManager(hudType: .noHud).request(SunnahAPI.incrementHabitRecord(body: reqBody)) { (response:SunnahModel.Response.IncrementHabitRecordResponse) in
            onComplete()
        } failure: { error in
            showTopAlert(title: error?.reason ?? "Something wrong...")
        }
    }
    
    func getHabitRecords(habitId:Int, fromDate:String, toDate:String, onComplete:@escaping(()->())) {
        let userId = SecurityBean.shared.userId
        NetworkManager(hudType: .authorized).request(SunnahAPI.getHabitRecords(client_id: userId, habit_id: habitId, from_date: fromDate, to_date: toDate)) { (response:SunnahModel.Response.GetHabitRecordsResponse) in
            onComplete()
        } failure: { error in
            showTopAlert(title: error?.reason ?? "Something wrong...")
        }
    }
    
    func skipHabit(habitId:String, onComplete:@escaping(()->())) {
        NetworkManager(hudType: .authorized).request(SunnahAPI.skipHabit(id: habitId)) { (response:DefaultResponse) in
            onComplete()
        } failure: { error in
            showTopAlert(title: error?.reason ?? "Something wrong...")
        }
    }
    
    func unskipHabit(habitId:String, onComplete:@escaping(()->())) {
        NetworkManager(hudType: .authorized).request(SunnahAPI.unskipHabit(id: habitId)) { (response:DefaultResponse) in
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
