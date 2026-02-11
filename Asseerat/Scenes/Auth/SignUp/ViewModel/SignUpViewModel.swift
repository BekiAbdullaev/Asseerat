//
//  SignUpViewModel.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 27/08/25.
//

import Foundation

class SignUpViewModel: ObservableObject {
    
    func postRegistration(reqBody:SignUpModel.Request.Registration, onComplete:@escaping((SignUpModel.SignInUpResponse)->())) {
        
        
        NetworkManager(hudType: .authorized).request(AuthAPI.registration(body: reqBody)) { (response:SignUpModel.SignInUpResponse) in
            onComplete(response)
        } failure: { error in
            showTopAlert(title: error?.reason ?? "Something wrong...")
        }
    }
}
