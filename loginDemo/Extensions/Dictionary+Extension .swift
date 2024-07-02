//
//  Dictionary+Extension .swift
//  MyGovMaharashtra
//
//  Created by Gunjan Patel on 11/06/19.
//  Copyright © 2019 Vikram Jagad. All rights reserved.
//

import Foundation


extension Dictionary {
    var queryString: String {
        var output: String = ""
        for (key,value) in self {
            output +=  "\(key)=\(value)&"
        }
        output = String(output.dropLast())
        return output
    }
    
    func dicToJsonStr() -> String {
        var theJSONText = ""
        if let theJSONData = try? JSONSerialization.data(
            withJSONObject: self,
            options: []) {
            theJSONText = String(data: theJSONData,
                                 encoding: .ascii)!
    //            DebugLog("JSON string = \(theJSONText)")
            return theJSONText
        } else {
            return ""
        }
    }
}

