//
//  HomeMapKeyViewModel.swift
//  Asseerat
//
//  Created by Nargiza Rahimova on 14/10/25.
//

import Foundation
import SwiftUI

class HomeMapKeyViewModel:ObservableObject {
    
    func getMapsAndLocationsAll(onComplete:@escaping(([HomeMapKeyModel.Response.HomeMapKeyListRows])->())) {
        NetworkManager(hudType: .authorized ).request(HomeAPI.getMapsAndLocationsAll) { (response:HomeMapKeyModel.Response.HomeMapKeyList) in
            onComplete(response.rows ?? [])
        } failure: { error in
            showTopAlert(title: error?.reason ?? "Something wrong...")
        }
    }
    
    func getMapsAndLocationsClient(id:String, onComplete:@escaping((HomeMapKeyModel.Response.HomeMapKeyListRows?)->())) {
        NetworkManager(hudType: .authorized ).request(HomeAPI.getMapsAndLocationsClient(id: id)) { (response:HomeMapKeyModel.Response.HomeMapKeyDetail) in
            onComplete(response.body)
        } failure: { error in
            showTopAlert(title: error?.reason ?? "Something wrong...")
        }
    }
    
    func downloadMapsAndLocations(hashId:String, onComplete:@escaping(()->())) {
        NetworkManager(hudType: .authorized ).request(HomeAPI.downloadMapsAndLocations(hashId: hashId)) { (response:DefaultResponse) in
            onComplete()
        } failure: { error in
            showTopAlert(title: error?.reason ?? "Something wrong...")
        }
    }
}
