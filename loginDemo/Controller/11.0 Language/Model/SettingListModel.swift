//
//  SettingListModel.swift
//  LSAttendance
//
//  Created by Vikram Jagad on 30/06/20.
//  Copyright © 2020 Hitesh. All rights reserved.
//

import UIKit

class SettingListModel : NSObject {
    
    var id: String = ""
    var title: String = ""
    var type: String = ""
    var img: String = ""

    enum Keys: String {
        case id = "id"
        case title = "title"
        case img = "img"
        case type = "type"
    }
    
    init(dict: [String : Any]) {
        self.id = getString(anything: dict[Keys.id.rawValue])
        self.title = getString(anything: dict[Keys.title.rawValue])
        self.type = getString(anything: dict[Keys.type.rawValue])
        self.img = getString(anything: dict[Keys.img.rawValue])
    }
}

