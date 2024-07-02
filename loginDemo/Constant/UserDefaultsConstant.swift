//
//  UserDefaultsConstant.swift
//  SharkID
//
//  Created by Vikram Jagad on 25/02/19.
//  Copyright © 2019 sttl. All rights reserved.
//

import Foundation

struct UserPreferencesKeys {
    struct API {
        static let apiToken = "apiToken"
        static let greenenergylist = "greenenergylist"
    }
    struct Alamofire {
        static let apiRequestTimeOut = "Api_Request_TimeOut"
    }
    struct General {
        static let intro = "intro"
        static let isUserLoggedIn = "isUserLoggedIn"
        static let skippedLogin = "skippedLogin"
        static let languageCode = "languageCode"
        static let isSkip = "isSkip"
        static let email = "email"
        static let name = "name"
        static let token = "token"
        static let form_type = "form_type"
        static let userImg = "userImg"
        static let isLanguageSelected = "isLanguageSelected"
     
        static let rememberEmail = "rememberEmail"
        static let rememberPass = "rememberPass"
        static let placeDetail = "PlaceDetail"
       
        static let customizeDashboardDataList = "customizeDashboardDataList"
        static let isChangeCustomizeDashboardDataList = "isChangeCustomizeDashboardDataList"
        
        static let appearanceMode = "custom_application_Appearance_Mode"
        
    }
    
    struct DeviceInfo {
        static let deviceID = "deviceid"
        static let deviceNotificationTokenSend = "deviceNotificationTokenSend"
        static let deviceNotificationToken = "deviceNotificationToken"
    }
    
    struct UserInfo {
        static let userID = "userID"
        static let userDetail = "userDetail"
        static let token = "token"
    }
    
    struct Notification {
        static let lmd = "lmd"
        static let notificationCount = "notificationCount"
    }
    
    struct Notes {
        static let addNotes = "addNotes"
    }
}


