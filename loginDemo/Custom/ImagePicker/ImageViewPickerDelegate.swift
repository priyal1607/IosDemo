//
//  RFPListDetailEditImageViewPickerDelegate.swift
//  PSIS
//
//  Created by Vikram Jagad on 22/05/19.
//  Copyright © 2019 Vikram Jagad. All rights reserved.
//

import UIKit

@objc protocol ImageViewPickerDelegate : AnyObject {
    func imageData(img: UIImage?, compressedLogoImg: UIImage?, imgType: String, errorMsg: String, sender: UIView)
    @objc optional func imageData(url: URL?, errorMsg: String, sender: UIView)
}
