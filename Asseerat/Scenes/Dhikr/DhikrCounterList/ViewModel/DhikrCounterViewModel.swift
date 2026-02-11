//
//  DhikrCounterViewModel.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 29/06/25.
//

import SwiftUI

class DhikrCounterViewModel:ObservableObject {
   
    let columns = [ GridItem(.flexible())]

    func addDhikrTemplate(text:String,onComplete:@escaping(()->())) {
        let clientID = SecurityBean.shared.userId
        NetworkManager(hudType: .noHud ).request(DhikrAPI.addDhikrTemplates(body: DhikrCounterModel.AddDhikr(text: text, client_id: clientID))){ (response:DefaultResponse) in
            onComplete()
        } failure: { error in
            showTopAlert(title: error?.reason ?? "Something wrong...")
        }
    }
    
    func getDhikrTemplates(onComplete:@escaping(([DhikrCounterModel.Response.DhikrTemplateRows])->())) {
        let clientID = SecurityBean.shared.userId
        NetworkManager(hudType: .authorized).request(DhikrAPI.getDhikrTemplates(userId: clientID)) { (response:DhikrCounterModel.Response.DhikrTemplateList) in
            onComplete(response.rows ?? [])
        } failure: { error in
            showTopAlert(title: error?.reason ?? "Something wrong...")
        }
    }
    
    func deleteDhikrTemplate(id:String, onComplete:@escaping(()->())) {
        let clientID = SecurityBean.shared.userId
        NetworkManager(hudType: .noHud ).request(DhikrAPI.deleteDhikrTemplates(clientId: clientID, id: id)) { (response:DefaultResponse) in
            onComplete()
        } failure: { error in
            showTopAlert(title: error?.reason ?? "Something wrong...")
        }
    }
    
    func bindDhikr(reqBody:DhikrsModel.Request.DhikrBind, onComplete:@escaping(()->())) {
        NetworkManager(hudType: .noHud).request(DhikrAPI.bindDhikr(body: reqBody)) { (response:DefaultResponse) in
            onComplete()
        } failure: { error in
            showTopAlert(title: error?.reason ?? "Something wrong...")
        }
    }
    
    func unbindDhikr(dhikrID:String, onComplete:@escaping(()->())) {
        NetworkManager(hudType: .noHud).request(DhikrAPI.unbindDhikr(id: dhikrID)) { (response:DefaultResponse) in
            onComplete()
        } failure: { error in
            showTopAlert(title: error?.reason ?? "Something wrong...")
        }
    }
    
    func getBindedDhikrs(onComplete:@escaping(([DhikrsModel.Response.BindedDhikrsRows])->())) {
        let userID = SecurityBean.shared.userId
        NetworkManager(hudType: .noHud).request(DhikrAPI.getBindedDhikrs(userId: userID)) { (response:DhikrsModel.Response.BindedDhikrsList) in
            onComplete(response.rows ?? [])
        } failure: { error in
            showTopAlert(title: error?.reason ?? "Something wrong...")
        }
    }
}
