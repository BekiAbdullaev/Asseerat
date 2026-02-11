//
//  DhikrRatingViewModel.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 30/06/25.
//

import Foundation

struct DhikrRatingItem:Hashable {
    let order:Int
    let image:String
    let title:String
    let subtitle:String
    let isActive:Bool
}


class DhikrRatingViewModel:ObservableObject {
    let dhikrParticipants = [DhikrRatingItem(order: 1, image: "ic_profile", title: "Alisher Khudoerov", subtitle: "3754", isActive: true),
                             DhikrRatingItem(order: 2, image: "ic_profile", title: "Jobs Ando", subtitle: "3754", isActive: true),
                             DhikrRatingItem(order: 3, image: "ic_profile", title: "Sean Alen", subtitle: "3433", isActive: true),
                             DhikrRatingItem(order: 4, image: "ic_profile", title: "Tulki Bo'riev", subtitle: "2344", isActive: false),
                             DhikrRatingItem(order: 5, image: "ic_profile", title: "Toshmat Eshmatov", subtitle: "1000", isActive: false),
                             DhikrRatingItem(order: 6, image: "ic_profile", title: "Qodir Qodirov", subtitle: "990", isActive: false),
                             DhikrRatingItem(order: 7, image: "ic_profile", title: "Nizom Dostonov", subtitle: "700", isActive: false),
                             DhikrRatingItem(order: 8, image: "ic_profile", title: "Ali Qushov", subtitle: "300", isActive: false)]
    
    
    func getBindedDhikrsStatistics(period:String, onComplete:@escaping(([DhikrRatingModel.Response.DhikrRatingRows])->())) {
        let userID = SecurityBean.shared.userId
        NetworkManager(hudType: .authorized).request(DhikrAPI.getBindedDhikrsStatistics(userId: userID, period: period)) { (response:DhikrRatingModel.Response.DhikrRatingList) in
            onComplete(response.rows ?? [])
        } failure: { error in
            showTopAlert(title: error?.reason ?? "Something wrong...")
        }
    }
}

