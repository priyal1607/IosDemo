//
//  NewsModel.swift
//  loginDemo
//
//  Created by Chelsi on 26/05/23.
//

import Foundation

class NewsModel : NSObject {


    var details : String!
    var image : String!
    var time2 : String!
    var title : String!
  

    enum keys: String {
       
        case details
        case image
        case time2
        case title
       
    }
    
init(dict : [String:Any]){
    self.details = dict[keys.details.rawValue] as? String
    self.image = dict[keys.image.rawValue] as? String
    self.time2 = dict[keys.time2.rawValue] as? String
    self.title = dict[keys.title.rawValue] as? String
    }
}
