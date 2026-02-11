//
//  ProfileEditModel.swift
//  Asseerat
//
//  Created by Nargiza Rahimova on 18/09/25.
//

import Foundation

enum ProfileEditModel {
    
    struct Request{
        
        struct EditUserInfo: Codable {
            let name: String
            let surname: String
            let sex: String
            let email: String
            let phone: String
            let birthday: String
            let client_id: String
            let avatar_id: Int
           
            init(name: String, surname: String, sex: String, email: String, phone: String, birthday: String, client_id: String, avatar_id: Int) {
                self.name = name
                self.surname = surname
                self.sex = sex
                self.email = email
                self.phone = phone
                self.birthday = birthday
                self.client_id = client_id
                self.avatar_id = avatar_id
            }
        }
    }
    
    
    
    struct Response {
        struct EditUserInfoResponse:APIData {
            let code: Int?
            var msg: String?
        }
        
    }
}
