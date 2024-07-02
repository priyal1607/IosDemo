//
//  StringConstant.swift
//  MGNREGA
//
//  Created by Pradip on 15/11/22.
//

import UIKit

typealias SLanguageLocalisation = String.LanguageLocalisation

extension String {
    struct LanguageLocalisation {
        private init() { }
    }
}

extension String.LanguageLocalisation {
    
    //Header
    static var OnlineStatus: String {return "Online Status of Application".localizedString }
    
    //Common
    
    static var follow : String { return "Follow us on".localizedString }
    static var welcometosttl : String { return " Welcome to STTL".localizedString }
    static var profile : String { return "My Profile".localizedString }
    static var Welcomeuser : String { return "Welcome User".localizedString }
    static var select: String { return "Select".localizedString }
    static var cancel: String { return "Cancel".localizedString }
    static var done: String { return "Done".localizedString }
    static var yes: String { return "Yes".localizedString }
    static var no: String { return "No".localizedString }
    static var search : String { return "Search".localizedString }
    static var filter : String { return "Filter".localizedString }
    static var apply: String { return "Apply".localizedString }
    static var location: String { return "Location".localizedString }
    static var next: String { return "Next".localizedString }
    static var upload: String { return "Upload".localizedString }
    static var setting: String { return "Settings".localizedString }
    static var back: String { return "Back".localizedString }
    static var OK: String { return "OK".localizedString }
    static var login: String { return "Login".localizedString }
    static var proceed: String { return "Proceed".localizedString }
    static var showDetail: String { return "Show Detail".localizedString }
    static var gotIt: String { return "Got it!".localizedString }
    static var language: String { return "Language".localizedString }
    static var uploading: String { return "Uploading".localizedString }
    static var fail: String { return "Fail".localizedString }
    static var go_to_settings: String { return "Go to settins".localizedString }
    static var noFileSelectedString : String { return "No file selected".localizedString }
    static var no_record_found : String { return "No Record Found".localizedString }
    static var record_found : String { return "Record Found".localizedString }
    static var character: String { return "Character".localizedString }
    static var total : String { return "Total".localizedString }
    
    static var subject: String { return "Subject".localizedString }
    static var Firstname: String { return "First Name".localizedString }
    static var EmailID: String { return "Email ID".localizedString }
    static var MobileNo: String { return "Mobile No.".localizedString }
    static var Comment: String { return "Comment".localizedString }
    static var Message: String { return "Message".localizedString }
    static var Characters: String { return "Characters".localizedString }
    static var submit: String { return "Submit".localizedString }
    static var reset: String { return "Reset".localizedString }
    static var toDate: String { return "To Date".localizedString }
    static var fromDate: String { return "From Date".localizedString }
    static var selectRegion: String { return "Select Region".localizedString }
    static var keywordSearch: String { return "Keyword Search".localizedString }
    static var select_month: String { return "Select Month".localizedString }
    static var select_year: String { return "Select Year".localizedString }
    
    //MARK: - Headers
    
    static var feedback:String{return "Feedback".localizedString}
    static var playersList:String{return "Players List".localizedString}
    static var dietitian:String{return "Dietitian".localizedString}
    static var camps:String{return "Camps".localizedString}
    static var gallery:String{return "Gallery & Press Release".localizedString}
    static var seeAllGallery:String{return "Gallery".localizedString}
    static var schemes:String{return "Schemes".localizedString}

    static var message_token_expired: String {return "Token is expired Please login again"}
    static var link_is_not_available: String { return "URL Link is not available" }
    static var pull_to_refresh: String { return "Pull to Refresh".localizedString }
    static var internet_Issue: String { return "Internet Issue".localizedString }
    static var connection_error: String { return "Connection Error".localizedString }
    static var msg_the_request_timed_out: String { return "The request timed out".localizedString }
    static var this_Device_Has_No_Camera: String { return "This device has no camera".localizedString }
    static var something_went_wrong_try_some_time: String { return "Something went wrong. Please try after some time.".localizedString }
    static var connection_timed_out: String { return "Connection time out. Please check your internet connection and try again.".localizedString }
    static var are_you_sure_you_want_to_logout_successful: String { return "Are you sure you want to Logout?".localizedString }
    static var location_enable_location_services_description: String { return "Please enable Location services to allow application to find your current location".localizedString }
    static var location_give_permission_description: String { return "Please allow location access for better application experience.".localizedString }
//    static var pleaseEnterUserId: String { return "Please Enter User Id".localizedString }
//    static var pleaseEnterPassword: String { return "Please Enter Password".localizedString }
    static var usernameOrPasswordShouldBeWrong: String { return "Username or password should be wrong".localizedString }
    static var mandatoryFieldsCanNotBeLeftBlank: String { return "Mandatory fields can not be left blank".localizedString }
    static var video_size_must_be_up_to_4_MB : String { "Video size must be up to 4 MB.".localizedString }
    static var camera_unavailable : String { return "Camera Unavailable".localizedString }
    static var no_image_selected:String{return "No Image selected".localizedString}
    static var file_name_cannot_be_blank : String { return "File name cannot be blank.".localizedString }
    
    static var msg_Internet_Issue : String { return "We can\'t detect any internet connectivity.\nPlease check your internet connection and try again." }
    static var msg_internet_slow: String { return "Your current internet connection is slow, Please try after some time.".localizedString }

    
    //MARK: - Feedback Messages
    
    
    static var agreeTerms: String { return "Please agree terms and conditions.".localizedString }
    static var selectCategory: String { return "Please select one register category.".localizedString }
    static var selectSportCategory: String { return "Please select one sport category.".localizedString }
    static var enterPlayerName: String { return "Please enter player name".localizedString }
    static var enterPassword: String { return "Please enter password".localizedString }
    static var enterConfirmPassword: String { return "Please enter confirm password".localizedString }
    static var samePassword: String { return "Password and Confirm Password should be same".localizedString}
    static var enterAadhar: String { return "Please enter aadhar number".localizedString }
    static var enterValidPassword: String { return "Please enter valid password".localizedString }
    static var enterValidAadhar: String { return "Please enter valid aadhar number".localizedString }
    static var enterFirstname: String { return "Please enter first name.".localizedString }
    static var msg_please_enter_email : String { "Please enter email id.".localizedString }
    static var msg_please_enter_pass : String { "Please enter password.".localizedString }
    static var msg_please_enter_valid_email : String { return "Please enter valid email id.".localizedString }
    static var enterMobileNo: String { return "Please enter mobile number.".localizedString }
    static var enterValidMobileNo: String { return "Please enter valid mobile number.".localizedString }
    static var select_location: String { return "Select Location".localizedString }
    static var msg_please_enter_subject: String { return "Please enter subject.".localizedString }
    static var enterMessage : String { return "Please enter message.".localizedString }
    static var msg_Select_type : String { return "Please select type.".localizedString }
    static var msg_Select_year : String { return "Please select year.".localizedString }
    static var msg_Select_month : String { return "Please select month.".localizedString }
    
}
