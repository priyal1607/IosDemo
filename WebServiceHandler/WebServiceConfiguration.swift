//
//  WebServiceConfiguration.swift
//  SharkID
//
//  Created by Vikram Jagad on 25/02/19.
//  Copyright © 2019 sttl. All rights reserved.
//

import UIKit

public enum AppServer {
    case local
    case stage
    case beta
    case production
    
    func contains(_ whereElements: Self...) -> Bool {
        return whereElements.filter({ $0 == self }).count > 0
    }
}

var current_AppServer : AppServer { return .local }
var app_hostURL: String {
    switch current_AppServer {
    case .local: return "http://194.233.91.149:3000"
    case .stage: return "http://134.209.222.136"
    case .beta: return ""
    case .production: return ""
    }
}

var app_BaseURL: String {
    switch current_AppServer {
    case .local: return app_hostURL + "/api/v2/mobile/"
    case .stage: return app_hostURL + "/khel_sathi/api/rest/"
    case .beta: return app_hostURL + ""
    case .production: return app_hostURL + ""
//    case .production: return app_hostURL + "/MEAMobileServicev1/"
    }
}

var app_WebServer_BaseURL: String {
    switch current_AppServer {
    case .local: return app_hostURL
    case .stage: return app_hostURL
    case .beta: return app_hostURL
    case .production: return app_hostURL
    }
}


enum API_URL {
    case other(String)
    case pathType(URL_Path_Type)
    case otherWebViewType(String)
    
    static var shareApp : String { return "" }
    
    var fullURLString : String {
        switch self {
        case .other(let urlstr):
            return urlstr
//            ""
        case .pathType(let path):
            return app_BaseURL + path.rawValue
        case .otherWebViewType(let urlPath):
            return app_WebServer_BaseURL + (urlPath.hasPrefix("/") ? "" : "/") + urlPath
        }
    }
    
    public enum URL_Path_Type : String {
        case getFacilities = "getFacilities"
        case getList = "getList"
        case getDropdown = "getDropdown"
        case getSports = "getSports"
        case registration = "registration"
        case getHomePage = "getHomePage"
        case login = "login"
        case logout = "logout"
        case notification = "notification"
        case getPlayerLists = "getPlayerLists"
        case getFacilityHostels = "getFacilityHostels"
        case applyAwards = "applyAwards"
        case changePass = "changePassword"
        case editProfile = "editProfile"
        case getDetails = "getDetails"
        case getUserDetails = "getUserDetails"
        case getCamplist = "getCamplist"
        case getMatchlist = "getMatchlist"
        case getSelectionlist = "getSelectionlist"
        case getTriallist = "getTriallist"
        case getFacilityGround = "getFacilityGround"
        case getFacilityColleges = "getFacilityColleges"
        case getFacilityAcademy = "getFacilityAcademy"
        case getContent = "getContent"
        case homescreen = "homescreen"
        case sagDropDownList = "http://sagportal.php-staging.com/apiv2/get-inschool-program-master"
    }
}

//MARK: - WebURLS
let HSIIDCOfficialWebsiteURL = "https://www.hsiidc.org.in/"
let HEPCURL = "https://investharyana.in/"
let GlobalCityGurugramURL = "https://globalcitygurugram.in/"
let LandPurchasePortaleBhoomiURL = "http://ebhoomiharyana.org.in/"
let eProcurementURL = "https://etenders.hry.nic.in/nicgep/app"
let IndustriesDepartmentHaryanaURL = "https://haryanaindustries.gov.in/"
let contactUs = "https://www.google.co.in/"
let aboutUs = "https://www.google.co.in/"

//MARK: - Social Media
let facebookURL = "https://facebook.com/MDHsiidc"
let twitterURL = "https://twitter.com/mdhsiidc"
let instagramURL = "https://instagram.com/mdhsiidc"
let youTubeURL = "https://www.youtube.com/channel/UCE6ILe8CdyEJ5Y9IKtsCUSg"

struct HtmlWebContent {
    
    static let AboutUs = """
<p style='margin-top:0cm;margin-right:0.3cm;margin-bottom:8.0pt;margin-left:0.3cm;line-height:normal;font-size:15px;font-family:"Poppins",Bold;'><strong><span style='font-size:22px;font-family:"Poppins",serif;'>Organization&nbsp;</span></strong></p>
    <p style='margin-top:0.5cm;margin-right:0.3cm;margin-bottom:8.0pt;margin-left:0.3cm;line-height:normal;font-size:16px;font-family:"Poppins",Medium;'><strong><span style='font-size:16px;font-family:"Poppins",Medium;'>FORMATION</span></strong><span style='font-size:16px;font-family:"Poppins",Medium;'>&nbsp;</span></p>
    <p style='text-align:justify;margin-top:0cm;margin-right:0.3cm;margin-bottom:8.0pt;margin-left:0.3cm;line-height:normal;font-size:15px;font-family:"Poppins",Regular;'><span style='font-size:15px;font-family:"Poppins",Regular;'>Haryana State Industrial and Infrastructure Development Corporation Limited (HSIIDC) was established in 1967 as a wholly owned company by the State of Haryana. It functions under the aegis of the Department of Industries and Commerce, Government of Haryana.&nbsp;</span></p>
    <p style='margin-top:0.5cm;margin-right:0.3cm;margin-bottom:8.0pt;margin-left:0.3cm;line-height:normal;font-size:16px;font-family:"Poppins",Medium;'><strong><span style='font-size:16px;font-family:"Poppins",Medium;'>OBJECTS</span></strong><span style='font-size:16px;font-family:"Poppins",Medium;'>&nbsp;</span></p>
    <p style='text-align:justify;margin-top:0cm;margin-right:0.3cm;margin-bottom:8.0pt;margin-left:0.3cm;line-height:normal;font-size:15px;font-family:"Poppins",Regular;'><span style='font-size:15px;font-family:"Poppins",Regular;'>The objects of Haryana State Industrial and Infrastructure Development Corporation Limited (HSIIDC) include, inter-alia, the development of industrial infrastructure of the State and to acquire lands for integrated industry townships/parks including housing and related social, institutional, recreational and commercial infrastructure essential for promotion and growth of industry in the state of Haryana and develop them suitably.</span></p>
"""
}

