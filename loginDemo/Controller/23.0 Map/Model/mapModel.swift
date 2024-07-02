//
//  mapModel.swift
//  loginDemo
//
//  Created by Priyal on 02/10/23.
//

import Foundation
class MapModel : NSObject{
    
    var resultflag : String = ""
    var totalcount : String = ""
    var objMissionPostList : [MapObjMissionPostList]!
    var objMissionPostList1 : [MapObjMissionPostList]!

    init(fromDictionary dictionary: [String:Any]){
        resultflag = getString(anything: dictionary["_resultflag"])
        totalcount = getString(anything: dictionary["_totalcount"])
        objMissionPostList = [MapObjMissionPostList]()
        if let objMissionPostListArray = dictionary["objMissionPostList"] as? [[String:Any]]{
            for dic in objMissionPostListArray{
                let value = MapObjMissionPostList(dictionary: dic)
                objMissionPostList.append(value)
            }
        }
        objMissionPostList1 = [MapObjMissionPostList]()
        if let objMissionPostList1Array = dictionary["objMissionPostList1"] as? [[String:Any]]{
            for dic in objMissionPostList1Array{
                let value = MapObjMissionPostList(dictionary: dic)
                objMissionPostList1.append(value)
            }
        }
    }
}

class MapObjMissionPostList : NSObject{
    
    var addressLine1 : String = ""
    var addressLine2 : String = ""
    var addressLine3 : String = ""
    var cityName : String = ""
    var countryID : String = ""
    var countryMissionDtlIDLive : String = ""
    var countryName : String = ""
    var email : String = ""
    var fax : String = ""
    var languageID : String = ""
    var missionID : String = ""
    var name : String = ""
    var name1 : String = ""
    var namePost1 : String = ""
    var namePost2 : String = ""
    var pointerName : String = ""
    var telephone : String = ""
    var webSite : String = ""
    var lattitude : String = ""
    var listname : String = ""
    var longitude : String = ""
    var distanceToCurrentLocation : Double = 0.0

    init(dictionary: DICTIONARY){
        addressLine1 = getString(anything: dictionary["AddressLine1"])
        addressLine2 = getString(anything: dictionary["AddressLine2"])
        addressLine3 = getString(anything: dictionary["AddressLine3"])
        cityName = getString(anything: dictionary["CityName"])
        countryID = getString(anything: dictionary["CountryID"])
        countryMissionDtlIDLive = getString(anything: dictionary["CountryMission)DtlIDLive"])
        countryName = getString(anything: dictionary["CountryName"])
        email = getString(anything: dictionary["Email"])
        fax = getString(anything: dictionary["Fax"])
        languageID = getString(anything: dictionary["LanguageID"])
        missionID = getString(anything: dictionary["MissionID"])
        name = getString(anything: dictionary["Name"])
        name1 = getString(anything: dictionary["Name1"])
        namePost1 = getString(anything: dictionary["NamePost1"])
        namePost2 = getString(anything: dictionary["NamePost2"])
        pointerName = getString(anything: dictionary["PointerName"])
        telephone = getString(anything: dictionary["Telephone"])
        webSite = getString(anything: dictionary["WebSite"])
        lattitude = getString(anything: dictionary["lattitude"])
        listname = getString(anything: dictionary["listname"])
        longitude = getString(anything: dictionary["longitude"])
        distanceToCurrentLocation = getDouble(anything: dictionary["distanceToCurrentLocation"])
        
    }
}

