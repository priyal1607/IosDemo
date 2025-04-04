//
//  TagCellLayoutDelegate.swift
//  TagCellLayout
//
//  Created by Ritesh Gupta on 06/01/18.
//  Copyright © 2018 Ritesh. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol TagCellLayoutDelegate: NSObjectProtocol
{
    @objc func tagCellLayoutTagSize(layout: TagCellLayout, atIndex index:Int) -> CGSize
}
