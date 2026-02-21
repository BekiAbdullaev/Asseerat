//
//  DhikrsViewModel.swift
//  Asseerat
//
//  Created by Nargiza Rahimova on 13/09/25.
//

import Foundation

class DhikrsViewModel: ObservableObject {
    @Published private(set) var sunnahList: [SunnahTypeRows] = [SunnahTypeRows(id: 0, state: "A", name_en: Localize.all, created_at: "", updated_at: "")]
    
    
    func getDhikrTemplates(onComplete:@escaping(([DhikrCounterModel.Response.DhikrTemplateRows])->())) {
        let clientID = SecurityBean.shared.userId
        NetworkManager(hudType: .noHud ).request(DhikrAPI.getDhikrTemplates(userId: clientID)) { (response:DhikrCounterModel.Response.DhikrTemplateList) in
            onComplete(response.rows ?? [])
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
    
    func bindDhikr(reqBody:DhikrsModel.Request.DhikrBind, onComplete:@escaping(()->())) {
        NetworkManager(hudType: .noHud).request(DhikrAPI.bindDhikr(body: reqBody)) { (response:DefaultResponse) in
            onComplete()
        } failure: { error in
            showTopAlert(title: error?.reason ?? "Something wrong...")
        }
    }
    
    func incrementDhikr(reqBody:DhikrsModel.Request.DhikrIncrement, onComplete:@escaping(()->())) {
        NetworkManager(hudType: .noHud).request(DhikrAPI.incrementBindedDhikr(body: reqBody)) { (response:DefaultResponse) in
            onComplete()
        } failure: { error in
            showTopAlert(title: error?.reason ?? "Something wrong...")
        }
    }
    
    
}
