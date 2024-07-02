//
//  HomePageModel.swift
//  loginDemo
//
//  Created by Chelsi on 24/05/23.
//

import Foundation
class HomePageModel : NSObject {
    var TitleKey:String
    let storyboardID:String
    let Image:String


enum keys: String {
case TitleKey
    case storyboardID
    case Image
    
}
    init(dict : [String:Any]){
        self.TitleKey = dict[keys.TitleKey.rawValue] as? String ?? ""
        self.storyboardID = dict[keys.storyboardID.rawValue] as? String ?? ""
        self.Image = dict[keys.Image.rawValue] as? String ?? ""
    }
}
