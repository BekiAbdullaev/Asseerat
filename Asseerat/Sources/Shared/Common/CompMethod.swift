//
//  File.swift
//  MyLibrary
//
//  Created by Bekzod Abdullaev on 02/06/25.
//

import Foundation
import UIKit


class CompMethod {
    
    static var PHONE = "PHONE"
    static var EMAIL = "EMAIL"
    static var MALE = "MALE"
    static var FEMALE = "FEMALE"
    
    //    MARK: PhoneNumber12
    @objc class func reformat(asPhoneNumber textField: UITextField) {
        if let text = textField.text{
            
            //textField.hideError()
            
            var str = ""
            var arr: [AnyHashable] = []
            var r = NSRange()
            var length = 3
            var i = 0
            
            for i in 0..<(text.count) {
                let s = (text as NSString).substring(with: NSRange(location: i, length: 1))
                
                let notDigits = CharacterSet.decimalDigits.inverted
                if (s as NSString).rangeOfCharacter(from: notDigits).location == NSNotFound {
                    str += s
                }
            }
            if str.count >= 12 {
                str = (str as NSString).substring(to: 12)
            }
            
            while i < str.count {
                r.location = i
                switch i {
                case 3:
                    length = 2
                case 5:
                    length = 3
                case 8:
                    length = 2
                case 10:
                    length = 2
                default:
                    break
                }
                if str.count - i < length {
                    r.length = str.count - i
                } else {
                    r.length = length
                }
                arr.append((str as NSString).substring(with: r))
                
                i += length
            }
            
            if arr.count == 0 {
                textField.text = ""
                return
            }
            var newStr = arr[0] as? String ?? ""
            for i in 1..<arr.count {
                newStr += " \(arr[i])"
            }
            textField.text = newStr
        }
    }
    
    
    //    MARK: PhoneNumber9
    @objc class func reformat(asPhoneNumber9 textField: UITextField) {
        if let text = textField.text{
            //textField.hideError()
            textField.text = reformatString(asPhoneNumber9: text)
        }
    }
    
    @objc class func reformatString(asPhoneNumber9 text: String) -> String {
        var str = ""
        for i in 0..<(text.count) {
            let s = (text as NSString).substring(with: NSRange(location: i, length: 1))
            
            let notDigits = CharacterSet.decimalDigits.inverted
            if (s as NSString).rangeOfCharacter(from: notDigits).location == NSNotFound {
                str += s
            }
        }
        if str.count >= 9 {
            str = (str as NSString).substring(to: 9)
        }
        var arr: [AnyHashable] = []
        var r = NSRange()
        var length = 2
        var i = 0
        while i < str.count {
            r.location = i
            switch i {
            case 2:
                length = 3
            case 5:
                length = 2
            case 7:
                length = 2
            default:
                break
            }
            if str.count - i < length {
                r.length = str.count - i
            } else {
                r.length = length
            }
            arr.append((str as NSString).substring(with: r))
            
            i += length
        }
        if arr.count == 0 {
            return ""
        }
        var newStr = arr[0] as? String ?? ""
        for i in 1..<arr.count {
            newStr += " \(arr[i])"
        }
        return newStr
    }
    
    //    MARK: Date (dd.mm.yyyy)
    @objc class func reformat(asDate textField: UITextField) {
        if let text = textField.text{
           // textField.hideError()
            textField.text = reformatString(asDate: text)
        }
    }
    
    @objc class func reformatString(asDate text: String) -> String {
        var str = ""
        for i in 0..<(text.count) {
            let s = (text as NSString).substring(with: NSRange(location: i, length: 1))
            
            let notDigits = CharacterSet.decimalDigits.inverted
            if (s as NSString).rangeOfCharacter(from: notDigits).location == NSNotFound {
                str += s
            }
        }
        if str.count >= 8 {
            str = (str as NSString).substring(to: 8)
        }
        var arr: [AnyHashable] = []
        var r = NSRange()
        var length = 2
        var i = 0
        while i < str.count {
            r.location = i
            switch i {
            case 2:
                length = 2
            case 4:
                length = 4
            default:
                break
            }
            if str.count - i < length {
                r.length = str.count - i
            } else {
                r.length = length
            }
            arr.append((str as NSString).substring(with: r))
            
            i += length
        }
        if arr.count == 0 {
            return ""
        }
        var newStr = arr[0] as? String ?? ""
        for i in 1..<arr.count {
            newStr += ".\(arr[i])"
        }
        return newStr
    }
    

    //    MARK: ExpireDate
    @objc class func reformat(asExpDate textField: UITextField) {
        if let text = textField.text{
            //textField.hideError()
            textField.text = reformatString(asExpDate: text)
        }
    }
    @objc class func reformatString(asExpDate text: String) -> String {
        var str = ""
        for i in 0..<(text.count) {
            let s = (text as NSString).substring(with: NSRange(location: i, length: 1))
            
            let notDigits = CharacterSet.decimalDigits.inverted
            if (s as NSString).rangeOfCharacter(from: notDigits).location == NSNotFound {
                str += s
            }
        }
        if str.count >= 4 {
            str = (str as NSString).substring(to: 4)
        }
        var arr: [AnyHashable] = []
        var r = NSRange()
        var i = 0
        while i < str.count {
            r.location = i
            if str.count - i < 2 {
                r.length = str.count - i
            } else {
                r.length = 2
            }
            arr.append((str as NSString).substring(with: r))
            i += 2
        }
        
        if arr.count == 0 {
            return ""
        }
        
        var newStr = arr[0] as? String ?? ""
        for i in 1..<arr.count {
            newStr += "/\(arr[i])"
        }
        
        return newStr
    }
    
    
    //   MARK: Reformat Cards
    
    @objc class func reformat(asCardNumber textField: UITextField) {
        if textField.text != nil{
           // textField.hideError()
            //textField.text = text.reformatAsCardNumber()
        }
    }
    
    @objc class func defaultTextFieldDidChange(textField: UITextField) {
       // textField.hideError()
    }
    
    //    MARK: ReformatAsSum
    @objc class func reformat(asSum textField: UITextField) {
        if textField.text != nil{
//            textField.hideError()
//            textField.text = text.reformatAsSum()
        }
    }
    
    func getPeriod(type:String) -> String {
        switch type {
        case "D":
            return "Daily"
        case "W":
            return "Weekly"
        case "M":
            return "Monthly"
        default:
            return "Daily"
        }
    }
}

