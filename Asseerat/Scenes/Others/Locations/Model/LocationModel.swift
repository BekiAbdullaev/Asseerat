//
//  LocationModel.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 07/10/25.
//

import Foundation

enum LocationModel {
    struct CitesResponse:APIData {
        let code: Int?
        var msg: String?
        let total: Int?
        let rows: [CitiesRows]?
        
    }
    
    struct CitiesRows: Codable, Hashable {
        let id:Int?
        let name:String?
        let region_name:String?
        let longitude:Double?
        let latitude:Double?
    }
}
    
