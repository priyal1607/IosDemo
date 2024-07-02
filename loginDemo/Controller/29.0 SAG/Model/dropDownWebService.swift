//
//  dropDownWebService.swift
//  loginDemo
//
//  Created by Priyal on 05/12/23.
//

import Foundation
class dropDownWebService : NSObject {
    var form_type:String = ""
    var id:Int = 0
    var tId:Int = 0
    typealias Dictionary = [String : Any]
    private var talukaData: Dictionary {
        let dict: Dictionary = [keys.id.rawValue:id]
        return dict
    }
    private var VillageData: Dictionary {
        let dict: Dictionary = [keys.id.rawValue:id,
                                keys.tid.rawValue:tId]
        return dict
    }
    
    enum keys:String {
        case id = "id"
        case tid = "tid"
    }
    
    
    func getList(block: @escaping (([DropDownResponseModel]) -> Swift.Void)) {
        
        let uuid = UUID().uuidString
        if (WShandler.shared.CheckInternetConnectivity()) {
            WShandler.shared.getWebRequest(apiURLType: .other("http://sagportal.php-staging.com/apiv2/player-registration?device_id"), param: ["device_id" : "6DFDDE7D-1998-4154-92F3-BEC02394CE3E"]) { (json, flag) in
                
                var responseModel = DropDownResponseModel(selectTitleType: [:])
                print(json)
                if flag == 200 {
                    responseModel = DropDownResponseModel(selectTitleType: [:])
                } else {
                    Global.shared.showBanner(message: getString(anything: json[CommonAPIConstant.key_message]))
                }
                block([responseModel])
            }
        }  else {
            block([DropDownResponseModel(selectTitleType: [:])])
            Global.shared.showBanner(message: "Internet Issue")
        }
    }
    
    func getListDistrict(block: @escaping ((DistrictMdel) -> Swift.Void)) {
        
        var param = WShandler.commonDict1()

        if (WShandler.shared.CheckInternetConnectivity()) {
            
            WShandler.shared.getWebRequest1(urlStr: "http://sagportal.php-staging.com/apiv2/get-districts", param: param) { (json, flag) in
                var responseModel = DistrictMdel(fromDictionary: [:])
                if flag == 200 {
                    responseModel = DistrictMdel(fromDictionary: json)
                } else {
                    Global.shared.showBanner(message: getString(anything: json[CommonAPIConstant.key_message]))
                }
                block(responseModel)
            }
        }  else {
            block(DistrictMdel(fromDictionary: [:]))
            Global.shared.showBanner(message: "indernet issue")
        }
    }
    
    func getListTaluka(block: @escaping ((DistrictMdel) -> Swift.Void)) {
        
        var param = WShandler.commonDict1()
        let dict = talukaData
       
        for key in dict.keys {
            param[key] = dict[key]
        }
        
        if (WShandler.shared.CheckInternetConnectivity()) {

            WShandler.shared.getWebRequest1(urlStr: "http://sagportal.php-staging.com/apiv2/get-talukas", param: param) { (json, flag) in
                
                var responseModel = DistrictMdel(fromDictionary: [:])
                if flag == 200 {
                    responseModel = DistrictMdel(fromDictionary: json)
                } else {
                    Global.shared.showBanner(message: getString(anything: json[CommonAPIConstant.key_message]))
                }
                block(responseModel)
            }
        }  else {
            block(DistrictMdel(fromDictionary: [:]))
            Global.shared.showBanner(message: "Internet Issue")
        }
    }
    
 

    
    func getListVillage(block: @escaping ((DistrictMdel) -> Swift.Void)) {
        
        var param = WShandler.commonDict1()
        let dict = VillageData
       
        for key in dict.keys {
            param[key] = dict[key]
        }
        if (WShandler.shared.CheckInternetConnectivity()) {

            WShandler.shared.getWebRequest1(urlStr: "http://sagportal.php-staging.com/apiv2/get-villages", param: param) { (json, flag) in

                var responseModel = DistrictMdel(fromDictionary: [:])
                if flag == 200 {
                    responseModel = DistrictMdel(fromDictionary: json)
                } else {
                    Global.shared.showBanner(message: getString(anything: json[CommonAPIConstant.key_message]))
                }
                block(responseModel)
            }
        }  else {
            block(DistrictMdel(fromDictionary: [:]))
            Global.shared.showBanner(message: "Internet Issue")
        }
    }
    
}




import UIKit

class PersonalInformationModel : NSObject {
    typealias Dictionary = [String : Any]
    var title: String = ""
    var firstName: String = ""
    var middleName: String = ""
    var lastName: String = ""
    var dateOfBirth: String = ""
    var age: String = ""
    var selectGender: String = ""
    var selectUserCategory: String = ""
    var selectSportsId: String = ""
    var otherSports: String = ""
    var sportsCategory: String = ""
    var mobileNumber: String = ""
    var email: String = ""
    var districtId: String = ""
    var taluka_ZoneId: String = ""
    var villageWardId: String = ""
    var pinCode: String = ""
    var address: String = ""
    var benefit_sag: String = ""
    var para_sub_category : String = ""
    
