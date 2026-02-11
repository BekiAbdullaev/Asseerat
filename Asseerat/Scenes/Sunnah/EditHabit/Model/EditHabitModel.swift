//
//  EditHabitModel.swift
//  Asseerat
//
//  Created by Nargiza Rahimova on 13/09/25.
//

import Foundation

enum EditHabitModel {
    
    struct Request{
        
        struct EditHabit: Codable {
            let id: Int
            let orderId: Int
            let state: String
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
            
            init(id: Int, orderId: Int, state: String, name: String, description_uz: String, frequency_type: String, client_id: String, frequency_value: [Int]?, required_count: Int, alert_state: String, alert_time: String?, icon_name: String?, type_id: Int?) {
                self.id = id
                self.orderId = orderId
                self.state = state
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
        struct EditHabitResponse:APIData {
            let code: Int?
            var msg: String?
        }
        
    }
}
