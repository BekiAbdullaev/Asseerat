//
//  AddHabitViewModel.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 12/07/25.
//

import Foundation
import SwiftUI

struct HabitItems:Hashable {
    let image:String
    let title:String
    let subtitle:String
    let messeage:String
    let list:String
    let howOften:[Int]
    let remindMe:Bool
    let remindMeTime:String
    let count:Int
}

enum Period: String, CaseIterable {
    case daily = "Daily"
    case weekly = "Weekly goal"
    case monthly = "Monthly goal"
}

enum RepeatOption: String, CaseIterable {
    case everyDay = "Every day"
    case selectedWeekdays = "Selected weekdays"
}

class AddHabitViewModel: ObservableObject{
    
    @Published var habitListTypes: [SunnahTypeRows] = []
    
    let templateGridColumns = [ GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    let iconGridColumns = [ GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    let listGridColumns = [GridItem(.flexible())]
    
    @Published var habitList = [HabitItems(image: "ic_water", title: Localize.drinkWater, subtitle: "", messeage: "", list: "1", howOften: [1,2,3,4,5], remindMe: false, remindMeTime: "", count: 8),
                                HabitItems(image: "ic_walk", title: Localize.takeWalk, subtitle: "", messeage: "", list: "1", howOften: [1,2,3,4,5], remindMe: false, remindMeTime: "", count: 8),
                                HabitItems(image: "ic_gym", title: Localize.goToGYM, subtitle: "", messeage: "", list: "1", howOften: [1,2,3,4,5], remindMe: false, remindMeTime: "", count: 8),
                                HabitItems(image: "ic_lose_weight", title: Localize.loseWeight, subtitle: "", messeage: "", list: "1", howOften: [1,2,3,4,5], remindMe: false, remindMeTime: "", count: 8),
                                HabitItems(image: "ic_day_plan", title: Localize.planMyDay, subtitle: "", messeage: "", list: "1", howOften: [1,2,3,4,5], remindMe: false, remindMeTime: "", count: 8),
                                HabitItems(image: "ic_read", title: Localize.read, subtitle: "", messeage: "", list: "1", howOften: [1,2,3,4,5], remindMe: false, remindMeTime: "", count: 8),
                                HabitItems(image: "ic_meditate", title: Localize.medidate, subtitle: "", messeage: "", list: "1", howOften: [1,2,3,4,5], remindMe: false, remindMeTime: "", count: 8)]
    
    
    @Published var habitIconList = ["ic_target", "ic_water", "ic_walk", "ic_gym", "ic_read", "ic_lose_weight", "ic_day_plan", "ic_meditate"]
    
    @Published var habitFrequencyList = ["D", "W", "M"]
    @Published var habitFrequencyValueList = [[Localize.everyDay, Localize.selectWeekDays], [Localize.everyWeek], [Localize.everyMonth]]
    
    @Published var habitSelectionWeekDays = ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"]
    
    func getHabitTypeNameById(id:Int) -> String {
        return habitListTypes.filter({$0.id == id}).first?.name_en ?? ""
    }

    
    func addSunnah(reqBody:AddHabitModel.Request.Add, onComplete:@escaping(()->())) {
        NetworkManager(hudType: .authorized).request(SunnahAPI.addSunnah(body: reqBody)) { (response:DefaultResponse) in
            onComplete()
        } failure: { error in
            showTopAlert(title: error?.reason ?? "Something wrong...")
        }
    }
    
    func editHabit(reqBody:EditHabitModel.Request.EditHabit, onComplete:@escaping(()->())) {
        NetworkManager(hudType: .authorized).request(SunnahAPI.editHabit(body: reqBody)) { (response:EditHabitModel.Response.EditHabitResponse) in
            onComplete()
        } failure: { error in
            showTopAlert(title: error?.reason ?? "Something wrong...")
        }
    }
}
