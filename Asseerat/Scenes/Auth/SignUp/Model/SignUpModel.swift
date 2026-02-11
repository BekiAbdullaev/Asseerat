//
//  SignUpModel.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 27/08/25.
//

import Foundation

enum SignUpModel {
    struct Request{
        struct Registration: Codable {
            let login: String
            let password: String
            let name: String
            let surname: String
            let phone: String
            let email: String
            let sex: String
            let birthday: String
            let ip: String
            let login_type: String
            let device_type: String
            let device_code: String
            let device_name: String
            let app_version: Int
            
            init(login: String, password: String, name: String, surname: String, phone: String, email: String, sex: String, birthday: String, ip: String, login_type: String, device_type: String, device_code: String, device_name: String, app_version: Int) {
                self.login = login
                self.password = password
                self.name = name
                self.surname = surname
                self.phone = phone
                self.email = email
                self.sex = sex
                self.birthday = birthday
                self.ip = ip
                self.login_type = login_type
                self.device_type = device_type
                self.device_code = device_code
                self.device_name = device_name
                self.app_version = app_version
            }
        }
    }
    
    struct SignInUpResponse:APIData {
        var code: Int?
        var msg: String?
        var token: String?
        var client_id: String?
        var user:User?
    }
    
    
    // MARK: - User
    struct User: Codable, Hashable {
        let id, login, name, surname, phone, email, state, sex, birthday, login_type, created_at: String?
        init(id: String?, login: String?, name: String?, surname: String?, phone: String?, email: String?, state: String?, sex: String?, birthday: String?, login_type: String?, created_at: String?) {
            self.id = id
            self.login = login
            self.name = name
            self.surname = surname
            self.phone = phone
            self.email = email
            self.state = state
            self.sex = sex
            self.birthday = birthday
            self.login_type = login_type
            self.created_at = created_at
        }
       
    }
    
}
