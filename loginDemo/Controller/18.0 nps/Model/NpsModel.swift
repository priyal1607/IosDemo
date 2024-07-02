//
//  NpsModel.swift
//  loginDemo
//
//  Created by Priyal on 18/09/23.
//

import Foundation
class NpsModel : NSObject{
    
    var asOnDate : String!
    var errorDescription : String!
    var fieldErrors : AnyObject!
    var pran : String!
    var statusCode : Int!
    var tier1 : NpsTier1!
    var tier2 : NpsTier1!
    var tier3 : NpsTier3!
    var totalValue : Float!
    var userName : String!
    

    init(fromDictionary dictionary: [String:Any]){
        asOnDate = dictionary["asOnDate"] as? String
        errorDescription = dictionary["errorDescription"] as? String
        fieldErrors = dictionary["fieldErrors"] as? AnyObject
        pran = dictionary["pran"] as? String
        statusCode = dictionary["statusCode"] as? Int
        if let tier1Data = dictionary["tier1"] as? [String:Any]{
            tier1 = NpsTier1(fromDictionary: tier1Data)
        }
        if let tier2Data = dictionary["tier2"] as? [String:Any]{
            tier2 = NpsTier1(fromDictionary: tier2Data)
        }
        if let tier3Data = dictionary["tier3"] as? [String:Any]{
            tier3 = NpsTier3(fromDictionary: tier3Data)
        }
        totalValue = dictionary["totalValue"] as? Float
        userName = dictionary["userName"] as? String
    }
}
class NpsTier3 : NSObject{
    
    var amtInTransit : Int!
    var message : String!
    var schemes : [AnyObject]!
    var total : Int!
    
    init(fromDictionary dictionary: [String:Any]){
        amtInTransit = dictionary["amtInTransit"] as? Int
        message = dictionary["message"] as? String
        schemes = dictionary["schemes"] as? [AnyObject]
        total = dictionary["total"] as? Int
    }
    
}
class NpsTier1 : NSObject{
    
    var amtInTransit : Int!
    var message : String!
    var schemes : [NpsScheme]!
    var total : Float!
    
    init(fromDictionary dictionary: [String:Any]){
        amtInTransit = dictionary["amtInTransit"] as? Int
        message = dictionary["message"] as? String
        schemes = [NpsScheme]()
        if let schemesArray = dictionary["schemes"] as? [[String:Any]]{
            for dic in schemesArray{
                let value = NpsScheme(fromDictionary: dic)
                schemes.append(value)
            }
        }
        total = dictionary["total"] as? Float
    }
    
}
class NpsScheme : NSObject{
    
    var blckdUnits : Int!
    var freeUnits : Float!
    var nav : Double!
    var navDate : String!
    var schPercentage : Int!
    var schemeId : String!
    var schemeName : String!
    var units : Double!
    var value : Double!
    
    init(fromDictionary dictionary: [String:Any]){
        blckdUnits = dictionary["blckdUnits"] as? Int
        freeUnits = dictionary["freeUnits"] as? Float
        nav = dictionary["nav"] as? Double
        navDate = dictionary["navDate"] as? String
        schPercentage = dictionary["schPercentage"] as? Int
        schemeId = dictionary["schemeId"] as? String
        schemeName = dictionary["schemeName"] as? String
        units = dictionary["units"] as? Double
        value = dictionary["value"] as? Double
    }
    
}
class DistributionModel : NSObject{
    
    var email : String!
    var pRAN : String!
    var phoneNumber : String!
    var tier1Details : [DistributionTier1Detail]!
    var tier1TotalContribution : String!
    var tier1TotalValue : String!
    var tier1XIRR : String!
    var tier2Details : [DistributionTier1Detail]!
    var tier2TotalContribution : String!
    var tier2TotalValue : String!
    var tier2XIRR : String!
    
    
    init(fromDictionary dictionary: [String:Any]){
        email = dictionary["Email"] as? String
        pRAN = dictionary["PRAN"] as? String
        phoneNumber = dictionary["PhoneNumber"] as? String
        tier1Details = [DistributionTier1Detail]()
        if let tier1DetailsArray = dictionary["Tier1Details"] as? [[String:Any]]{
            for dic in tier1DetailsArray{
                let value = DistributionTier1Detail(fromDictionary: dic)
                tier1Details.append(value)
            }
        }
        tier1TotalContribution = dictionary["Tier1TotalContribution"] as? String
        tier1TotalValue = dictionary["Tier1TotalValue"] as? String
        tier1XIRR = dictionary["Tier1XIRR"] as? String
        tier2Details = [DistributionTier1Detail]()
        if let tier2DetailsArray = dictionary["Tier2Details"] as? [[String:Any]]{
            for dic in tier2DetailsArray{
                let value = DistributionTier1Detail(fromDictionary: dic)
                tier2Details.append(value)
            }
        }
        tier2TotalContribution = dictionary["Tier2TotalContribution"] as? String
        tier2TotalValue = dictionary["Tier2TotalValue"] as? String
        tier2XIRR = dictionary["Tier2XIRR"] as? String
    }
}
class DistributionTier1Detail : NSObject{
    
    var accountType : String!
    var balanceUnits : String!
    var currentAmount : String!
    var currentNav : String!
    var investedAmount : String!
    var navDate : String!
    var schemeName : String!
    var sector : String!
    
    init(fromDictionary dictionary: [String:Any]){
        accountType = dictionary["AccountType"] as? String
        balanceUnits = dictionary["BalanceUnits"] as? String
        currentAmount = dictionary["CurrentAmount"] as? String
        currentNav = dictionary["CurrentNav"] as? String
        investedAmount = dictionary["InvestedAmount"] as? String
        navDate = dictionary["NavDate"] as? String
        schemeName = dictionary["SchemeName"] as? String
        sector = dictionary["Sector"] as? String
    }
    
}
