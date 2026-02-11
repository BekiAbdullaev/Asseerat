//
//  File.swift
//  
//
//  Created by Bekzod Abdullaev on 10/17/22.
//

import Foundation
public protocol ErrorResponsing {
    var code:Int? { get }
    var msg: String? { get set }
}
