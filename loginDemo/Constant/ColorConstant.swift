//
//  ColorConstant.swift
//  SharkID
//
//  Created by Vikram Jagad on 25/02/19.
//  Copyright © 2019 sttl. All rights reserved.
//

import UIKit

//MARK: - DarkMode Colors Constant
extension UIColor {
    
    @objc class var customBlack: UIColor {
        if #available(iOS 13, *) {
            return .label
        } else {
            return .black
        }
    }
    
    @objc class var customWhite: UIColor {
        if #available(iOS 13, *) {
            return .systemBackground
        } else {
            return .white
        }
    }
    
    @objc class var customTertiary: UIColor {
        if #available(iOS 13, *) {
            return .tertiarySystemBackground
        } else {
            return .white
        }
    }
    
    @objc class var customShadow: UIColor {
        if #available(iOS 13, *) {
            return .secondaryLabel
        } else {
            return .lightGray
        }
    }
    
    @objc class var customRed: UIColor {
        return .systemRed
    }
    
    @objc class var customGreen: UIColor {
        return .systemGreen
    }
    
    @objc class var customLightBlack: UIColor {
        return UIColor.black.withAlphaComponent(0.3)
    }
    
    @objc class var customRed2: UIColor {
        return UIColor.init(hexStringToUIColor: "F23E3F")
    }
    @objc class var custom_top: UIColor {
        return UIColor.init(hexStringToUIColor: "AA1348")
    }
    @objc class var custom_bottom: UIColor {
        return UIColor.init(hexStringToUIColor: "62125F")
    }
    
    @objc class var customSeparator: UIColor {
        if #available(iOS 13, *) {
            return .systemGray2
        } else {
            return UIColor(hexStringToUIColor: "#D6D5D5")
        }
    }
    
    
    @objc class var customOrange: UIColor {
        return UIColor(named: "customOrange") ?? UIColor(hexStringToUIColor: "FF6131")
    }
    
    @objc class var customTitleGray: UIColor {
        return UIColor(named: "customTitleGray") ?? .white
    }
    
    //------------------------------------------------------------------------------------------
   
    @objc class var darkMode_bottomBarWhiteBackground: UIColor {
        return UIColor(named: "bottomBarWhiteBackground") ?? .white
    }
    
    @objc class var darkMode_cellWhiteBackground: UIColor {
        return UIColor(named: "cellWhiteBackground") ?? .white
    }
    
    @objc class var darkMode_whiteLavenderPinocchioBackground: UIColor {
        return UIColor(named: "whiteLavenderPinocchioBackground") ?? .init(hexStringToUIColor: "#E1E1E6")
    }
    
    
    @objc class var darkMode_whiteBackground: UIColor {
        if #available(iOS 13, *) {
            return .systemBackground
        } else {
            return .white
        }
    }
    
    @objc class var darkMode_BlackBackground: UIColor {
        if #available(iOS 13, *) {
            return .label
        } else {
            return .black
        }
    }
    
    @objc class var bottomBarSelectedTintColor: UIColor {
        return UIColor(named: "bottomBarSelectedTintColor") ?? UIColor(hexStringToUIColor: "#E96420")
    }
    
    @objc class var bottomBarUnSelectedTintColor: UIColor {
        return UIColor(named: "bottomBarUnselectedTintColor") ?? UIColor(hexStringToUIColor: "#666666")
    }
    
    @objc class var DashGradientOne: UIColor {
        return UIColor(named: "DashGradientOne") ?? UIColor(hexStringToUIColor: "#b9f0f8")
    }
    
    @objc class var DashGradientTwo: UIColor {
        return UIColor(named: "DashGradientTwo") ?? UIColor(hexStringToUIColor: "#e8f4fc")
    }
    
    @objc class var DashGradientThree: UIColor {
        return UIColor(named: "DashGradientThree") ?? UIColor(hexStringToUIColor: "#d2e8f9")
    }
    
    @objc class var CTU_Dark_Blue: UIColor {
        return UIColor(named: "sideDarkBlue") ?? UIColor(hexStringToUIColor: "#06329B")
    }
    
    @objc class var CTU_Dark_Grey: UIColor {
        return UIColor(named: "dark_grey") ?? UIColor(hexStringToUIColor: "#757575")
    }

    @objc class var darkMode_headerViewImageTintColor: UIColor {
        return UIColor(named: "headerViewImageTintColor") ?? UIColor(hexStringToUIColor: "#1A1A1A")
    }
    
    @objc class var darkMode_placeHolderColor: UIColor {
        return UIColor(hexStringToUIColor: "#C1C1C1")
    }
    
