//
//  LoginWebService.swift
//  loginDemo
//
//  Created by Chelsi on 17/05/23.
//

//
//  LoginwebserviceModel.swift
//  loginDemo
//
//  Created by Chelsi on 19/04/23.
//

import Foundation

class Loginwebservice: NSObject {

func getUserData (block : @escaping(DashboardModel) -> Swift.Void){
    var responsemodel : DashboardModel?
    let dict = readJsonFile(ofName: "CommonJSON")
    if let arr = dict["data1"] as? [String : Any]{
        responsemodel = DashboardModel(dict: arr)
             }
    block(responsemodel ?? DashboardModel(dict: [:]))
         }

}

