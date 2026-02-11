//
//  MyDeviceViewModel.swift
//  Asseerat
//
//  Created by Nargiza Rahimova on 07/09/25.
//

import SwiftUI

class MyDeviceViewModel: ObservableObject {
    
    func getDeviceList(onComplete:@escaping((MyDeviceModel.DeviceResponse)->())) {
        
        let userID = SecurityBean.shared.userId
        
        NetworkManager(hudType: .authorized).request(OtherAPI.getDeviceList(userId: userID)) { (response:MyDeviceModel.DeviceResponse) in
            onComplete(response)
        } failure: { error in
            showTopAlert(title: error?.reason ?? "Something wrong...")
        }
    }
}
