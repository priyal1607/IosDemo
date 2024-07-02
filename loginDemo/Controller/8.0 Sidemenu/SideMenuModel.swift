//
//  SideMenuModel.swift
//  loginDemo
//
//  Created by Chelsi on 11/05/23.
//

import Foundation

class SideMenuModel : NSObject {
    var TitleKey:String
    let storyboardID:String
    let Image:String
    var expanded : Bool
    var MoreOptions : [SideMenuModel] = []


enum keys: String {
case TitleKey
    case storyboardID
    case Image
    case MoreOptions
    case expanded
    
}
    init(dict : [String:Any]){
        self.TitleKey = dict[keys.TitleKey.rawValue] as? String ?? ""
        self.storyboardID = dict[keys.storyboardID.rawValue] as? String ?? ""
        self.Image = dict[keys.Image.rawValue] as? String ?? ""
        self.expanded = false
        self.MoreOptions = (dict[keys.MoreOptions.rawValue] as? [[String : Any]])?.map({ SideMenuModel(dict: $0) }) ?? []
    }
}
