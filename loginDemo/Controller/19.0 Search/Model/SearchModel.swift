//
//  SearchModel.swift
//  loginDemo
//
//  Created by Priyal on 22/09/23.
//

import Foundation
class SearchModel : NSObject{
    let title : String?

    enum Keys: String {

        case title = "title"
    }

    init(dict: DICTIONARY) {
        title = getString(anything: dict[Keys.title.rawValue])
    }

}
