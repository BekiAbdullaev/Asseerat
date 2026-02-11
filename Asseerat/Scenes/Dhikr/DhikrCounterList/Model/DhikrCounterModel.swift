//
//  DhikrCounterModel.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 26/10/25.
//

import Foundation

struct DhikrCounterModel {
    
    struct AddDhikr:Codable {
        let text:String
        let client_id:String
      
        init(text: String, client_id: String) {
            self.text = text
            self.client_id = client_id
        }
    }
    
    struct Response {
        struct DhikrTemplateList:APIData {
            var code: Int?
            var msg: String?
            let total: Int?
            let rows:[DhikrTemplateRows]?
        }
        
        struct DhikrTemplateRows: Codable, Hashable {
            let id:Int?
            let text:String?
            let type:String?
            let client_id:String?
        }
    }
}

