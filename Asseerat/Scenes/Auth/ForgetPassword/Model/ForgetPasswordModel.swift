//
//  ForgetPasswordModel.swift
//  Asseerat
//
//  Created by Nargiza Rahimova on 07/09/25.
//

import Foundation

enum ForgetPasswordModel {
    struct Request{
        struct Password: Codable {
            let login: String
            let login_type: String
           
            init(login: String, login_type: String) {
                self.login = login
                self.login_type = login_type
            }
        }
        
        struct PasswordVerify: Codable {
            let login: String
            let login_type: String
            let new_password: String
            let sms_code: String
            
            init(login: String, login_type: String, new_password: String, sms_code: String) {
                self.login = login
                self.login_type = login_type
                self.new_password = new_password
                self.sms_code = sms_code
            }
        }
    }
    
    struct Response {
        struct Password:APIData {
            var code: Int?
            var msg: String?
        }
        
        struct PasswordVerify:APIData {
            var code: Int?
            var msg: String?
        }
    }
}
