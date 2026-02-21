//
//  DhikrsModel.swift
//  Asseerat
//
//  Created by Nargiza Rahimova on 13/09/25.
//

import Foundation

struct DhikrSavedItem:Codable {
    var id:Int
    var count:Int
    var date:String
}

//struct DhikrCountItem:Codable {
//    var count:Int
//    var date:String
//}

enum DhikrsModel {
    struct Request{
        
        struct DhikrBind:Codable {
            let client_id:String
            let template_id:String
            let required_count:Int?
            
            init(client_id: String, template_id: String, required_count: Int? = nil) {
                self.client_id = client_id
                self.template_id = template_id
                self.required_count = required_count
            }
        }
        
        struct DhikrIncrement:Codable {
            let id:Int
            let count:Int
            let client_id:String
            
            
            init(id: Int, count: Int, client_id: String) {
                self.id = id
                self.count = count
                self.client_id = client_id
            }
        }
    }
    
    struct Response {
        
        struct BindedDhikrsList:APIData {
            var code: Int?
            var msg: String?
            let total:Int?
            let rows:[BindedDhikrsRows]?
        }
        
        struct BindedDhikrsRows: Codable, Hashable {
            let id:Int?
            let text:String?
            let count:Int?
            let client_id:String?
            let template_id:Int?
        }
    }
}
