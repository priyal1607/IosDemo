//
//  HeaderViewTextFieldDelegate.swift
//  ASI
//
//  Created by Vikram Jagad on 24/07/20.
//  Copyright © 2020 Silvertouch. All rights reserved.
//

import UIKit

@objc protocol HeaderViewTextFieldDelegate : AnyObject {
    func search(text: String)
    func searchShouldChangeCharactersIn(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String)
    func textFieldDidEndEditing(_ textField: UITextField)
    @objc optional func textFieldShouldClear(textField: UITextField) -> Bool
}
