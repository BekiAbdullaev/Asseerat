//
//  File.swift
//  MyLibrary
//
//  Created by Bekzod Abdullaev on 10/06/25.
//

import UIKit
import SwiftUI
import Lottie


public class Colors {
    public static let background = Color("background")
    public static let white = Color("white")
    public static let seccondary = Color("seccondary")
    public static let btnColor = Color("btnColor")
    public static let btnColorLight = Color("btnColorLight")
    
    // Alert Colors
    public static let alertError = Color("alert-error")
    public static let alertSuccess = Color("alert-success")
    public static let alertInfo = Color("alert-info")
    public static let alertWarning = Color("alert-warning")
    
    public static let textError = Color("text-error")
    public static let textSuccess = Color("text-success")
    public static let text = Color("text")
    public static let textWarning = Color("text-warning")
    
    public static let inputStroke = Color("input-stroke")
    public static let inputBackground = Color("input-background")
    public static let green = Color("green")
}

extension UIColor {
   public static func colorWithHexString(_ hexString: String, alpha: CGFloat = 1.0) -> UIColor {
        var hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        
        guard hexString.count == 6 else {
            return UIColor(red: 0.3, green: 0.4, blue: 0.5, alpha: alpha)
        }
        
        var rgb: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
