//
//  LoginwebserviceModel.swift
//  loginDemo
//
//  Created by Chelsi on 19/04/23.
//

import Foundation

class DashboardWebServiceModel: NSObject {
    
    func dashboarddata(block : @escaping([DashboardModel]) -> Swift.Void){
        var responsemodel =  [DashboardModel]()
        let dict = readJsonFile(ofName: "CommonJSON")
        if let arr = dict["data"] as? [[String : Any]]{
            responsemodel =  arr.map({ DashboardModel(dict: $0)}).sorted(by: {$0.name < $1.name})
        }
        block(responsemodel)
    }
}



