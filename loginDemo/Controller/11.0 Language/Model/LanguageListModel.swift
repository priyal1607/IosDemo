//
//  languageListModel.swift
//  NWM
//
//  Created by Vikram Jagad on 07/05/21.
//

import UIKit

class LanguageListModel: NSObject {
    var id: String
    var title: String
    var culture: String
    
    enum Keys: String {
        case id = "language_id"
        case title = "language_title"
        case culture = "language_culture"
    }
    
    init(dict: [String : Any]) {
        self.id = getString(anything: dict[Keys.id.rawValue])
        self.title = getString(anything: dict[Keys.title.rawValue])
        self.culture = getString(anything: dict[Keys.culture.rawValue])
    }
}
