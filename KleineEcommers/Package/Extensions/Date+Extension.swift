//
//  Date+Extension.swift
//  PlaygroundForTesting
//
//  Created by Yousef on 7/20/21.
//

import Foundation

fileprivate class DateManager {
    static var shared = DateManager()
    
    private var formatter = DateFormatter()
    
    private init() { }
   
    func longDate(_ date: Date) -> String {
        formatter.dateStyle = .long
        
        return formatter.string(from: date)
    }
    
    func mediumDate(_ date: Date) -> String {
        formatter.dateStyle = .medium
        
        return formatter.string(from: date)
    }
    
    func shortDate(_ date: Date) -> String {
        formatter.dateStyle = .short
        
        return formatter.string(from: date)
    }
    
    func custom(_ date: Date) -> String {
        formatter.dateFormat = "dd/ MMM /yyyy"
        return formatter.string(from: date)
    }
    
    func from(_ str: String) -> Date {
        formatter.dateFormat = "dd/MMM/yyyy"
        return formatter.date(from: str) ?? Date()
    }
    
    func shortTime(_ date: Date) -> String {
        formatter.dateFormat = "hh:mm"
        return formatter.string(from: date)
    }
    
    func mediumTime(_ date: Date) -> String {
        formatter.dateFormat = "hh:mm:ss"
        return formatter.string(from: date)
    }
    
    func dateFormatter() -> DateFormatter {
        return formatter
    }
}

extension Date {
    func equal(date: Date) -> Bool {
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
        let selfComponents = Calendar.current.dateComponents([.year, .month, .day], from: self)
        return dateComponents == selfComponents
    }
    
    func setTime(hour: Int, minutes: Int, seconds: Int) -> Date {
        return Calendar.iso8601.date(bySettingHour: hour, minute: minutes, second: seconds, of: self)!
    }
    
    static func dateComponents(timeZone: TimeZone? = TimeZone(secondsFromGMT: 0), day: Int, month: Int, year: Int, hour: Int = 12, minutes: Int = 0, seconds: Int = 0) -> Date {
        let calendar = Calendar.current
        let components = DateComponents(timeZone: timeZone, year: year, month: month, day: day, hour: hour, minute: minutes, second: seconds)
        return calendar.date(from: components)!
    }
    
    var weekday: Int {
        let weekday = Calendar.current.component(.weekday, from: self)
        return weekday
    }
    
    
    var longDate: String {
        DateManager.shared.longDate(self)
    }
    
    var mediumDate: String {
        DateManager.shared.mediumDate(self)
    }
    
    var shortDate: String {
        DateManager.shared.shortDate(self)
    }
    
    var custom: String {
        DateManager.shared.custom(self)
    }
    
    func date(byAdding object : Calendar.Component, value: Int) -> Date {
        Calendar.iso8601.date(byAdding: object, value: value, to: self) ?? Date()
    }
    
    static func from(_ str: String) -> Date {
        DateManager.shared.from(str)
    }
    
    var shortTime: String {
        DateManager.shared.shortTime(self)
    }
    
    var mediumTime: String {
        DateManager.shared.mediumTime(self)
    }
    
    static func dateFormatter() -> DateFormatter {
        DateManager.shared.dateFormatter()
    }
}

extension Calendar {
    static let iso8601 = Calendar(identifier: .iso8601)
}
