//
//  LoginModel.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 15/06/25.
//

import Foundation

enum LoginModel {
    struct Request{
        struct SignIn: Codable {
            let login: String
            let password: String
            let login_type: String
           
            init(login: String, password: String, login_type: String) {
                self.login = login
                self.password = password
                self.login_type = login_type
            }
        }
        
        struct VersionCheck:Codable {
            let app_version:Int
            let device_type:String
            let db_version:Int
            
            init(app_version: Int, device_type: String, db_version: Int) {
                self.app_version = app_version
                self.device_type = device_type
                self.db_version = db_version
            }
        }
    }
    
    struct Response {
        struct VersionCheckResponse:APIData {
            var code: Int?
            var msg: String?
            var db_update: String?
            var app_update: String?
        }
    }
}

struct UserInfo {
    let login:String
    let name:String
    let surname:String
    let phone:String
    let email:String
    let state:String
    let sex:String
    let birthday:String
    let login_type:String
    init(login: String, name: String, surname: String, phone: String, email: String, state: String, sex: String, birthday: String, login_type: String) {
        self.login = login
        self.name = name
        self.surname = surname
        self.phone = phone
        self.email = email
        self.state = state
        self.sex = sex
        self.birthday = birthday
        self.login_type = login_type
    }
}
