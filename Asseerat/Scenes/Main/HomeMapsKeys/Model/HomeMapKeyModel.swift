//
//  HomeMapKeyModel.swift
//  Asseerat
//
//  Created by Nargiza Rahimova on 14/10/25.
//

import Foundation

struct HomeMapKeyModel {
    struct Response {
        
        struct HomeMapKeyList:APIData {
            var code: Int?
            var msg: String?
            let total: Int?
            let rows:[HomeMapKeyListRows]?
        }
        
        struct HomeMapKeyDetail:APIData {
            var code: Int?
            var msg: String?
            let body:HomeMapKeyListRows?
        }
        
    
        struct HomeMapKeyListRows: Codable, Hashable {
            let id:Int?
            let name_uz:String?
            let name_ru:String?
            let name_en:String?
            let description_uz:String?
            let description_ru:String?
            let description_en:String?
            let state:String?
            let file_hash_id:String?
            let file_download_url:String?
        }
    }
}
