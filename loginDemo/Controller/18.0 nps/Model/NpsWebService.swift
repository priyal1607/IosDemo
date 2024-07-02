//
//  NpsWebService.swift
//  loginDemo
//
//  Created by Priyal on 18/09/23.
//

import Foundation
class NpsWebService: NSObject {
    
    func getNPSData(block : @escaping([NpsTier1] , [NpsScheme] , Double) -> Swift.Void){
        var responsemodelTier1 = [NpsTier1]()
        var responsemodelSchemes = [NpsScheme]()
        var total : Double = 0.0
        let dict = readJsonFile(ofName: "Npsdata")
        if let tier1Data = dict["tier1"] as? [String: Any] {
            if let schemesArray = tier1Data["schemes"] as? [[String: Any]] {
                    responsemodelSchemes = schemesArray.map { NpsScheme(fromDictionary: $0) }
                total = tier1Data["total"] as! Double
                   }
                   
                   // You can access other properties of tier1Data here if needed
               }
               
               // Now, parse "schemes" data if it's a separate array (not nested under "tier1")
               if let schemesArray = dict["schemes"] as? [[String: Any]] {
                   responsemodelSchemes = schemesArray.map { NpsScheme(fromDictionary: $0) }
               }
              
               block(responsemodelTier1, responsemodelSchemes , total)
           }
    func getNPSDataTier2(block : @escaping([NpsTier1] , [NpsScheme] , Double) -> Swift.Void){
        var responsemodelTier1 = [NpsTier1]()
        var responsemodelSchemes = [NpsScheme]()
        var total : Double = 0.0
        let dict = readJsonFile(ofName: "Npsdata")
        if let tier1Data = dict["tier2"] as? [String: Any] {
            if let schemesArray = tier1Data["schemes"] as? [[String: Any]] {
                    responsemodelSchemes = schemesArray.map { NpsScheme(fromDictionary: $0) }
                total = tier1Data["total"] as! Double
                   }
                   
                   // You can access other properties of tier1Data here if needed
               }
               
               // Now, parse "schemes" data if it's a separate array (not nested under "tier1")
               if let schemesArray = dict["schemes"] as? [[String: Any]] {
                   responsemodelSchemes = schemesArray.map { NpsScheme(fromDictionary: $0) }
               }
              
               block(responsemodelTier1, responsemodelSchemes , total)
           }
    
    func getDistributionData(block : @escaping(Double, Double) -> Swift.Void){
        let dict = readJsonFile(ofName: "barChartData")
        let distribution = getDouble(anything: dict["Tier1TotalContribution"])
        let total = getDouble(anything: dict["Tier1TotalValue"])
        block(distribution as! Double , total as! Double)
    }
    func getDistributionDataTier2(block : @escaping(Double, Double) -> Swift.Void){
        let dict = readJsonFile(ofName: "barChartData")
        let distribution = getDouble(anything: dict["Tier2TotalContribution"])
        let total = getDouble(anything: dict["Tier2TotalValue"])
        block(distribution as! Double , total as! Double)
    }
}
