//
//  HomeARViewModel.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 07/10/25.
//

import Foundation
import SwiftUI

class HomeARViewModel:ObservableObject {
    
    func getARList(onComplete:@escaping(([HomeARModel.Response.HomeARListRows])->())) {
        NetworkManager(hudType: .authorized ).request(HomeAPI.getAllAR) { (response:HomeARModel.Response.HomeARList) in
            onComplete(response.rows ?? [])
        } failure: { error in
            showTopAlert(title: error?.reason ?? "Something wrong...")
        }
    }
    
    func getARDetail(arId:String, onComplete:@escaping(()->())) {
        NetworkManager(hudType: .authorized ).request(HomeAPI.getClientAR(arID: arId)) { (response:DefaultResponse) in
            onComplete()
        } failure: { error in
            showTopAlert(title: error?.reason ?? "Something wrong...")
        }
    }
}
