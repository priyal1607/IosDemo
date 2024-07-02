//
//  MusicWebService.swift
//  loginDemo
//
//  Created by Priyal on 24/08/23.
//

import UIKit

class MusicWebService: NSObject {
    func getMusicList(block: @escaping (([MusicModel], _ result : Bool,_ totalCount:Int) -> Swift.Void)) {
        var page = "1"
        var category = "krishna"
        var subCat = "all"
        
        let dict = ["category":category,
                    "subcategory":subCat,
                    CommonAPIConstant.key_page :page]
        
        WShandler.shared.getWebRequest(apiURLType: .other("https://knowyourtemples.in/api/v1/mobile/musicbycategory"), param: dict) { json, flag in
            
            if flag == 200 && (getString(anything: json[CommonAPIConstant.resultFlag]) == "1") || (getString(anything: json[CommonAPIConstant.resultFlag]) == "0") {
                if let data = json[CommonAPIConstant.key_data] as? [[String : Any]] {
                    let response = data.map({ MusicModel(dict: $0)})
                    let totalCount = getInteger(anything: json[CommonAPIConstant.key_totalCount])
                    block(response, true,totalCount)
                } else {
                    block([], true,0)
                }
            } else {
                block([], false,0)
                Global.shared.showBanner(message: getString(anything: json["message"]))
            }
        }
    }
}