    enum Keys:String {
        //    MARK: - Information
        case title = "title"
        case first_name = "first_name"
        case middle_name = "middle_name"
        case last_name = "last_name"
        case date_of_birth = "date_of_birth"
        case age = "age"
        case gender = "gender"
        case user_category = "user_category"
        case ms_sports_id = "ms_sports_id"
        case other_sports = "other_sports"
        case atelic_category = "atelic_category"
        case mobile_number = "mobile_number"
        case email = "email"
        case ms_districts_id = "ms_districts_id"
        case ms_talukas_id = "ms_talukas_id"
        case ms_villages_id = "ms_villages_id"
        case pincode = "pincode"
        case address = "address"
        case benefit_sag = "benefit_sag"
        case para_sub_category = "para_sub_category"
    }
    
    override init(){
        super.init()
    }
    
    func dicData() -> Dictionary {
        return [
            //    MARK: - Information
            Keys.title.rawValue : self.title,
            Keys.first_name.rawValue : self.firstName,
            Keys.middle_name.rawValue : self.middleName,
            Keys.last_name.rawValue : self.lastName,
            Keys.date_of_birth.rawValue : self.dateOfBirth,
            Keys.age.rawValue : self.age,
            Keys.gender.rawValue : self.selectGender,
            Keys.user_category.rawValue : self.selectUserCategory,
            Keys.ms_sports_id.rawValue : self.selectSportsId,
            Keys.other_sports.rawValue : self.otherSports,
            Keys.atelic_category.rawValue : self.sportsCategory,
            Keys.mobile_number.rawValue : self.mobileNumber,
            Keys.email.rawValue : self.email,
            Keys.ms_districts_id.rawValue : self.districtId ,
            Keys.ms_talukas_id.rawValue : self.taluka_ZoneId,
            Keys.ms_villages_id.rawValue : self.villageWardId,
            Keys.pincode.rawValue : self.pinCode,
            Keys.benefit_sag.rawValue : self.benefit_sag,
            Keys.para_sub_category.rawValue : self.para_sub_category,
            Keys.address.rawValue : self.address
            ]
    }
}

//MARK: - Personal Info Get Data

class PersonalInformationGetDataModel : NSObject {
    typealias Dictionary = [String : Any]
    var title: String = ""
    var first_name: String = ""
    var middle_name: String = ""
    var last_name: String = ""
    var date_of_birth: String = ""
    var age: String = ""
    var gender: String = ""
    var user_category: String = ""
    var upload_photo: String = ""
    var ms_sports_id: String = ""
    var other_sports: String = ""
    var atelic_category: String = ""
    var mobile_number: String = ""
    var sportsCategory: String = ""
    var sportsCategoryId: String = ""
    var mobileNumber: String = ""
    var email: String = ""
    var ms_districts_id: String = ""
    var ms_talukas_id: String = ""
    var ms_villages_id: String = ""
    var pincode: String = ""
    var address: String = ""
    var district_name: String = ""
    var sports_title: String = ""
    var taluka_name: String = ""
    var village_name: String = ""
    var para_sub_category : String = ""
    var benefit_sag : String = ""
    
    init(data:Dictionary){
        self.title = getString(anything: data["title"] as? String ?? "")
        self.first_name = data["first_name"] as? String ?? ""
        self.middle_name = data["middle_name"] as? String ?? ""
        self.last_name = data["last_name"] as? String ?? ""
        self.date_of_birth = data["date_of_birth"] as? String ?? ""
        self.age = getString(anything: data["age"])
        self.gender = data["gender"] as? String ?? ""
        self.user_category = data["user_category"] as? String ?? ""
        self.upload_photo = data["upload_photo"] as? String ?? ""
        self.ms_sports_id = getString(anything: data["ms_sports_id"])
        self.other_sports = data["other_sports"] as? String ?? ""
        self.atelic_category = data["atelic_category"] as? String ?? ""
        self.mobile_number = data["mobile_number"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.ms_districts_id = getString(anything: data["ms_districts_id"])
        self.ms_talukas_id =  getString(anything:data["ms_talukas_id"] )
        self.ms_villages_id = getString(anything: data["ms_villages_id"])
        self.pincode = data["pincode"] as? String ?? ""
        self.address = data["address"] as? String ?? ""
        self.district_name = data["district_name"] as? String ?? ""
        self.sports_title = data["sports_title"] as? String ?? ""
        self.taluka_name = data["taluka_name"] as? String ?? ""
        self.village_name = data["village_name"] as? String ?? ""
        self.para_sub_category = data["para_sub_category"] as? String ?? ""
        self.benefit_sag = data["benefit_sag"] as? String ?? ""
    }
}
