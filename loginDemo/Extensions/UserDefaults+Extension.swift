//
//  UserDefaults+Extension.swift
//  SharkID
//
//  Created by Vikram Jagad on 14/03/19.
//  Copyright © 2019 Vikram Jagad. All rights reserved.
//

import UIKit

extension UserDefaults
{
    public subscript(key: String) -> Any?
    {
        get
        {
            return object(forKey: key) as Any?
        }
        set
        {
            if var newValueLocal = newValue as? [String : Any] {
                newValueLocal = newValueLocal.filter { !($0.value is NSNull) }
                set(newValueLocal, forKey: key)
                synchronize()
            } else {
                set(newValue, forKey: key)
                synchronize()
            }
        }
    }
}
