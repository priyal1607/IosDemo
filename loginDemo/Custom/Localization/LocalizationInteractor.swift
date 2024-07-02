//
//  LocalizationInteractor.swift
//  CIC
//
//  Created by STTL on 03/05/18.
//  Copyright © 2018 minesh doshi. All rights reserved. //

import Foundation

extension Notification.Name {
    
    static var languageChanged: Notification.Name { return .init(rawValue: "languageChanged") }
    
}

enum LanguageCodes : String{
    case english = "en"
    case hindi = "hi"
    
    var plistName : String {
        switch self {
        case .english: return "EnglishLocalization"
        case .hindi: return "HindiLocalization"
        }
    }
    
    var languageId : String {
        switch self {
        case .english: return "1"
        case .hindi: return "2"
        }
    }
}

class LocalizationParam {
    static var getInstance = LocalizationParam()
    
    var enLocalizationDict : NSMutableDictionary = [:]
    var localizationDict : NSMutableDictionary = [:]
    
    private init() {
    }
    
    var localizationCode : LanguageCodes = LanguageCodes.english
    {
        didSet {
            
            let path: String = Bundle.main.path(forResource: localizationCode.plistName, ofType: "plist")!
            self.localizationDict = NSMutableDictionary(contentsOfFile: path)!
            
            self.enLocalizationDict = NSMutableDictionary(contentsOfFile: Bundle.main.path(forResource: LanguageCodes.english.plistName, ofType: "plist")!)!
        }
    }
    
    static func getLocalizedStringFor(key : String) -> String{
        if let value = LocalizationParam.getInstance.localizationDict[key] as? String, value.trimming_WS_NL.count > 0 {
            return value
        }
        if let value = LocalizationParam.getInstance.enLocalizationDict[key] as? String {
            return value
        }
        return key
    }
}

extension String {
    
    var localizedString: String {
        return LocalizationParam.getLocalizedStringFor(key: self)
    }
}
