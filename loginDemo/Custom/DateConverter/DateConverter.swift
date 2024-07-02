//
//  DateConverter.swift
//  CIC
//
//  Created by Jinal Patel on 9/21/17.
//  Copyright © 2017 minesh doshi. All rights reserved.
//

import UIKit

class DateConverter: NSObject
{
    //MARK:- Properties
    //Public Properties
    static let dateFormatter = DateFormatter()

    class func getDateString(aStrDate : String?, inputFormat : String, outputFormat : String) -> String
    {
        guard let stringDate = aStrDate?.is_trimming_WS_NL_to_String else {
            return ""
        }
        
        dateFormatter.dateFormat = inputFormat
        
        if let convertedDate: Date = dateFormatter.date(from: stringDate) {
            dateFormatter.dateFormat = outputFormat
            let dateFormated = dateFormatter.string(from: convertedDate)
            return dateFormated
        } else {
            return ""
        }
    }
    
    class func getDateStringFromDate(aDate: Date?, outputFormat: String) -> String {
        guard let aDate = aDate else { return "" }
        
        dateFormatter.dateFormat = outputFormat
        
        let dateFormated = dateFormatter.string(from: aDate)
        return dateFormated
    }
    
    class func getDateFromDateString(aDateString : String?, inputFormat : String) -> Date? {
        guard let stringDate = aDateString?.is_trimming_WS_NL_to_String else {
            return nil
        }
        
        dateFormatter.dateFormat = inputFormat
        
        return dateFormatter.date(from: stringDate)
    }
    
    class func getDate(fromTimeStamp timeStamp: String) -> Date? {
        if let timeStampDouble = Double(timeStamp) {
            return Date(timeIntervalSince1970: timeStampDouble)
        }
        return nil
    }
    
    //MARK:- Get TimeStamp
    class func getTimeStamp() -> String {
        let date = Date()
        let timestamp = String(format:"%.0f",date.timeIntervalSince1970 * 1000)
        return timestamp
    }//End
    
    class func getMonths() -> [String] {
        var months:[String] = []
        for month in 0..<12 {
            months.append(dateFormatter.monthSymbols[month])
        }
        return months
    }
}
