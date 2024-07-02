//
//  GalleryModel.swift
//  loginDemo
//
//  Created by Priyal on 29/06/23.
//

import Foundation
class PressReleaseModel : NSObject{
    
    var result : [PressReleaseResult]!
    var resultflag : Int!
    var fileurl : String!
    var message : String!
    var model : String!
    var totalCount : Int!
    
    init(fromDictionary dictionary: [String:Any]){
        result = [PressReleaseResult]()
        if let resultArray = dictionary["_result"] as? [[String:Any]]{
            for dic in resultArray{
                let value = PressReleaseResult(fromDictionary: dic)
                result.append(value)
            }
        }
        resultflag = dictionary["_resultflag"] as? Int
        fileurl = dictionary["fileurl"] as? String
        message = dictionary["message"] as? String
        model = dictionary["model"] as? String
        totalCount = dictionary["total_count"] as? Int
    }
}
class PressReleaseResult : NSObject{
    
    var createdAt : String!
    var createdBy : Int!
    var date : String!
    var descriptionField : String!
    var id : Int!
    var image : String!
    var shortDescription : String!
    var status : Bool!
    var title : String!
    var updatedAt : String!
    var updatedBy : Int!
    
    init(fromDictionary dictionary: [String:Any]){
        createdAt = dictionary["created_at"] as? String
        createdBy = dictionary["created_by"] as? Int
        date = dictionary["date"] as? String
        descriptionField = dictionary["description"] as? String
        id = dictionary["id"] as? Int
        image = dictionary["image"] as? String
        shortDescription = dictionary["short_description"] as? String
        status = dictionary["status"] as? Bool
        title = dictionary["title"] as? String
        updatedAt = dictionary["updated_at"] as? String
        updatedBy = dictionary["updated_by"] as? Int
    }
    
}
