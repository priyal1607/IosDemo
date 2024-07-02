//
//  Date+Extension.swift
//  SharkID
//
//  Created by Vikram Jagad on 18/03/19.
//  Copyright © 2019 sttl. All rights reserved.
//

import Foundation

extension Date {
    static func removeSecondComponent(date: Date) -> Date? {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(in: .current, from: date)
        let newComponents = DateComponents(calendar: calendar, timeZone: .current, year: components.year, month: components.month, day: components.day, hour: components.hour, minute: components.minute)
        return newComponents.date
    }
    
    static func dateComparitionResult(_ dateToCompare:Date) -> Bool {
        var isDateBigger = true
        let date1 = Date()
        if date1 == dateToCompare
        {
            isDateBigger = false
        }
        else if date1 > dateToCompare
        {
            isDateBigger = false
        }
        else if date1 < dateToCompare
        {
            isDateBigger = true
        }
        return isDateBigger
    }
}
