//
//  ProfileEditViewModel.swift
//  Asseerat
//
//  Created by Nargiza Rahimova on 18/09/25.
//

import Foundation

class ProfileEditViewModel: ObservableObject {
    
    func editUserInfo(reqBody:ProfileEditModel.Request.EditUserInfo, onComplete:@escaping(()->())) {
        NetworkManager(hudType: .authorized).request(OtherAPI.editUserInfo(body: reqBody)) { (response:DefaultResponse) in
            onComplete()
        } failure: { error in
            showTopAlert(title: error?.reason ?? "Something wrong...")
        }
    }
    
    
    func deleteUserAccount(onComplete:@escaping(()->())) {
        let userId = SecurityBean.shared.userId
        NetworkManager(hudType: .authorized).request(OtherAPI.deleteAccount(userId: userId)) { (response:DefaultResponse) in
            onComplete()
        } failure: { error in
            showTopAlert(title: error?.reason ?? "Something wrong...")
        }
    }
}
