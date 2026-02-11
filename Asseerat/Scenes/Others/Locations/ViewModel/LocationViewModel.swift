//
//  LocationViewModel.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 23/06/25.
//

import Foundation

struct SearchItem:Hashable {
    let title:String
    let subtile:String
    let isRecent:Bool
}

class LocationViewModel:ObservableObject {
   
    let locationList = [SearchItem(title: "Mecca", subtile: "Saudia Arabia", isRecent: false),
                        SearchItem(title: "Tashkent", subtile: "Uzbekistan", isRecent: false),
                        SearchItem(title: "Doha", subtile: "Qatar", isRecent: false)]
    
    
    func getLocation(name:String, onComplete:@escaping(([LocationModel.CitiesRows])->())) {
        NetworkManager(hudType: .noHud ).request(OtherAPI.getCities(name: name)) { (response:LocationModel.CitesResponse) in
            onComplete(response.rows ?? [])
        } failure: { error in
            showTopAlert(title: error?.reason ?? "Something wrong...")
        }
    }
}
