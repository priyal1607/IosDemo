//
//  NSAttributeString.swift

//
//  Created by Savan Ankola on 07/06/21.
//

import UIKit
import SwiftUI

extension NSAttributedString {
    func changeFontSizeColorFont(factor: CGFloat,fontColor:CGColor = UIColor.black.cgColor,font: UIFont) -> NSAttributedString {
        
        guard let output = self.mutableCopy() as? NSMutableAttributedString else {
            return self
        }

        output.beginEditing()
        output.enumerateAttribute(NSAttributedString.Key.font,
                                  in: NSRange(location: 0, length: self.length),
                                  options: []) { (value, range, stop) -> Void in
            guard let oldFont = value as? UIFont else {
                return
            }
             
            guard let newfont = UIFont(name: oldFont.fontName, size: oldFont.pointSize * factor) else {
                return
            }
                        
//            if oldFont.fontName == "TimesNewRomanPSMT" {
                output.removeAttribute(NSAttributedString.Key.font, range: range)
                output.addAttribute(NSAttributedString.Key.font, value: newfont, range: range)
            
            output.removeAttribute(NSAttributedString.Key.foregroundColor, range: range)
            output.addAttribute(NSAttributedString.Key.foregroundColor, value: fontColor, range: range)
            
            output.addAttribute(NSAttributedString.Key.font, value: font, range: range)
//                print("Font Chnaged")
                
//            } else {
//                print("Without Font Chnaged")
//            }
        }
        output.endEditing()

        return output
    }
    
}
