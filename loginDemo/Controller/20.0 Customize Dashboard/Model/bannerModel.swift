//
//  bannerModel.swift
//  loginDemo
//
//  Created by Priyal on 26/09/23.
//

import Foundation
class ListModel : NSObject {
    let newsImagePath : String?
    let newsId : Int?
    let newsURL : String?
    let newsDate : String?
    let newsHeadline : String?

    enum Keys: String {

        case newsImagePath = "NewsImagePath"
        case newsId = "NewsId"
        case newsURL = "NewsURL"
        case newsDate = "newsDate"
        case newsHeadline = "NewsHeadline"
    }

    init(dict : DICTIONARY)  {
        newsImagePath = getString(anything: dict[Keys.newsImagePath.rawValue])
        newsId = getInteger(anything: dict[Keys.newsId.rawValue])
        newsURL = getString(anything: dict[Keys.newsURL.rawValue])
        newsDate = getString(anything: dict[Keys.newsDate.rawValue])
        newsHeadline = getString(anything: dict[Keys.newsHeadline.rawValue])
    }

}
class dashboardList : NSObject {
    var _id : String?
    var color : String?
    var img : String?
    var lbl : String?
    var isSelected : Bool!

    enum Keys: String  {

        case _id = "_id"
        case color = "color"
        case img = "img"
        case lbl = "lbl"
        case isSelected = "isSelected"
    }

    init(dict : DICTIONARY) {
        _id = getString(anything: dict[Keys._id.rawValue])
        color = getString(anything: dict[Keys.color.rawValue])
        img = getString(anything: dict[Keys.img.rawValue])
        lbl = getString(anything: dict[Keys.lbl.rawValue])
       // isSelected = getBoolean(anything: dict[Keys.isSelected.rawValue])
        isSelected = dict["isSelected"] as? Bool
    }

}
