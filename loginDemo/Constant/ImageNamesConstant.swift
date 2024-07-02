//
//  ImageNamesConstant.swift
//  SharkID
//
//  Created by Vikram Jagad on 25/02/19.
//  Copyright © 2019 sttl. All rights reserved.
//

import UIKit


//MARK:- Common
let k_ic_pull_to_refresh = "ic_pull_to_refresh"

extension UIImage {
    
    var alwaysTemplate: UIImage {
        return self.withRenderingMode(.alwaysTemplate)
    }
    
    var alwaysOriginal: UIImage {
        return self.withRenderingMode(.alwaysOriginal)
    }
    
    var automatic: UIImage {
        return self.withRenderingMode(.automatic)
    }
    
    
    class var ic_header_menu: UIImage? {
        return UIImage(named: "sidemenu")?.withRenderingMode(.alwaysTemplate)
    }
    
    class var ic_header_back: UIImage? {

        return UIImage(named: "arr")
    }
    
    class var ic_header_notification: UIImage? {
        return UIImage(named: "ic_header_notification")?.withRenderingMode(.alwaysTemplate)
    }
    
    class var ic_header_search: UIImage? {
        return UIImage(named: "ic_header_search")?.withRenderingMode(.alwaysTemplate)
    }
    @objc class var ic_system_play_fill : UIImage? {
        if #available(iOS 13.0, *) {
            return UIImage(systemName: "play.circle.fill")
        } else {
            // Fallback on earlier versions
            return UIImage()
        }
    }
    
    @objc class var ic_system_pause_fill : UIImage? {
        if #available(iOS 13.0, *) {
            return UIImage(systemName: "pause.circle.fill")
        } else {
            // Fallback on earlier versions
            return UIImage()
        }
    }
    
    class var ic_header_filter: UIImage? {
        return UIImage(named: "ic_header_filter")?.withRenderingMode(.alwaysTemplate)
    }
    class var ic_loc: UIImage? {
        return UIImage(named: "location")?.withRenderingMode(.alwaysTemplate)
    }
    
    class var ic_header_close: UIImage? {
        return UIImage(named: "ic_header_close")?.withRenderingMode(.alwaysTemplate)
    }
    
    class var ic_header_down_arrow: UIImage? {
        return UIImage(named: "ic_header_down_arrow")?.withRenderingMode(.alwaysTemplate)
    }
    
    class var ic_header_delete: UIImage? {
        return UIImage(named: "ic_header_delete")?.withRenderingMode(.alwaysTemplate)
    }
    
    class var ic_dashboard_youtube: UIImage? {
        return UIImage(named: "ic_dashboard_youtube")
    }
    @objc class var placeholder : UIImage {
        return UIImage(named: "ic_image_placeholder_banner") ?? UIImage()
    }
    class var ic_minus: UIImage? {
        return UIImage(named: "ic_minus")?.withRenderingMode(.alwaysTemplate)
    }
    
    class var ic_plus: UIImage? {
        return UIImage(named: "ic_plus")?.withRenderingMode(.alwaysTemplate)
    }
    
    class var ic_edit: UIImage? {
        return UIImage(named: "ic_edit")?.withRenderingMode(.alwaysTemplate)
    }
    
    class var ic_note_edit: UIImage? {
        return UIImage(named: "ic_note_edit")?.withRenderingMode(.alwaysTemplate)
    }
    
    class var ic_note_delete: UIImage? {
        return UIImage(named: "ic_note_delete")?.withRenderingMode(.alwaysTemplate)
    }
    
    class var ic_user_placeholder: UIImage? {
        return UIImage(named: "ic_user_placeholder")
    }
    
    class var ic_user_placeholder2: UIImage? {
        return UIImage(named: "ic_user_placeholder2")
    }
    
    class var ic_reg_check_selected: UIImage? {
        return UIImage(named: "ic_reg_check_selected")
    }
    
    class var ic_checkmark: UIImage? {
        return UIImage(named: "checkmark")
    }
    
    class var ic_unCheckmark: UIImage? {
        return UIImage(named: "unCheckmark")
    }
    class var ic_checkmark1: UIImage? {
        return UIImage(named: "sel_1")
    }
    
    class var ic_unCheckmark1: UIImage? {
        return UIImage(named: "radio_UnSelected")
    }
    
    class var ic_header_info: UIImage? {
        return UIImage(named: "ic_header_info")?.withRenderingMode(.alwaysTemplate)
    }
    
    class var ic_header_route : UIImage? {
        return UIImage(named: "ic_header_route")?.withRenderingMode(.alwaysTemplate)
    }
    
    class var ic_header_steps : UIImage? {
        return UIImage(named: "ic_header_steps")?.withRenderingMode(.alwaysTemplate)
    }
    class var ico_faq : UIImage? {
        return UIImage(named: "ico_faq")?.withRenderingMode(.alwaysTemplate)
    }
    
    class var ic_header_download: UIImage? {
        return UIImage(named: "ic_download")?.withRenderingMode(.alwaysTemplate)
    }
    
    class var ic_viewpdf: UIImage {
        return UIImage(named: "ic_viewpdf")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
    }
    
    class var ic_dots: UIImage {
        return UIImage(named: "ic_dots")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
    }
    
    class var ic_down_arrow: UIImage? {
        return UIImage(named: "ic_down_arrow")?.withRenderingMode(.alwaysTemplate)
    }
    
    @objc class var ico_language_globe: UIImage? {
        return UIImage(named: "ico_language_globe")?.withRenderingMode(.alwaysTemplate)
    }
    
    class var ic_pull_to_refresh: UIImage {
        return UIImage(named: "ic_pull_to_refresh") ?? UIImage()
    }
    
    class var ic_attach: UIImage {
        return UIImage(named: "ic_attach") ?? UIImage()
    }
    
    class var ic_rightArrow: UIImage {
        return UIImage(named: "arrow_left_icon")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
    }
    class var ic_leftArrow: UIImage {
        return UIImage(named: "arrow_right_icon")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
    }
    
    class var postcomment: UIImage {
        return UIImage(named: "postcomment")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
    }
    
    class var ic_calendar: UIImage {
        return UIImage(named: "calender")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
    }
    
    class var ico_share: UIImage {
        return UIImage(named: "location")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
    }
    
    class var ic_close: UIImage {
        return UIImage(named: "ic_close")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
    }
    
    class var ico_bookmark: UIImage {
        return UIImage(named: "ico_bookmark") ?? UIImage()
    }
    
    class var ico_bookmark_filled: UIImage {
        return UIImage(named: "ico_bookmark_filled")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
    }
    
    class var top_semi_circle: UIImage {
        return UIImage(named: "top_semi_circle")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
    }
    
    class var icon_material_dashboard: UIImage {
        return UIImage(named: "icon_material_dashboard") ?? UIImage()
    }
    
    class var filter: UIImage {
        return UIImage(named: "filter")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
    }
    
    class var ic_emergency_call: UIImage {
        return UIImage(named: "ic_emergency-call")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
    }
    
    class var ic_email: UIImage {
        return UIImage(named: "ic_email") ?? UIImage()
    }
    
    class var ic_fax_icon: UIImage {
        return UIImage(named: "ic_fax_icon") ?? UIImage()
    }
    
    class var ic_telephone_icon: UIImage {
        return UIImage(named: "ic_telephone_icon") ?? UIImage()
    }
    
    class var ic_clouds:UIImage {
        return UIImage(named: "ic_clouds") ?? UIImage()
    }
    
    class var ic_fb:UIImage {
        return UIImage(named: "ic_fb") ?? UIImage()
    }
    
    class var ic_googleplus:UIImage {
        return UIImage(named: "ic_googleplus") ?? UIImage()
    }
    
    class var ic_insta:UIImage {
        return UIImage(named: "ic_insta") ?? UIImage()
    }
    
    class var ic_linked:UIImage {
        return UIImage(named: "ic_linked") ?? UIImage()
    }
    
    class var ic_tw:UIImage {
        return UIImage(named: "ic_tw") ?? UIImage()
    }
    
    class var ic_woo:UIImage {
        return UIImage(named: "ic_woo") ?? UIImage()
    }
    
    class var ic_youtube:UIImage {
        return UIImage(named: "ic_youtube") ?? UIImage()
    }
    
    class var Icon_feather_file_text:UIImage {
        return UIImage(named: "Icon_feather-file-text") ?? UIImage()
    }
    
    class var location:UIImage {
        return UIImage(named: "location")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
    }
    
    class var ic_gray_quicklink:UIImage {
        return UIImage(named: "ic_gray_quicklink") ?? UIImage()
    }
    
    class var ic_gray_right_arrow:UIImage {
        return UIImage(named: "ic_gray_right_arrow") ?? UIImage()
    }
    
    class var ic_website:UIImage {
        return UIImage(named: "ic_website") ?? UIImage()
    }
    
    class var ic_Location:UIImage {
        return UIImage(named: "ic_Location") ?? UIImage()
    }
    
    class var Nearest_mission:UIImage {
        return UIImage(named: "nearestMission")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
    }
    
    class var New_mission:UIImage {
        return UIImage(named: "newMission")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
    }
    
    class var ic_lecture_placeholder:UIImage {
        return UIImage(named: "ic_lecture_placeholder") ?? UIImage()
    }

    class var ic_CurrentNewlocation:UIImage {
        return UIImage(named: "CurrentNewlocation")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
    }
    
    class var ic_Logout:UIImage {
        return UIImage(named: "logout")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
    }

    class var ic_brief_foreign: UIImage {
        return UIImage(named: "ic_brief_foreign") ?? UIImage()
    }
    
    class var ic_pdf: UIImage {
        return UIImage(named: "ic_pdf")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
    }
    
    class var ic_plus_fill: UIImage {
        return UIImage(named: "plus_fill") ?? UIImage()
    }
    
    class var image_placeholder: UIImage {
        return UIImage(named: "image_placeholder") ?? UIImage()
    }
    
    class var image_placeholder2: UIImage {
        return UIImage(named: "image_placeholder2") ?? UIImage()
    }
    
    class var ic_radio_selected: UIImage? {
            return UIImage(named: "radio_selected")?.withRenderingMode(.alwaysOriginal)
        }
        
    class var ic_radio_unselected: UIImage? {
        return UIImage(named: "radio_UnSelected")?.withRenderingMode(.alwaysTemplate)
    }
    
    
    class var ico_plus : UIImage? {
        return UIImage(named: "ico_plus")
    }
    
    class var play: UIImage? {
        return UIImage(named: "play")?.withRenderingMode(.alwaysTemplate)
    }
    
}

struct ImageNameConstants {
    static var ic_camera : String { return "ic_camera" }
    static var ic_photo_library : String { return "ic_photo_library" }
    static var ic_document : String { return "ic_document" }
}


let k_ic_attach = "ic_attach"
let k_ic_viewpdf = "ic_viewpdf"
