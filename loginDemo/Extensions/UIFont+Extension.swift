//
//  DGGlobal.swift
//  DigitalGujarat
//
//  Created by Xamarin PC on 15/09/16.
//  Copyright © 2016 Digital Gujarat. All rights reserved.
//

import UIKit
import CoreText

extension UIFont {
    
    class func changeFontSize(_ withSize: CGFloat) -> CGFloat {
        if IS_IPAD {
            return withSize + 8
            
        } else if UIDevice.deviceModelType.contains(.iPhone_4, .iPhone_4s, .iPhone_5c, .iPhone_5s, .iPhone_5, .iPhone_SE) {
            //width 320
            return withSize
            
        } else if UIDevice.deviceModelType.contains(.iPhone_6, .iPhone_6s, .iPhone_SE_2nd_generation, .iPhone_SE_3rd_generation, .iPhone_7, .iPhone_8, .iPhone_X, .iPhone_XS, .iPhone_11_Pro, .iPhone_12_mini, .iPhone_13_mini) {
            //width 375
            return withSize + 1
            
        } else if UIDevice.deviceModelType.contains(.iPhone_12, .iPhone_12_Pro, .iPhone_13, .iPhone_13_Pro) {
            //width 390
            return withSize + 2
            
        } else if UIDevice.deviceModelType.contains(.iPhone_6s_Plus, .iPhone_7_Plus, .iPhone_8_Plus, .iPhone_XS_Max, .iPhone_XR, .iPhone_11, .iPhone_11_Pro_Max) {
            //width 414
            return withSize + 3
            
        } else if UIDevice.deviceModelType.contains(.iPhone_12_Pro_Max, .iPhone_13_Pro_Max) {
            //width 428
            return withSize + 4
            
        } else {
            let width = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
            
            if width <= 320 {
                return withSize
            } else if width <= 375 {
                return withSize + 1
            } else if width <= 390 {
                return withSize + 2
            } else if width <= 414 {
                return withSize + 3
            } else if width <= 428 {
                return withSize + 4
            } else {
                let strCount = "\(Int(width))".count
                let dividedValue = CGFloat(Double("1" + Array(repeating: "0", count: strCount - 1))!)
                
                return withSize + round(width / dividedValue)
            }
        }
    }
    
    enum FontSize {
        case smallest
        case small
        case title
        case value
        case medium
        case large
        case extraLarge
        case other(CGFloat)
        
        var size: CGFloat {
            switch self {
            case .smallest:         return 10
            case .small:            return 12
            case .title:            return 14
            case .value:            return 16
            case .medium:           return 18
            case .large:            return 20
            case .extraLarge:       return 22
            case .other(let sz):     return sz
            }
        }
    }
    
    enum Montserrat_FontType {
        case roman_Regular
        case regular
        case italic_Regular
        case italic
        case thin
        case thinItalic
        case roman_ExtraLight
        case italic_ExtraLight
        case extraLight
        case extraLightItalic
        case roman_Light
        case light
        case italic_Light
        case lightItalic
        case roman_Medium
        case medium
        case italic_Medium
        case mediumItalic
        case roman_SemiBold
        case semiBold
        case italic_SemiBold
        case semiBoldItalic
        case roman_Bold
        case bold
        case italic_Bold
        case boldItalic
        case roman_ExtraBold
        case extraBold
        case italic_ExtraBold
        case extraBoldItalic
        case roman_Black
        case black
        case italic_Black
        case blackItalic
    }
    
