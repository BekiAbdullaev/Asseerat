//
//  File.swift
//  
//
//  Created by Bekzod Abdullaev on 10/17/22.
//

import Foundation
public struct DefaultResponse: APIData {
    public var code: Int?
    public var msg: String?
}

struct ErrorResult:Codable {
    var field:String?
    var msg:String?
}
