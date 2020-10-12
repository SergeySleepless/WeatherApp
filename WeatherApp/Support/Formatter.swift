//
//  Formatter.swift
//  WeatherApp
//
//  Created by Сергей Гаврилов on 11.10.2020.
//

import Foundation

protocol WeatherDateFormatter {
    func getWeekdayName(date: String) -> String
    func getWeekday(date: String) -> Int
    func getTime(date: String) -> String
}

class Formatter {
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH-mm-ss"
        return formatter
    }()
    
}

extension Formatter: WeatherDateFormatter {
    func getWeekdayName(date: String) -> String {
        if let date = formatter.date(from: date) {
            var calendar = Calendar.current
            calendar.locale = Locale(identifier: "ru")
            let comp = calendar.dateComponents([.weekday], from: date)
            if let weekday = comp.weekday {
                return calendar.weekdaySymbols[weekday - 1].capitalized
            }
        }
        return ""
    }
    
    func getWeekday(date: String) -> Int {
        if let date = formatter.date(from: date) {
            if let weekday = Calendar.current.dateComponents([.weekday], from: date).weekday {
                return weekday
            }
        }
        return 0
    }
    
    func getTime(date: String) -> String {
        if let date = formatter.date(from: date) {
            if let hour = Calendar.current.dateComponents([.hour], from: date).hour {
                return String(format: "%02d", hour)
            }
        }
        return ""
    }
}
