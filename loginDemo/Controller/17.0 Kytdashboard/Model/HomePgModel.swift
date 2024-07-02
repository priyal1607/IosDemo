//
//  HomepageModel.swift
//  loginDemo
//
//  Created by Priyal on 11/09/23.
//

import Foundation
import AVFoundation

class HomePageData : NSObject{
    
    var title: String = ""
    var description_desc = ""
    var viewtype: String = ""
    var categoryId: String = ""
    var list: [MandirItemModel] = []
    
    enum Keys: String {
        case title = "title"
        case description_key = "description"
        case viewtype = "viewtype"
        case categoryId = "categoryId"
        case list = "list"
    }
    
    init (dict: DICTIONARY) {
        title = getString(anything: dict[Keys.title.rawValue])
        description_desc = getString(anything: dict[Keys.description_key.rawValue])
        viewtype = getString(anything: dict[Keys.viewtype.rawValue])
        categoryId = getString(anything: dict[Keys.categoryId.rawValue])
        list = (dict[Keys.list.rawValue] as? [DICTIONARY])?.map({ MandirItemModel(dict: $0) }) ?? []
    }
    
}
class MandirItemModel: NSObject {
    var _id: String = ""
    var videos_title: String = ""
    var videos_description: String = ""
    var videos_category: String = ""
    var videos_sub_category: String = ""
    var videos_url: String = ""
    var videos_path: String = ""
    var videos_key: String = ""
    var videos_keyword: String = ""
    var videos_temple_locate: String = ""
    var videos_thumbnail: String = ""
    var videos_publisher: String = ""
    var videos_publish: String = ""
    var videos_duration: String = ""
    var update_date: String = ""
    var videos_id: String = ""
    var __v: String = ""
    
    var reels_name: String = ""
    var reels_summary: String = ""
    var reels_path: String = ""
    var reels_thumbnail: String = ""
    var reels_code: String = ""
    var reels_category: String = ""
    var reels_id: String = ""
    
    var image_thumbnail: String = ""
    
    var article_thumbnail: String = ""
    var article_title: String = ""
    var article_link: String = ""
    
    var avPlayer: AVPlayer?
    
    enum Keys: String {
        case _id = "_id"
        case videos_title = "videos_title"
        case videos_description = "videos_description"
        case videos_category = "videos_category"
        case videos_sub_category = "videos_sub_category"
        case videos_url = "videos_url"
        case videos_path = "videos_path"
        case videos_key = "videos_key"
        case videos_keyword = "videos_keyword"
        case videos_temple_locate = "videos_temple_locate"
        case videos_thumbnail = "videos_thumbnail"
        case videos_publisher = "videos_publisher"
        case videos_publish = "videos_publish"
        case videos_duration = "videos_duration"
        case update_date = "update_date"
        case videos_id = "videos_id"
        case __v = "__v"
        
        case reels_name = "reels_name"
        case reels_summary = "reels_summary"
        case reels_path = "reels_path"
        case reels_thumbnail = "reels_thumbnail"
        case reels_code = "reels_code"
        case reels_category = "reels_category"
        case reels_id = "reels_id"
        
        case image_thumbnail = "image_thumbnail"
        
        case article_thumbnail = "article_thumbnail"
        case article_title = "article_title"
        case article_link = "article_link"
        
    }
    
    init(dict: DICTIONARY) {
        _id = getString(anything: dict[Keys._id.rawValue])
        videos_title = getString(anything: dict[Keys.videos_title.rawValue])
        videos_description = getString(anything: dict[Keys.videos_description.rawValue])
        videos_category = getString(anything: dict[Keys.videos_category.rawValue])
        videos_sub_category = getString(anything: dict[Keys.videos_sub_category.rawValue])
        videos_url = getString(anything: dict[Keys.videos_url.rawValue])
        videos_path = getString(anything: dict[Keys.videos_path.rawValue])
        videos_key = getString(anything: dict[Keys.videos_key.rawValue])
        videos_keyword = getString(anything: dict[Keys.videos_keyword.rawValue])
        videos_temple_locate = getString(anything: dict[Keys.videos_temple_locate.rawValue])
        videos_thumbnail = getString(anything: dict[Keys.videos_thumbnail.rawValue])
        videos_publisher = getString(anything: dict[Keys.videos_publisher.rawValue])
        videos_publish = getString(anything: dict[Keys.videos_publish.rawValue])
        videos_duration = getString(anything: dict[Keys.videos_duration.rawValue])
        update_date = getString(anything: dict[Keys.update_date.rawValue])
        videos_id = getString(anything: dict[Keys.videos_id.rawValue])
        __v = getString(anything: dict[Keys.__v.rawValue])
        
        reels_name = getString(anything: dict[Keys.reels_name.rawValue])
        reels_summary = getString(anything: dict[Keys.reels_summary.rawValue])
        reels_path = getString(anything: dict[Keys.reels_path.rawValue])
        reels_thumbnail = getString(anything: dict[Keys.reels_thumbnail.rawValue])
        reels_code = getString(anything: dict[Keys.reels_code.rawValue])
        reels_category = getString(anything: dict[Keys.reels_category.rawValue])
        reels_id = getString(anything: dict[Keys.reels_id.rawValue])
        
        image_thumbnail = getString(anything: dict[Keys.image_thumbnail.rawValue])
        
        article_thumbnail = getString(anything: dict[Keys.article_thumbnail.rawValue])
        article_title = getString(anything: dict[Keys.article_title.rawValue])
        article_link = getString(anything: dict[Keys.article_link.rawValue])
        
    }
}
