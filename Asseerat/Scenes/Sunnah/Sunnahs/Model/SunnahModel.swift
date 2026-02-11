//
//  SunnahModel.swift
//  Asseerat
//
//  Created by Nargiza Rahimova on 07/09/25.
//

import Foundation

enum SunnahModel {
    
    struct Request{
        
        struct IncrementHabitRecord: Codable {
            let count: Int
            let date: String
            let client_id: String
            let habit_id: Int
            
            init(count: Int, date: String, client_id: String, habit_id: Int) {
                self.count = count
                self.date = date
                self.client_id = client_id
                self.habit_id = habit_id
            }
        }
    }
    
    
    
    struct Response {
        
        struct GetClientHabitsResponse:APIData {
            let code: Int?
            var msg: String?
            let total: Int?
            let rows: [GetClientHabitsRows]?
        }
        
        struct GetHabitRecordsResponse:APIData {
            let code: Int?
            var msg: String?
        }
        
        struct IncrementHabitRecordResponse:APIData {
            let code: Int?
            var msg: String?
        }
        
        struct SunnahTypeResponse:APIData {
            let code: Int?
            var msg: String?
            let total:Int?
            let rows: [SunnahTypeRows]?
        }
    }
    
    struct GetClientHabitsRows: Codable, Hashable {
        let id: Int?
        let type :SunnahTypeRows?
        let state: String?
        let name: String?
        let status: Int?
        let created_at:String?
        let updated_at:String?
        let order_id:Int?
        let description_uz:String?
        let frequency_type:String?
        let client_id:String?
        let frequency_value:[Int]?
        let required_count:Int?
        let alert_state:String?
        let alert_time:String?
        let icon_name:String?
        let type_id:Int?
        let current_count:Int?
        init(id: Int?, type: SunnahTypeRows?, state: String?, name: String?, status: Int?, created_at: String?, updated_at: String?, order_id: Int?, description_uz: String?, frequency_type: String?, client_id: String?, frequency_value: [Int]?, required_count: Int?, alert_state: String?, alert_time: String?, icon_name: String?, type_id: Int?, current_count: Int?) {
            self.id = id
            self.type = type
            self.state = state
            self.name = name
            self.status = status
            self.created_at = created_at
            self.updated_at = updated_at
            self.order_id = order_id
            self.description_uz = description_uz
            self.frequency_type = frequency_type
            self.client_id = client_id
            self.frequency_value = frequency_value
            self.required_count = required_count
            self.alert_state = alert_state
            self.alert_time = alert_time
            self.icon_name = icon_name
            self.type_id = type_id
            self.current_count = current_count
        }
    }
}

struct SunnahTypeRows: Codable, Hashable {
    let id:Int?
    let state:String?
    let name_en:String?
    let created_at:String?
    let updated_at:String?
    init(id: Int?, state: String?, name_en: String?, created_at: String?, updated_at: String?) {
        self.id = id
        self.state = state
        self.name_en = name_en
        self.created_at = created_at
        self.updated_at = updated_at
    }
}
