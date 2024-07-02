//
//  FilePathConstant.swift
//  SharkID
//
//  Created by Vikram Jagad on 25/02/19.
//  Copyright © 2019 sttl. All rights reserved.
//

import Foundation

//MARK:- Directory Name
let UserDefinedCardImagesDirPath = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]).appendingPathComponent("UserDefinedCardImages")

let documentSizeLimit: Double = 4
let imageSizeLimit: Double = 2
