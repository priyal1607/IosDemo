//
//  HomePageWebService.swift
//  loginDemo
//
//  Created by Priyal on 11/09/23.
//

import Foundation
import UIKit

//class HomePageWebService: NSObject {
//    func getList(block: @escaping (([HomePageData], _ result : Bool) -> Swift.Void)) {
//        var page = "1"
//
//
//        let dict = [CommonAPIConstant.key_page :page]
//
//        WShandler.shared.getWebRequest(apiURLType: .other("http://194.233.91.149:3000/api/v1/mobile/homescreen"), param: dict) { json, flag in
//
//            if flag == 200 && (getString(anything: json[CommonAPIConstant.resultFlag]) == "1") || (getString(anything: json[CommonAPIConstant.resultFlag]) == "0") {
//                if let data = json[CommonAPIConstant.key_data] as? [[String : Any]] {
//                    let response = data.map({ HomePageData(dict: $0)})
//                    let totalCount = getInteger(anything: json[CommonAPIConstant.key_totalCount])
//                    block(response, true)
//                } else {
//                    block([], true)
//                }
//            } else {
//                block([], false)
//                Global.shared.showBanner(message: getString(anything: json["message"]))
//            }
//        }
//    }
//}
class HomePageWebService: NSObject {
    
    func getMandirData(block : @escaping([HomePageData]) -> Swift.Void){
        var responsemodel =  [HomePageData]()
        let dict = readJsonFile(ofName: "data")
        if let arr = dict["data"] as? [[String : Any]]{
            responsemodel =  arr.map({ HomePageData(dict: $0)})
        }
        block(responsemodel)
    }
}