    class func montserratFont(_ fontType: Montserrat_FontType, _ fontSize: FontSize) -> UIFont {
        switch fontType {
        case .roman_Regular:
            return UIFont(name: "MontserratRoman-Regular", size: Self.changeFontSize(fontSize.size))!
        case .regular:
            return UIFont(name: "Montserrat-Regular", size: Self.changeFontSize(fontSize.size))!
        case .italic_Regular:
            return UIFont(name: "MontserratItalic-Regular", size: Self.changeFontSize(fontSize.size))!
        case .italic:
            return UIFont(name: "Montserrat-Italic", size: Self.changeFontSize(fontSize.size))!
        case .thin:
            return UIFont(name: "Montserrat-Thin", size: Self.changeFontSize(fontSize.size))!
        case .thinItalic:
            return UIFont(name: "Montserrat-ThinItalic", size: Self.changeFontSize(fontSize.size))!
        case .roman_ExtraLight:
            return UIFont(name: "MontserratRoman-ExtraLight", size: Self.changeFontSize(fontSize.size))!
        case .italic_ExtraLight:
            return UIFont(name: "MontserratItalic-ExtraLight", size: Self.changeFontSize(fontSize.size))!
        case .extraLight:
            return UIFont(name: "Montserrat-ExtraLight", size: Self.changeFontSize(fontSize.size))!
        case .extraLightItalic:
            return UIFont(name: "Montserrat-ExtraLightItalic", size: Self.changeFontSize(fontSize.size))!
        case .roman_Light:
            return UIFont(name: "MontserratRoman-Light", size: Self.changeFontSize(fontSize.size))!
        case .light:
            return UIFont(name: "Montserrat-Light", size: Self.changeFontSize(fontSize.size))!
        case .italic_Light:
            return UIFont(name: "MontserratItalic-Light", size: Self.changeFontSize(fontSize.size))!
        case .lightItalic:
            return UIFont(name: "Montserrat-LightItalic", size: Self.changeFontSize(fontSize.size))!
        case .roman_Medium:
            return UIFont(name: "MontserratRoman-Medium", size: Self.changeFontSize(fontSize.size))!
        case .medium:
            return UIFont(name: "Montserrat-Medium", size: Self.changeFontSize(fontSize.size))!
        case .italic_Medium:
            return UIFont(name: "MontserratItalic-Medium", size: Self.changeFontSize(fontSize.size))!
        case .mediumItalic:
            return UIFont(name: "Montserrat-MediumItalic", size: Self.changeFontSize(fontSize.size))!
        case .roman_SemiBold:
            return UIFont(name: "MontserratRoman-SemiBold", size: Self.changeFontSize(fontSize.size))!
        case .semiBold:
            return UIFont(name: "Montserrat-SemiBold", size: Self.changeFontSize(fontSize.size))!
        case .italic_SemiBold:
            return UIFont(name: "MontserratItalic-SemiBold", size: Self.changeFontSize(fontSize.size))!
        case .semiBoldItalic:
            return UIFont(name: "Montserrat-SemiBoldItalic", size: Self.changeFontSize(fontSize.size))!
        case .roman_Bold:
            return UIFont(name: "MontserratRoman-Bold", size: Self.changeFontSize(fontSize.size))!
        case .bold:
            return UIFont(name: "Montserrat-Bold", size: Self.changeFontSize(fontSize.size))!
        case .italic_Bold:
            return UIFont(name: "MontserratItalic-Bold", size: Self.changeFontSize(fontSize.size))!
        case .boldItalic:
            return UIFont(name: "Montserrat-BoldItalic", size: Self.changeFontSize(fontSize.size))!
        case .roman_ExtraBold:
            return UIFont(name: "MontserratRoman-ExtraBold", size: Self.changeFontSize(fontSize.size))!
        case .extraBold:
            return UIFont(name: "Montserrat-ExtraBold", size: Self.changeFontSize(fontSize.size))!
        case .italic_ExtraBold:
            return UIFont(name: "MontserratItalic-ExtraBold", size: Self.changeFontSize(fontSize.size))!
        case .extraBoldItalic:
            return UIFont(name: "Montserrat-ExtraBoldItalic", size: Self.changeFontSize(fontSize.size))!
        case .roman_Black:
            return UIFont(name: "MontserratRoman-Black", size: Self.changeFontSize(fontSize.size))!
        case .black:
            return UIFont(name: "Montserrat-Black", size: Self.changeFontSize(fontSize.size))!
        case .italic_Black:
            return UIFont(name: "MontserratItalic-Black", size: Self.changeFontSize(fontSize.size))!
        case .blackItalic:
            return UIFont(name: "Montserrat-BlackItalic", size: Self.changeFontSize(fontSize.size))!
        }
    }
    
