//
//  UserPreferences.swift
//  SharkID
//
//  Created by Vikram Jagad on 14/03/19.
//  Copyright © 2019 Vikram Jagad. All rights reserved.
//

import UIKit

class UserPreferences: NSObject
{
    //MARK:- Variables
    //Public
    static let shared = UserPreferences()
    
    //Private
    private let userPreferences: UserDefaults
    
    //MARK:- Initializer
    private override init()
    {
        userPreferences = UserDefaults.standard
    }
    
    //MARK:- Get Values Methods
    class func string(forKey: String) -> String
    {
        if (forKey != "")
        {
            if let str = UserPreferences.shared.userPreferences[forKey] as? String
            {
                return str
            }
        }
        return ""
    }
    
    class func bool(forKey: String) -> Bool
    {
        if (forKey != "")
        {
            if let bool = UserPreferences.shared.userPreferences[forKey] as? Bool
            {
                return bool
            }
        }
        return false
    }
    
    class func dict(forKey: String) -> [String : Any]
    {
        if (forKey != "")
        {
            if let dict = UserPreferences.shared.userPreferences[forKey] as? [String : Any]
            {
                return dict
            }
        }
        return [:]
    }
    
    class func double(forKey: String) -> Double
    {
        if (forKey != "")
        {
            if let double = UserPreferences.shared.userPreferences[forKey] as? Double
            {
                return double
            }
        }
        return 0
    }
    
    class func int(forKey: String) -> Int
    {
        if (forKey != "")
        {
            if let int = UserPreferences.shared.userPreferences[forKey] as? Int
            {
                return int
            }
        }
        return 0
    }
    
    class func date(forKey: String) -> Date?
    {
        if (forKey != "")
        {
            if let date = UserPreferences.shared.userPreferences[forKey] as? Date
            {
                return date
            }
        }
        return nil
    }
    
    class func array(forKey: String) -> [Any]
    {
        if (forKey != "")
        {
            if let array = UserPreferences.shared.userPreferences[forKey] as? [Any]
            {
                return array
            }
        }
        return []
    }
    
    class func data(forKey: String) -> Data? {
        if (forKey != "") {
            if let data = UserPreferences.shared.userPreferences[forKey] as? Data {
                return data
            }
        }
        return nil
    }
    
    //MARK:- Set Value Method
    class func set(value: Any?, forKey: String)
    {
        if let value = value
        {
            UserPreferences.shared.userPreferences[forKey] = value
        }
        UserPreferences.shared.userPreferences.synchronize()
    }
    
    //MARK:- Remove Value Method
    class func remove(forKey: String)
    {
        if (forKey != "")
        {
            UserPreferences.shared.userPreferences.removeObject(forKey: forKey)
            UserPreferences.shared.userPreferences.synchronize()
        }
    }
}
