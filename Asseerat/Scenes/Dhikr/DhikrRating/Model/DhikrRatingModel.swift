//
//  DhikrRatingModel.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 26/10/25.
//

import Foundation

struct DhikrRatingModel {
    struct Response {
        struct DhikrRatingList:APIData {
            var code: Int?
            var msg: String?
            let total: Int?
            let rows:[DhikrRatingRows]?
        }
        
        struct DhikrRatingRows: Codable, Hashable {
            let name:String?
            let surname:String?
            let client_id:String?
            let summ:Int?
        }
    }
}