    enum Poppins_FontType {
        case black
        case blackItalic
        case bold
        case boldItalic
        case extraBold
        case extraBoldItalic
        case extraLight
        case extraLightItalic
        case italic
        case light
        case lightItalic
        case medium
        case mediumItalic
        case regular
        
        case semiBold
        case semiBoldItalic
        case thin
        case thinItalic
    }
    
    class func poppinsFont(_ fontType: Poppins_FontType, _ fontSize: FontSize) -> UIFont {
        switch fontType {
        case .black:
            return UIFont(name: "Poppins-Black", size: Self.changeFontSize(fontSize.size))!
        case .blackItalic:
            return UIFont(name: "Poppins-BlackItalic", size: Self.changeFontSize(fontSize.size))!
        case .bold:
            return UIFont(name: "Poppins-Bold", size: Self.changeFontSize(fontSize.size))!
        case .boldItalic:
            return UIFont(name: "Poppins-BoldItalic", size: Self.changeFontSize(fontSize.size))!
        case .extraBold:
            return UIFont(name: "Poppins-ExtraBold", size: Self.changeFontSize(fontSize.size))!
        case .extraBoldItalic:
            return UIFont(name: "Poppins-ExtraBoldItalic", size: Self.changeFontSize(fontSize.size))!
        case .extraLight:
            return UIFont(name: "Poppins-ExtraLight", size: Self.changeFontSize(fontSize.size))!
        case .extraLightItalic:
            return UIFont(name: "Poppins-ExtraLightItalic", size: Self.changeFontSize(fontSize.size))!
        case .italic:
            return UIFont(name: "Poppins-Italic", size: Self.changeFontSize(fontSize.size))!
        case .light:
            return UIFont(name: "Poppins-Light", size: Self.changeFontSize(fontSize.size))!
        case .lightItalic:
            return UIFont(name: "Poppins-LightItalic", size: Self.changeFontSize(fontSize.size))!
        case .medium:
            return UIFont(name: "Poppins-Medium", size: Self.changeFontSize(fontSize.size))!
        case .mediumItalic:
            return UIFont(name: "Poppins-MediumItalic", size: Self.changeFontSize(fontSize.size))!
        case .regular:
            return UIFont(name: "Poppins-Regular", size: Self.changeFontSize(fontSize.size))!
        case .semiBold:
            return UIFont(name: "Poppins-SemiBold", size: Self.changeFontSize(fontSize.size))!
        case .semiBoldItalic:
            return UIFont(name: "Poppins-SemiBoldItalic", size: Self.changeFontSize(fontSize.size))!
        case .thin:
            return UIFont(name: "Poppins-Thin", size: Self.changeFontSize(fontSize.size))!
        case .thinItalic:
            return UIFont(name: "Poppins-ThinItalic", size: Self.changeFontSize(fontSize.size))!
        }
    }
    
    class func regularSystemFont(withSize: FontSize) -> UIFont {
        return UIFont.systemFont(ofSize: Self.changeFontSize(withSize.size))
    }
    
    class func boldSystemFont(withSize: FontSize) -> UIFont {
        return UIFont.boldSystemFont(ofSize: Self.changeFontSize(withSize.size))
    }
    
    class func semiBoldSystemFont(withSize: FontSize) -> UIFont {
        return UIFont.systemFont(ofSize: Self.changeFontSize(withSize.size), weight: .semibold)
    }
    
    class func italicSystemFont(withSize: FontSize) -> UIFont {
        return UIFont.italicSystemFont(ofSize: Self.changeFontSize(withSize.size))
    }
}
