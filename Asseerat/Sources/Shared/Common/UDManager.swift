//
//  UDManager.swift
//  Asseerat
//
//  Created by Bekzod Abdullaev on 02/07/25.
//

import Foundation

public enum UDManagerKeys:String {
    case currentLanguageKey = "LANGUAGE"
    case faceId = "FACEID"
    case alreadyInstalled = "ALREADY_INSTALLED"
    case profileImage = "PROFILE_IMAGE"
    case dhikrCount = "DHIKR_COUNT"
    case userLogin = "USER_LOGIN"
    case userPassword = "USER_PASSWORD"
    case userLoginType = "USER_LOGIN_TYPE"
    case dbVersion = "DATA_BASE_VERSION"
    case isLaunched = "IS_LAUNCHED"
    case prayerTimes = "PRAYER_TIMES"
    case prayerAddress = "PRAYER_ADDRESS"
    case lastPrayerAddress = "LAST_PRAYER_ADDRESS"
    case aiType = "AI_TYPE"
    
}

public class UDManager {
    // Shared instance
    public static let shared = UDManager()
    
    public static var languageID: String {
        switch UDManager.shared.getString(key: UDManagerKeys.currentLanguageKey) {
        case "uz":
            return "uzl"
        case "ru":
            return "ru"
        case "en":
            return "en"
        default:
            return "ru"
        }
    }
    
    public func clear() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
    
    public func setSting(key:UDManagerKeys, object:String) {
        
        UserDefaults.standard.setValue(object, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    public func getString(key:UDManagerKeys) -> String {
        return UserDefaults.standard.string(forKey: key.rawValue) ?? ""
    }
    
    public func setBool(key:UDManagerKeys, object:Bool) {
        UserDefaults.standard.setValue(object, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    public func getBool(key:UDManagerKeys) -> Bool {
        return UserDefaults.standard.bool(forKey: key.rawValue)
    }
    
    public func setObject<T>(key: UDManagerKeys, object: [T]) where T: Codable {
        let encodedData = try? JSONEncoder().encode(object)
        UserDefaults.standard.set(encodedData, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
        
    public func getObject<T>(key: UDManagerKeys) -> [T]? where T: Codable {
        if let data = UserDefaults.standard.value(forKey: key.rawValue) as? Data {
            let object = try? JSONDecoder().decode([T].self, from: data)
            return object
        }
        return nil
    }
    
    public func removeObejct(key: UDManagerKeys) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
}
