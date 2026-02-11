//
//  MyDeviceModel.swift
//  Asseerat
//
//  Created by Nargiza Rahimova on 07/09/25.
//

import Foundation

enum MyDeviceModel {
    struct DeviceResponse:APIData {
        var code: Int?
        var msg: String?
        var total: Int?
        var rows:[DeviceRow]?
    }
    
    struct DeviceRow:Codable, Hashable {
        let id: Int?
        let userId:String?
        let ip:String?
        let deviceCode:String?
        let deviceType:String?
        let appVersion:Int?
        let state:String?
    }
}
