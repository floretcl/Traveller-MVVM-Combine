//
//  Extensions.swift
//  Traveller
//
//  Created by Clément FLORET on 15/03/2022.
//

import Foundation
import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    func navigationBarColors(backgroundColor: UIColor, tintColor: UIColor) -> some View {
        self.modifier(NavigationBarColors(backgroundColor: backgroundColor, tintColor: tintColor))
    }
}

extension String {
    var isBlank: Bool {
        return allSatisfy { char in
            char.isWhitespace
        }
    }
}

extension Double {
    var toTempCelsius: String {
        let value: Int = Int(self.rounded(.toNearestOrAwayFromZero))
        return "\(value)°C"
    }
    
    var toTempFarenheit: String {
        let value: Int = Int(self.rounded(.toNearestOrAwayFromZero))
        return "\(value)°F"
    }
    
    var toKmPerHour: String {
        var value: Int = Int(self.rounded(.toNearestOrAwayFromZero))
        value = (value * 3600) / 1000
        return "\(value)Km/h"
    }
    
    var toMilesPerHour: String {
        let value: Int = Int(self.rounded(.toNearestOrAwayFromZero))
        return "\(value)M/h"
    }
}

extension Int {
    var toTwoDigits: String {
        if self < 10 {
            return "0" + String(self)
        }
        else {
            return String(self)
        }
    }
    
    var toPressHpa: String {
        return "\(self)hPa"
    }
    
    var toPercent: String {
        return "\(self)%"
    }
    
    var toVisibility: String {
        if self >= 1000 {
            return "\(self / 1000)Km"
        } else {
            return "\(self)m"
        }
        
    }
    
    var degreesToDirection: String {
        switch self {
        case 338...360:
            return "N"
        case 0..<22:
            return "N"
        case 22..<67:
            return "NE"
        case 67..<112:
            return "E"
        case 112..<157:
            return "SE"
        case 157..<202:
            return "S"
        case 202..<247:
            return "SW"
        case 247..<292:
            return "W"
        case 292..<338:
            return "NW"
        default:
            return "--"
        }
    }
}

extension TimeInterval {
    var toHour12h: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        let date = Date(timeIntervalSince1970: self)
        return formatter.string(from: date)
    }
    
    var toHour24h: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        formatter.dateFormat = "HH:mm"
        let date = Date(timeIntervalSince1970: self)
        return formatter.string(from: date)
    }
    
    var toDate24h: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        let date = Date(timeIntervalSince1970: self)
        return formatter.string(from: date)
    }
}

extension Dictionary where Value: Equatable {
    func someKey(forValue val: Value) -> Key? {
        return first(where: { $1 == val })?.key
    }
}
