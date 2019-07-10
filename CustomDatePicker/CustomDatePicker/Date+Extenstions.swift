//
//  Date+Extenstions.swift
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
}
