//
//  HomeViewModel.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 18/06/25.
//

import Foundation
import SwiftUI

struct CycleItems {
    var progress: CGFloat
    let size:CGFloat
    let lineWith:CGFloat
    let lineBgColor:Color
    let lineColor:Color
    let title:String
}


class HomeViewModel:ObservableObject {
    let daysProgress = [
             CycleItems(progress: 0.0, size: 36, lineWith: 4, lineBgColor: Colors.background, lineColor: Colors.btnColor, title: "M"),
             CycleItems(progress: 0.0, size: 36, lineWith: 4, lineBgColor: Colors.background, lineColor: Colors.btnColor, title: "T"),
             CycleItems(progress: 0.0, size: 36, lineWith: 4, lineBgColor: Colors.background, lineColor: Colors.btnColor, title: "W"),
             CycleItems(progress: 0.0, size: 36, lineWith: 4, lineBgColor: Colors.background, lineColor: Colors.btnColor, title: "T"),
             CycleItems(progress: 0.0, size: 36, lineWith: 4, lineBgColor: Colors.background, lineColor: Colors.btnColor, title: "F"),
             CycleItems(progress: 0.0, size: 36, lineWith: 4, lineBgColor: Colors.background, lineColor: Colors.btnColor, title: "S"),
             CycleItems(progress: 0.0, size: 36, lineWith: 4, lineBgColor: Colors.background, lineColor: Colors.btnColor, title: "S")]
    
    
    func getHomeAllGroups(onComplete:@escaping(()->())) {
        NetworkManager(hudType: .noHud ).request(HomeAPI.getHomeAllGroups) { (response:DefaultResponse) in
            onComplete()
        } failure: { error in
            showTopAlert(title: error?.reason ?? "Something wrong...")
        }
    }
    
    
    func getHomeGroupItems(groupId:String, onComplete:@escaping(()->())) {
        NetworkManager(hudType: .noHud ).request(HomeAPI.getHomeGroupItem(groupId: groupId)) { (response:DefaultResponse) in
            onComplete()
        } failure: { error in
            showTopAlert(title: error?.reason ?? "Something wrong...")
        }
    }
}
