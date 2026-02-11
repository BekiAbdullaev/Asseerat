//
//  File.swift
//  MyLibrary
//
//  Created by Bekzod Abdullaev on 02/06/25.
//

import Foundation
import UIKit

public class SecurityBean {
    public static let shared = SecurityBean()
    private init() {}
    
    var token: String = ""
    var userId:String = ""
    
    public func getDeviceID() -> String {
        UIDevice.current.identifierForVendor!.uuidString
    }
}
