//
//  AddHabitModel.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 10/09/25.
//

import Foundation

enum AddHabitModel {
    
    struct Request{
        struct Add: Codable {
            let name: String
            let description_uz: String
            let frequency_type: String
            let client_id: String
            let frequency_value: [Int]?
            let required_count: Int
            let alert_state: String
            let alert_time: String?
            let icon_name: String?
            let type_id: Int?
            
            init(name: String, description_uz: String, frequency_type: String, client_id: String, frequency_value: [Int]? = nil, required_count: Int, alert_state: String, alert_time: String?, icon_name: String?, type_id: Int?) {
                self.name = name
                self.description_uz = description_uz
                self.frequency_type = frequency_type
                self.client_id = client_id
                self.frequency_value = frequency_value
                self.required_count = required_count
                self.alert_state = alert_state
                self.alert_time = alert_time
                self.icon_name = icon_name
                self.type_id = type_id
            }
        }
    }
    
    
    struct Response {
        struct SunnahTemplatesResponse:APIData {
            var code: Int?
            var msg: String?
            var total: Int?
            var rows: [SunnahTemplatesRows]?
        }
    }
    
    struct SunnahTemplatesRows: Codable, Hashable {
        let id:Int?
        let state:String?
        let type: SunnahTypeRows?
        let createdAt:String?
        let updatedAt:String?
        let name_en:String?
        let description_en:String?
        let order_id:Int?
        let image_url:String?
        let frequency_type:String?
        let frequency_value:[Int]?
        let required_count:Int?
        let alert_state:String?
        let alert_time:String?
        let icon_name:String?
        let type_id:Int?
    }
    
}


