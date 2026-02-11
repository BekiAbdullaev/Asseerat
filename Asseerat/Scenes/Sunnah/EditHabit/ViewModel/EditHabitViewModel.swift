//
//  EditHabitViewModel.swift
//  Asseerat
//
//  Created by Nargiza Rahimova on 13/09/25.
//

import Foundation

enum EditHabtType {
    case archive
    case delete
}

struct EditHabtItemModel {
    let title:String
    let image:String
    let type:EditHabtType
}


class EditHabitViewModel: ObservableObject {
    
    let frequencyTitles: [String: String] = [
        "D": Localize.daily,
        "W": Localize.weeklyGoals,
        "M": Localize.monthlyGoals
    ]
    
    @Published private(set) var habitEditActionList = [EditHabtItemModel(title: Localize.archive, image: "ic_archive", type: .archive),
                                                       EditHabtItemModel(title: Localize.delete, image: "ic_white_delete", type: .delete)]
    
    
    func archiveHabit(habitId:String, onComplete:@escaping(()->())) {
        NetworkManager(hudType: .authorized).request(SunnahAPI.archiveHabit(id: habitId)) { (response:DefaultResponse) in
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
