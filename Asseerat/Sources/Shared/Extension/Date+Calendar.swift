//
//  File.swift
//  MyLibrary
//
//  Created by Bekzod Abdullaev on 10/06/25.
//

import Foundation

extension Date: @retroactive RawRepresentable {
    public var rawValue: Double {
        self.timeIntervalSinceReferenceDate
    }
    
    public init?(rawValue: Double) {
        self = Date(timeIntervalSinceReferenceDate: rawValue)
    }
    
    public var day: Int {
        Calendar.iso8601.ordinality(of: .day, in: .month, for: Date())!
    }
    
    public var month: Int {
        Calendar.iso8601.component(.month, from: Date())
    }
    
    public var year: Int {
        Calendar.iso8601.component(.year, from: Date())
    }
    
}

public extension Calendar {
    static let iso8601 = Calendar(identifier: .iso8601)
}

public typealias Strings = [String]

public extension String {
    func getCustomDay() -> String {
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
          
        guard let dateObj = dateFormatter.date(from: self.substring(toIndex: 19)) else {
              return "Invalid date format"
          }
          
          dateFormatter.dateFormat = "dd.MM.yyyy"
          return dateFormatter.string(from: dateObj)
      }
    func getCustomDayWithDots() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddMMyyyy"
        let dateObj = dateFormatter.date(from: self)

        dateFormatter.dateFormat = "dd.MM.yyyy"
        return "\(dateFormatter.string(from: dateObj ?? Date()))"
    }
}

extension Date {
    private static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter
    }()

    var ddmmyyyy: String {
        return Date.formatter.string(from: self)
    }
}
