//
//  Date+Extenstions.swift
//  PartTime
//
//  Created by mohamed shaat on 7/18/18.
//  Copyright © 2018 mohamed shaat. All rights reserved.
//

import UIKit

extension Date {
    func toString(format: String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale =  NSLocale(localeIdentifier: "en_US_POSIX") as Locale?
        return dateFormatter.string(from: self)
    }
    
    func DateComponentsToString()->String{
        let date = Date()
        let calendar = Calendar.current
        let year =  calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        return "\(year)\(month)\(day)\(hour)\(minutes)\(seconds)"
    }
    
}
