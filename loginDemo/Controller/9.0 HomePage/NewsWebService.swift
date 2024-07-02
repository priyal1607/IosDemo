//
//  NewsWebService.swift
//  loginDemo
//
//  Created by Chelsi on 26/05/23.
//

import Foundation
class NewsWebService: NSObject {

func getUserData (block : @escaping([NewsModel]) -> Swift.Void){
    var responsemodel = [NewsModel]()
    let dict = readJsonFile(ofName: "CommonJSON")
    if let arr = dict["data2"] as? [[String : Any]]{
        responsemodel = arr.map({NewsModel(dict: $0) })
             }
    block(responsemodel)
         }

}
