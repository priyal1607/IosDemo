//
//  MusicModel.swift
//  loginDemo
//
//  Created by Priyal on 24/08/23.
//

import Foundation
import UIKit

class MusicModel: NSObject {
    

    var _id:String = ""
    var music_title:String = ""
    var music_category:String = ""
    var music_subcategory:String = ""
    var music_singer:String = ""
    var music_thumbnail:String = ""
    var music_url:String = ""
    var music_key:String = ""
    var music_path:String = ""
    var music_duration:String = ""
    var music_publisher:String = ""
    var update_date:String = ""
    var music_id:String = ""
    var __v:String = ""
    
    init(dict:[String:Any]) {
        _id = getString(anything: dict["_id"])
        music_title = getString(anything: dict["music_title"])
        music_category = getString(anything: dict["music_category"])
        music_subcategory = getString(anything: dict["music_subcategory"])
        music_singer = getString(anything: dict["music_singer"])
        music_thumbnail = getString(anything: dict["music_thumbnail"])
        music_url = getString(anything: dict["music_url"])
        music_key = getString(anything: dict["music_key"])
        music_path = getString(anything: dict["music_path"])
        music_duration = getString(anything: dict["music_duration"])
        music_publisher = getString(anything: dict["music_publisher"])
        update_date = getString(anything: dict["update_date"])
        music_id = getString(anything: dict["music_id"])
        __v = getString(anything: dict["__v"])
        
    }
}



