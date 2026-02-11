//
//  HomeARModel.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 07/10/25.
//

import Foundation

struct HomeARModel {
    struct Response {
        
        struct HomeARList:APIData {
            var code: Int?
            var msg: String?
            let total: Int?
            let rows:[HomeARListRows]?
        }
        
        struct HomeARListRows: Codable, Hashable {
            let id:Int?
            let name_uz:String?
            let name_ru:String?
            let name_en:String?
            let description_uz:String?
            let description_ru:String?
            let description_en:String?
            let state:String?
            let file_hash_id:String?
        }
    }
}
