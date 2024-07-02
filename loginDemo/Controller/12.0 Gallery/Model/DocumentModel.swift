//
//  DocumentModel.swift
//  Vidyanjali
//
//  Created by Vikram Jagad on 09/11/20.
//  Copyright © 2020 Vikram Jagad. All rights reserved.
//

import UIKit

class DocumentModel: NSObject {
    var url: URL? = nil
    var title = ""
    var document: Any? = nil
    var type = ""
    var key = ""
    var mimeType = "image/*"
    var date : Date = Date()
    var isEditModeOpen = false
    var fileLastPathName = ""
    
    override init() {
        super.init()
    }
}
