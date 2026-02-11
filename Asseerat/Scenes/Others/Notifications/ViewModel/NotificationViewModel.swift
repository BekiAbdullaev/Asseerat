//
//  NotificationViewModel.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 23/06/25.
//

import Foundation

enum NotifyType {
    case dhikr
    case sunnah
    case friendRequest
    case news
}

struct NotifyItem:Hashable {
    let image:String
    let title:String
    let type:NotifyType
}

struct NotificationViewModel {
    let notificationList = [NotifyItem(image: "ic_tab_dhikr", title: "We did 23 dhikr today instead of 99, do you want to continue?", type: .dhikr),
                            NotifyItem(image: "ic_profile", title: "Friend request from Alisher Khudoerov - Accept?", type: .friendRequest)]
}
