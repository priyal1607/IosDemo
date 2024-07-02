//
//  mapWebService.swift
//  loginDemo
//
//  Created by Priyal on 02/10/23.
//

import Foundation
class mapWebService: NSObject {
        
        
        var latitude: String = ""
        var longitude: String = ""
        var countryCode: String = ""
        
        var locationDict: DICTIONARY {
            return ["latitude": self.latitude,
                    "longitude": self.longitude,
                    "CountryCode": self.countryCode]
    }

    
    func getLocationData (block : @escaping([MapObjMissionPostList] , [MapObjMissionPostList]) -> Swift.Void){
        var responsemodel = [MapObjMissionPostList]()
        var responsemodel2 = [MapObjMissionPostList]()
        let dict = readJsonFile(ofName: "map")
        if let arr = dict["objMissionPostList1"] as? [[String : Any]]{
            responsemodel = arr.map({MapObjMissionPostList(dictionary: $0) })
        }
        if let arr = dict["objMissionPostList"] as? [[String : Any]]{
            responsemodel2 = arr.map({MapObjMissionPostList(dictionary: $0) })
        }
        block(responsemodel ,responsemodel2)
    }
        
    func getSpecificCountryData(forCountryID countryID: String, block: @escaping (MapObjMissionPostList?) -> Void) {
            let dict = Global.shared.readJsonFile(ofName: "map")
            
            if let arrList1 = dict["objMissionPostList1"] as? [[String: Any]], let arrList = dict["objMissionPostList"] as? [[String: Any]] {
                
                let selectedArray: [[String: Any]]
                
                if arrList1.contains(where: { ($0["CountryID"] as? String) == countryID }) {
                    // Use objMissionPostList1 if the countryID is found in it
                    selectedArray = arrList1
                } else {
                    // Otherwise, use objMissionPostList
                    selectedArray = arrList
                }
                
                // Find the first matching object based on countryID
                if let selectedObject = selectedArray.first(where: { ($0["CountryID"] as? String) == countryID }) {
                    // Convert the selected object to ImaMapObjMissionPostList
                    let responseModel = MapObjMissionPostList(dictionary: selectedObject)
                    block(responseModel)
                } else {
                    // No matching object found, return nil
                    block(nil)
                }
                
            } else {
                // Handle the case when the arrays are not available
                block(nil)
            }
        }
}

