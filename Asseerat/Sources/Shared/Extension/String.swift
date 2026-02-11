//
//  File.swift
//  MyLibrary
//
//  Created by Bekzod Abdullaev on 10/06/25.
//

import UIKit
import SwiftUI

extension String {
    
    public var stringToBool: Bool {
        self == "Y"
    }
    
    public var capitalizedSentence: String {
        let firstLetter = self.prefix(1).capitalized
        let remainingLetters = self.dropFirst().lowercased()
        return firstLetter + remainingLetters
    }
    
    public var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    public var isNotEmpty: Bool {
        !isEmpty
    }
    // MARK: Remove Spaces Remove Slashes
    public func removeSpaces() -> String {
        return self.replacingOccurrences(of: " ", with: "")
    }
    public func removeSlash() -> String {
        return self.replacingOccurrences(of: "/", with: "")
    }
    public func removePlus() -> String{
        return self.replacingOccurrences(of: "+", with: "")
    }
    public func removeLine() -> String{
        return self.replacingOccurrences(of: "-", with: "")
    }
    
    public func removeDot() -> String {
        return self.replacingOccurrences(of: ".", with: "")
    }
    
    public func removeTimeDot() -> String {
        return self.replacingOccurrences(of: ":", with: "")
    }
    
    public func removeAll()-> String {
        let text = self.replacingOccurrences(of: "+", with: "")
        return text.removeSpaces().removeLine()
    }
    
    public func removeNewLine()-> String {
        return self.replacingOccurrences(of: "\n", with: " ")
    }
    
    public func expireCorrect()->String {
        let expire = self.replacingOccurrences(of: "/", with: "")
        var newString = String()
        newString.append(contentsOf: suffix(2))
        newString.append(contentsOf: expire.prefix(2))
        return newString
    }
    
    public func returnTiyin() -> String { // Goal Target Operation
        let text = self.removeSpaces()
        if self.prefix(3) != ".00" { // 1799.83
            return text
        } else {
            return ""//text.addTiyin()
        }
    }
    //90 024 02 40
    
    public func reformatAsPhone9() -> String {
        if self.count != 9 {
            return self
        }
        
        let first = self.substringRangeToLength(fromIndex: 0, length: 2)
        let second = self.substringRangeToLength(fromIndex: 2, length: 3)
        let third = self.substringRangeToLength(fromIndex: 5, length: 2)
        let fourth = self.substringRangeToLength(fromIndex: 7, length:2)
        let phone9 = first + " " + second + " " + third + " " + fourth
        return phone9
    }
    
    public func reformatAsCard() -> String {
        
        if self.count != 16 {
            return self
        }
        
        let first = self.substringRangeToLength(fromIndex: 0, length: 4)
        let second = self.substringRangeToLength(fromIndex: 4, length: 4)
        let third = self.substringRangeToLength(fromIndex: 8, length: 4)
        let fourth = self.substringRangeToLength(fromIndex: 12, length: 4)
        return first + " " + second + " " + third + " " + fourth
    }
    
    public func reformatAsAccount() -> String {
        
        if self.count != 20 {
            return self
        }
        
        let accountType = self.substringRangeToLength(fromIndex: 0, length: 5)
        let currencyCode = self.substringRangeToLength(fromIndex: 5, length: 3)
        let key = self.substringRangeToLength(fromIndex: 8, length: 1)
        let bankOrClientCode = self.substringRangeToLength(fromIndex: 9, length: 8)
        let order = self.substringRangeToLength(fromIndex: 17, length: 3)
        return accountType + " " + currencyCode + " " + key + " " + bankOrClientCode + " " + order
        
    }
    
    public func reformatAsSum() -> String {
        
        if (self.count) == 0 {
            return ""
        }
        var formatedself = self
        formatedself = formatedself.replacingOccurrences(of: " ", with: "")
        formatedself = formatedself.replacingOccurrences(of: ",", with: ".")
        if formatedself[0] == "."{
            return ""
        }
        if(formatedself.count > 1){
            if(formatedself[formatedself.count-2] == "." && formatedself[formatedself.count-1] == ".") {
                let nss = formatedself as NSString
                return nss.substring(to: nss.length - 1)
            }
        }
        if (formatedself.count == 2){
            if formatedself[0] == "0" && formatedself[1] != "."{
                return ""
            }
        }
        var fraction = ""
        if self.contains(".")  {
            let location = (formatedself as NSString).range(of: ".").location
            fraction = (formatedself as NSString).substring(from: location)
            if fraction.count > 3 {
                fraction = (fraction as NSString).substring(to: 3)
            }
            formatedself = (formatedself as NSString).substring(to: location)
        }
        
        var newString = ""
        var split = -1
        
        var array: [AnyHashable] = []
        var i = formatedself.count - 1
        while i >= 0 {
            split += 1
            if split == 3 {
                array.append(" ")
                split = 0
            }
            array.append(String(format: "%C", (formatedself as NSString).character(at: i)))
            i -= 1
        }
        for j in 0..<array.count {
            newString = "\(newString)\(array[array.count - j - 1])"
        }
        
        newString = newString + (fraction)
        
        
        return newString
    }
}

extension String {
    public var length: Int {
        return count
    }
    
    public func subscriptByOne (i: Int) -> String {
        return self.subscriptRange(r: i ..< i + 1)
    }
    
    public func substring(fromIndex: Int) -> String {
        return self.subscriptRange(r: min(fromIndex, length) ..< length)
    }
    
    public func substring(toIndex: Int) -> String {
        return self.subscriptRange(r:0 ..< max(0, toIndex))
    }
    
