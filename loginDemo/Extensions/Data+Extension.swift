//
//  Data+Extension.swift
//  SharkID
//
//  Created by Vikram Jagad on 12/03/19.
//  Copyright © 2019 sttl. All rights reserved.
//

import Foundation

extension Data {
    mutating func appendString(string: String) {
        if let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true){
            append(data)
        }
    }
}

extension NSMutableData {
    func appendString(_ string: String){
        if let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true){
            append(data)
        }
    }
}
