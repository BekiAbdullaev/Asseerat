//
//  File.swift
//  MyLibrary
//
//  Created by Bekzod Abdullaev on 02/06/25.
//

import UIKit
import SwiftUI

class MainBean: NSObject {
    
    // MARK: - Shared instance of Global
    static let shared = MainBean()
    lazy var userInfo:UserInfo? = nil
    public var userID: String?
    
    
    func changeToBindingBool(bool:Bool)-> Binding<Bool> {
        let boolBinding = Binding<Bool>( get: { bool }, set: { newValue in } )
        return boolBinding
    }
    
    func getDBVersion() -> Int {
        let dbVersionUDM = UDManager.shared.getString(key: .dbVersion)
        let dbVersion = Int(dbVersionUDM) ?? 0
            
        if dbVersionUDM.isEmpty {
            UDManager.shared.setSting(key: .dbVersion, object: "0")
        }
        return dbVersion
    }
    
    func userSignedIn() -> Bool {
        let login = UDManager.shared.getString(key: .userLogin)
        let password = UDManager.shared.getString(key: .userPassword)
        return !login.isEmpty && !password.isEmpty
    }
    
    func convertDateToString(date:Date)->String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: date)
    }
    
    func getTodayDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: date)
    }
    
    func getPreviousWeekDay() -> String {
        let now = Calendar.current.dateComponents(in: .current, from: Date())
        let weekBefore = DateComponents(year: now.year, month: now.month, day: now.day! - 7)
        let date = Calendar.current.date(from: weekBefore)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: date)
    }
    
    func getTomorrowDate()->String{
        let now = Calendar.current.dateComponents(in: .current, from: Date())
        let tomorrow = DateComponents(year: now.year, month: now.month, day: now.day! + 1)
        let dateTomorrow = Calendar.current.date(from: tomorrow)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: dateTomorrow)
    }
    
    func getNextDate(date:Date, interval:Int)->Date{
        let now = Calendar.current.dateComponents(in: .current, from: date)
        let tomorrow = DateComponents(year: now.year, month: now.month, day: now.day! + interval)
        return Calendar.current.date(from: tomorrow)!
    }
    
    func getPreviousDate(date:Date)->Date{
        let now = Calendar.current.dateComponents(in: .current, from: date)
        let yesterday = DateComponents(year: now.year, month: now.month, day: now.day! - 1)
        return Calendar.current.date(from: yesterday)!
    }
    
    func getCurrentTime()->String{
        let d = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .init(identifier: "uz_Latn_UZ")
        dateFormatter.defaultDate = Calendar.current.startOfDay(for: Date())
        dateFormatter.dateFormat = "HH:mm"
        let time = dateFormatter.string(from: d)
        return time
    }
    
    func getHabitType(type:String) -> String {
        switch type {
        case "D":
            return "Daily goal"
        case "W":
            return "Weekly goal"
        default:
            return "Monthly goal"
        }
    }
}



public extension Formatter {
    static let today: DateFormatter = {
        let d = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .init(identifier: "uz_Latn_UZ")
        dateFormatter.defaultDate = Calendar.current.startOfDay(for: Date())
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter
        
    }()
}