    public func subscriptRange(r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
    public func substringRangeToLength(fromIndex:Int, length:Int) -> String{
        let nsRange = NSRange(location: fromIndex, length: length)
        let nsString = self as NSString
        let substring = nsString.substring(with: nsRange)
        return String(substring)
    }
}

public extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}

private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}

public extension Double {
    func integerPart()->String{
        let result = floor(abs(self)).description.dropLast(2).description
        let plusMinus = self < 0 ? "-" : ""
        return  plusMinus + result
    }
    func fractionalPart(_ withDecimalQty:Int = 2)->String{
        let valDecimal = self.truncatingRemainder(dividingBy: 1)
        let formatted = String(format: "%.\(withDecimalQty)f", valDecimal)
        let dropQuantity = self < 0 ? 3:2
        return formatted.dropFirst(dropQuantity).description
    }
}

public extension String {
    
    func split(regex pattern: String) -> [String] {
        
        guard let re = try? NSRegularExpression(pattern: pattern, options: [])
        else { return [] }
        
        let nsString = self as NSString // needed for range compatibility
        let stop = "<SomeStringThatYouDoNotExpectToOccurInSelf>"
        let modifiedString = re.stringByReplacingMatches(
            in: self,
            options: [],
            range: NSRange(location: 0, length: nsString.length),
            withTemplate: stop)
        return modifiedString.components(separatedBy: stop)
    }
    
    func monthFormatter() -> String {
        let string = ""//self.removeNonDigits()
        if let month = Int(string) {
            if month == 1 {
                return "\(month) \("месяц")"
            } else if month > 1 && month < 5 {
                return "\(month) \("месяца")"
            } else {
                return "\(month) \("месяцев")"
            }
        } else {
            return ""
        }
    }
    
    func changeFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "UZ")
        dateFormatter.dateFormat = "dd.MM.yyyy hh:mm:ss" // input format
        let date = dateFormatter.date(from: self) ?? Date()
        dateFormatter.dateFormat = "hh:mm" // output format
        let string = dateFormatter.string(from: date)
        return string
    }
    
    func changeFormatChat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "UZ")
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss" // input format
        let date = dateFormatter.date(from: self) ?? Date()
        dateFormatter.dateFormat = "HH:mm" // output format
        let string = dateFormatter.string(from: date)
        return string
    }
    
    func uzcardFormatChange() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "UZ")
        dateFormatter.dateFormat = "dd.MM.yyyyHH:mm:ss" // input format
        let date = dateFormatter.date(from: self) ?? Date()
        dateFormatter.dateFormat = "HH:mm" // output format
        let string = dateFormatter.string(from: date)
        return string
    }
    
    func formatRemoveSeconds() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "UZ")
        dateFormatter.dateFormat = "dd.MM.yyyyHH:mm:ss" // input format
        let date = dateFormatter.date(from: self) ?? Date()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm" // output format
        let string = dateFormatter.string(from: date)
        return string
    }
    func formatRemoveMinutes() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "UZ")
        dateFormatter.dateFormat = "dd.MM.yyyyHH:mm:ss" // input format
        let date = dateFormatter.date(from: self) ?? Date()
        dateFormatter.dateFormat = "dd.MM.yyyy" // output format
        let string = dateFormatter.string(from: date)
        return string
    }
}

public extension Int {
    func returnDayString()->String {
        if self == 1 {
            return "\(self) \("день")"
        } else if self > 1 && self < 5 {
            return "\(self) \("дня")"
        } else {
            return "\(self) \("дней")"
        }
    }
}


extension String{
    func replace(_ dictionary: [String: String]) -> String{
        var result = String()
        var i = -1
        for (of , with): (String, String)in dictionary{
            i += 1
            if i<1{
                result = self.replacingOccurrences(of: of, with: with)
            }else{
                result = result.replacingOccurrences(of: of, with: with)
            }
        }
        return result
    }
}

extension String {
    
    public subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    public subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    public subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[start ..< end])
    }
    
    subscript (bounds: CountableRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ..< end]
    }
    subscript (bounds: CountableClosedRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ... end]
    }
    
    subscript (bounds: CountablePartialRangeFrom<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(endIndex, offsetBy: -1)
        return self[start ... end]
    }
    subscript (bounds: PartialRangeThrough<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ... end]
    }
    subscript (bounds: PartialRangeUpTo<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ..< end]
    }
    
    func luhnCheck() -> Bool {
        var sum = 0
        let digitStrings = self.reversed().map { String($0) }
        
        for tuple in digitStrings.enumerated() {
            if let digit = Int(tuple.element) {
                let odd = tuple.offset % 2 == 1
                
                switch (odd, digit) {
                case (true, 9):
                    sum += 9
                case (true, 0...8):
                    sum += (digit * 2) % 9
                default:
                    sum += digit
                }
            } else {
                return false
            }
        }
        if sum > 0 {
            return sum % 10 == 0
        } else {
            return false
        }
    }
    
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
    public func reformatText(curr: String, isChangeColor: Bool = false) -> Text {
        
        var resultText: String = ""
        
        if !self.contains(".") {
            resultText = self + ".00"
        } else {
            resultText = self
        }
        
        let textArr = resultText.components(separatedBy: ".")
        
        let darkText = textArr[0]
        let formattedText = darkText.reformatAsSum()
        let lightText = textArr[1]
        
        return Text(formattedText).foregroundColor(Colors.white) + Text("." + lightText).foregroundColor(isChangeColor ? Colors.seccondary : Colors.white) + Text(" " + curr).foregroundColor(isChangeColor ? Colors.seccondary : Colors.white)
    }
}
