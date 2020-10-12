//
//  Extensions.swift
//  WeatherApp
//
//  Created by Сергей Гаврилов on 11.10.2020.
//

import Foundation

extension Date {
    func weekday() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
}

extension Array {
    var middle: Element? {
        guard count != 0 else { return nil }
        let middleIndex = (count > 1 ? count - 1 : count) / 2
        return self[middleIndex]
    }
}