///    customSubtitle
    @objc class var darkMode_pullToRefreshColor: UIColor {
        return UIColor.gray
    }
    
    @objc class var darkMode_nobelBorderColor: UIColor {
        return UIColor(named: "nobelBorderColor") ?? UIColor(hexStringToUIColor: "#B4B4B4")
    }
    
    @objc class var darkMode_capeCodBorderColor: UIColor {
        return UIColor(named: "capeCodBorderColor") ?? UIColor(hexStringToUIColor: "#3A4B48")
    }
    
    @objc class var darkMode_silverChaliceBorderColor: UIColor {
        return UIColor(hexStringToUIColor: "#ACACAC")
    }
    
    @objc class var darkMode_dateAndImageTintColor: UIColor {
        return UIColor(named: "dateAndImageTintColor") ?? UIColor(hexStringToUIColor: "#7B7B7B")
    }
    
    @objc class var darkMode_labelMineShaftBlackColor: UIColor {
        return UIColor(named: "labelMineShaftBlackColor") ?? UIColor(hexStringToUIColor: "#3C3C3C")
    }
    
    @objc class var darkMode_labelSharkBlackColor: UIColor {
        return UIColor(named: "labelMineShaftBlackColor") ?? UIColor(hexStringToUIColor: "#222222")
    }
    
    @objc class var darkMode_labelCeruleanBlueColor: UIColor {
        return UIColor(named: "labelCeruleanBlueColor") ?? UIColor(hexStringToUIColor: "#3449C0")
    }
    
    @objc class var darkMode_labelHighlightedWhiteTextColor: UIColor {
        return UIColor(named: "labelHighlightedWhiteTextColor") ?? .white
    }
    
    @objc class var darkMode_labelHighlightedBackGroundColor: UIColor {
        return UIColor(named: "labelHighlightedBackGroundColor") ?? UIColor(hexStringToUIColor: "#3C3C3C")
    }
    
    @objc class var darkMode_halfCircleImageTintColor: UIColor {
        return UIColor(named: "halfCircleImageTintColor") ?? UIColor.gray.withAlphaComponent(0.5)
    }
    
    @objc class var darkMode_sepratorColor: UIColor {
        return UIColor(hexStringToUIColor: "#9C9C9C")
    }
    
    
    
    
    class func darkModeReturnVariable(_ lightMode: UIColor, _ darkMode: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.init { traitCollection in
                if traitCollection.userInterfaceStyle == .dark {
                    return darkMode
                }
                return lightMode
            }
        }
        return lightMode
    }
    
    @objc class var darkMode_color_LightBlue: UIColor {
        return UIColor(named: "color_LightBlue") ?? UIColor(hexStringToUIColor: "#AAE3FA")
    }
    
    @objc class var darkMode_color_LightMintGreen: UIColor {
        return UIColor(named: "color_LightMintGreen") ?? UIColor(hexStringToUIColor: "#B5F4BB")
    }
    
    @objc class var darkMode_color_PowderPink: UIColor {
        return UIColor(named: "color_PowderPink") ?? UIColor(hexStringToUIColor: "#F6B5DA")
    }
    
    @objc class var darkMode_color_LightLilac: UIColor {
        return UIColor(named: "color_LightLilac") ?? UIColor(hexStringToUIColor: "#EAC6FE")
    }
    
    @objc class var darkMode_color_MagicMint: UIColor {
        return UIColor(named: "color_MagicMint") ?? UIColor(hexStringToUIColor: "#9EF3E4")
    }
    
    @objc class var darkMode_color_LightLavender: UIColor {
        return UIColor(named: "color_LightLavender") ?? UIColor(hexStringToUIColor: "#DEC1FF")
    }
    
    @objc class var darkMode_color_meaNotesBg: UIColor {
        return UIColor(named: "color_meaNotesBg") ?? UIColor(hexStringToUIColor: "#A8E2F9")
    }
    
    @objc class var darkMode_color_meaCustomDashboardBg: UIColor {
        return UIColor(named: "color_meaCustomDashboardBg") ?? UIColor(hexStringToUIColor: "#9CF2E3")
    }
    
}

