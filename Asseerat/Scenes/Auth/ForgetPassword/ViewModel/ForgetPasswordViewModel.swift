//
//  ForgetPasswordViewModel.swift
//  Asseerat
//
//  Created by Nargiza Rahimova on 07/09/25.

import Foundation

class ForgetPasswordViewModel: ObservableObject {
    
    func resetPassword(reqBody:ForgetPasswordModel.Request.Password, onComplete:@escaping(()->())) {
        NetworkManager(hudType:.authorized).request(AuthAPI.resetPassword(body: reqBody)) { (response:ForgetPasswordModel.Response.Password) in
            onComplete()
        } failure: { error in
            showTopAlert(title: error?.reason ?? "Something wrong...")
        }
    }
    
    
    func resetPasswordVerify(reqBody:ForgetPasswordModel.Request.PasswordVerify, onComplete:@escaping((DefaultResponse)->())) {
        NetworkManager(hudType:.authorized).request(AuthAPI.resetPasswordVerify(body: reqBody)) { (response:DefaultResponse) in
            onComplete(response)
        } failure: { error in
            showTopAlert(title: error?.reason ?? "Something wrong...")
        }
    }
    
    
}
