//
//  UITextfield+CutomizedTextfield.swift
//  SharkID
//
//  Created by Jinal Patel on 5/31/17.
//  Copyright © 2017 sttl. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift

//MARK:- For PlaceHolderColor
extension UITextField
{
    func setPaddingForTextField()
    {
        let paddingView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 10, height: 30))
        self.leftView = paddingView;
        self.leftViewMode = UITextField.ViewMode.always
    }
    
    func setAttributtedPlaceHolder(text: String, ofColor: UIColor, font: UIFont? = nil)
    {
        if let getFont = font {
            self.attributedPlaceholder = NSAttributedString(string: text, attributes: [.foregroundColor : ofColor, .font : getFont])
        } else if let getFont = self.font {
            self.attributedPlaceholder = NSAttributedString(string: text, attributes: [.foregroundColor : ofColor, .font : getFont])
        } else {
            self.attributedPlaceholder = NSAttributedString(string: text, attributes: [.foregroundColor : ofColor])
        }
    }
    
    func setPlaceholder(_ placeholderString : String , color: UIColor, setFont: UIFont?) {
        let aSetFont = setFont ?? self.font
        let attributeString : [NSAttributedString.Key : Any]
        
        if let getFont = aSetFont {
            attributeString = [.foregroundColor: color,
                               .font: getFont]
        } else {
            attributeString = [.foregroundColor: color]
        }
        
        self.attributedPlaceholder = NSAttributedString(string: placeholderString, attributes: attributeString)
    }
    
    var clearButton: UIButton? {
        return value(forKey: "clearButton") as? UIButton
    }
    
    var clearButtonTintColor: UIColor? {
        get {
            return clearButton?.tintColor
        }
        set {
            let image =  clearButton?.imageView?.image?.withRenderingMode(.alwaysTemplate)
            clearButton?.setImage(image, for: .normal)
            clearButton?.tintColor = newValue
        }
    }
}

class SearchTextField: UITextField {

    override var hasText: Bool {
        return (self.text ?? "").trimming_WS_NL.count > 2
    }

}

class PlaceHolderTextView: IQTextView {

    func setPlaceholder(placeholder: String?, color: UIColor? = nil) {
        
        self.placeholder = placeholder
        
        if color != nil {
            self.placeholderTextColor = color
        }
    }
    
    func setAttributedPlaceholder(attStr: NSAttributedString?) {
        self.attributedPlaceholder = attStr
    }
    
    
}
