//
//  EnumExtension.swift
//  SharkID
//
//  Created by stadmin on 25/07/17.
//  Copyright © 2017 sttl. All rights reserved.
//

import UIKit
import SwiftUI

//MARK:- Image Type
enum ImageType : String {
    case png
}



enum SideMenuIds: String {
    case home = "Home"
    case facilities = "Facilities"
    case playerList = "Player List"
    case faq = "FAQ"
    case generateCertificate = "Generate Certificate"
    case language = "Language"
    case aboutKhelSathi = "About Khel Sathi"
    case logout = "Logout"
    case changePassword = "Change Password"
    case unknown
    case login = "Login"
    case privacyPolicy = "privacypolicy"
}

enum DashboardSportsCalendar: String {
    case camps = "Camps"
    case selection = "Selections"
    case trials = "Trials"
    case matches = "Matches"
    case apply = "Apply For Awards"
    case financial = "Financial Aid"
}
enum SportsDetails: String {
    case camps = "Camps"
    case selection = "Selections"
    case trials = "Trails"
    case matches = "Matches"
    case coachs = "Coachs"
    case facilities = "Facilities"
}
enum DashboardHealthFacilities: String {
    case dietitian = "Dietitian"
    case orthopedic = "Orthopedic"
    case cardiologist = "Cardiologist"
    case neurologist = "Neurologist"
}

enum DashboardBottomCategories: String {
    case gallery = "Gallery"
    case facilities = "Facilities"
    case generate_certificate = "Generate Certificate"
}

enum campsDetails : String {
    case athletics = "Athletics"
}

enum WebViewType: String {
    case TERMSCONDITION = "Terms of Use"
    case privacyPolicy = "Privacy Policy"
    case copyRightPolicy = "Copyright Policy"
    case hyperLinkPolycy = "Hyperlinking Policy"

    
    var displayStr: String {
        switch self {
//        case .FAQ: return "FAQ".localizedString
        case .TERMSCONDITION: return "Terms of Use".localizedString
//        case .facebook: return "Facebook".localizedString
//        case .twitter: return "Twitter".localizedString
//        case .youtube: return "YouTube".localizedString
//        case .flicker: return "Flicker".localizedString
//        case .google: return "Google".localizedString
//        case .soundCloud: return "Soundcloud".localizedString
        case .privacyPolicy: return "Privacy Policy".localizedString
        case .copyRightPolicy: return "Copyright Policy".localizedString
        case .hyperLinkPolycy: return "Hyperlinking Policy".localizedString
//        case .briefsonForeignRelations: return "Briefs on Foreign Relations".localizedString
        }
    }
    
    var apiValue: String {
        switch self {
        
//        case .FAQ: return Web_View_URL.faqS
        case .TERMSCONDITION: return ""
//        case .facebook: return Web_View_URL.facebook
//        case .twitter: return Web_View_URL.twitter
//        case .youtube: return Web_View_URL.youtube
//        case .flicker: return Web_View_URL.flicker
//        case .google: return Web_View_URL.google
//        case .soundCloud: return Web_View_URL.soundCloud
        case .privacyPolicy: return ""
        case .copyRightPolicy: return ""
        case .hyperLinkPolycy: return ""
//        case .briefsonForeignRelations: return Web_View_URL.briefsonForeignRelations
        
        }
        
    }
}
enum jobType: String {
    case player = "Player"
    case coach
    case doctor
}
