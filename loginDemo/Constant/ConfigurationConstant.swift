//
//  ConfigurationConstant.swift
//  SharkID
//
//  Created by Vikram Jagad on 25/02/19.
//  Copyright © 2019 sttl. All rights reserved.
//



import UIKit
import MobileCoreServices


//MARK:- Devices Type
let DeviceID = UIDevice.current.identifierForVendor!.uuidString
let IS_IPAD = (UIDevice.current.userInterfaceIdiom == .pad)
let IS_IPHONE = (UIDevice.current.userInterfaceIdiom == .phone)
let osVersion = UIDevice.current.systemVersion

//MARK:- Get Devices Width and Height
var SCREEN_WIDTH: CGFloat { return UIScreen.main.bounds.size.width }
var SCREEN_HEIGHT: CGFloat { return UIScreen.main.bounds.size.height }
var SCREEN_MAX_LENGTH: CGFloat { return max(SCREEN_WIDTH, SCREEN_HEIGHT) }
var SCREEN_MIN_LENGTH: CGFloat { return min(SCREEN_WIDTH, SCREEN_HEIGHT) }
let IS_IPHONE_4_OR_LESS = (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
let IS_IPHONE_5 = (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
let IS_IPHONE_6 = (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
let IS_IPHONE_6P = (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
let IS_IPHONE_X = (IS_IPHONE && SCREEN_HEIGHT >= 812.0)

public typealias JSONObject = [String : Any]

var IS_IPHONE_PRO_MAX: Bool { return IS_IPHONE && SCREEN_HEIGHT >= 926 }
var IS_IPHONE_SE_DOWN_MODEL: Bool { return UIDevice.deviceModelType.contains(.iPhone_4, .iPhone_5, .iPhone_5c, .iPhone_5s, .iPhone_SE, .iPhone_SE_2nd_generation, .iPhone_SE_3rd_generation) }

var bottomMarginFromSafeArea: CGFloat {
    return UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
}

var topMarginFromSafeArea: CGFloat {
    return UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0
}

var isDarkModeAppearance: Bool {
    if #available(iOS 13.0, *) {
        return UITraitCollection.current.userInterfaceStyle == .dark
    } else {
        return false
    }
}

var applicationName: String { return Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? "" }

let IS_IPHONE_WITH_NOTCH = (IS_IPHONE && STATUS_BAR_HEIGHT > 20)
let IPAD_MARGIN: CGFloat = 70

var STATUS_BAR_HEIGHT : CGFloat {
    if #available(iOS 13.0, *) {
        return UIApplication.shared.delegate?.window??.windowScene?.statusBarManager?.statusBarFrame.height ?? UIApplication.shared.statusBarFrame.height
    } else {
        return UIApplication.shared.statusBarFrame.height
    }
}


//MARK:- DeviceID
//let DeviceID = UIDevice.current.identifierForVendor!.uuidString //"75a30533aaaa87b"

//MARK:- NotificationCenter
let K_NC = NotificationCenter.default

//MARK:- AppDelegates instances
var appDelegate : AppDelegate? { return UIApplication.shared.delegate as? AppDelegate }

//MARK:- DeviceID
private var d_ID: String!
//var DeviceID: String {
//    if d_ID == nil {
//        d_ID = Global.uniQueID()
//    }
//    return d_ID
//}

//MARK:- TableView

let ALPHABETS = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
let NUMERIC = "1234567890"
let ALLOWED_SPECIAL_CHARACTER = "&@._-'/"
let ALPHABETS_NUMERIC_SPACE = "\(ALPHABETS)\(NUMERIC) "
let ALPHABETS_SPACE = "\(ALPHABETS) "
let MOBILE_LENGTH_VALIDATION = 10
let OTP_LENGTH = 6
let CIN_NO_LENGTH = 21
let PAN_CARD_LENGTH = 10
let GST_NO_LENGTH = 25
let Address_Length = 300

var ONLY_PDF_Types: [String] { return [kUTTypePDF as String] }
var AllDoc_Types: [String] { return ["public.content"] }
let arrdocTypesForProfile : [String] = ["public.image", kUTTypePDF as String]

let arrColorGradient:[CGColor] = [UIColor(hexStringToUIColor: "#FA662E").cgColor,UIColor(hexStringToUIColor: "#FC8331").cgColor,UIColor(hexStringToUIColor: "#FF9853").cgColor]

var PHASSET_GIF_IMAGE_TYPE: String { return kUTTypeGIF as String }

func common_htmlStringWithDiv(font_size:Int = 36, htmlString: String) -> String {
    """
    <!doctype html>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <html>
        <head>
            <style>
                body {
                    font-size: \(font_size)px;
                    display:flex;
                }
            </style>
        </head>
        <body>
            <div>
                \(htmlString)
            </div>
        </body>
    </html>
    """

}
