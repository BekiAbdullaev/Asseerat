//
//  File.swift
//  
//
//  Created by Bekzod Abdullaev on 10/17/22.
//

import Foundation

public typealias APIData = (Codable & ErrorResponsing)
public enum APIResponse<Value> {
    case success(Value?), failure(ErrorResponse)
}
