//
//  bannerWebService.swift
//  loginDemo
//
//  Created by Priyal on 26/09/23.
//


import Foundation
class bannerWebService: NSObject {

func getBannerData (block : @escaping([ListModel]) -> Swift.Void){
    var responsemodel = [ListModel]()
    let dict = readJsonFile(ofName: "banner")
    if let arr = dict["listHomePageBannerList"] as? [[String : Any]]{
        responsemodel = arr.map({ListModel(dict: $0) })
             }
    block(responsemodel)
         }


func getDashboardData (block : @escaping([dashboardList]) -> Swift.Void){
    var responsemodel = [dashboardList]()
    let dict = readJsonFile(ofName: "dashboard")
    if let arr = dict["list"] as? [[String : Any]]{
        responsemodel = arr.map({dashboardList(dict: $0) })
             }
    block(responsemodel)
         }

}

