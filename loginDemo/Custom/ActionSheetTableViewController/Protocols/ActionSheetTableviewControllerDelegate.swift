//
//  AlertActionTableviewControllerDelegate.swift
//  SharkID
//
//  Created by Vikram Jagad on 05/03/19.
//  Copyright © 2019 sttl. All rights reserved.
//

import Foundation

@objc protocol ActionSheetTableviewControllerDelegate
{
    @objc optional func openActionAlert(index: Int)
}
