//
//  searchWebService.swift
//  loginDemo
//
//  Created by Priyal on 22/09/23.
//

import Foundation

class searchWebService: NSObject {
    func getCategoryData(block : @escaping([SearchModel],[SearchModel]) -> Swift.Void){
        var responsemodel =  [SearchModel]()
        var responsemodel2 =  [SearchModel]()
        let dict = readJsonFile(ofName: "category")
        
        if let arr = dict["categoryData"] as? [[String : Any]]{
            responsemodel =  arr.map({ SearchModel(dict: $0)})
            
        }
        if let arr = dict["authorData"] as? [[String : Any]]{
            responsemodel2 =  arr.map({ SearchModel(dict: $0)})
            
        }
        block(responsemodel , responsemodel2)
    }
}
