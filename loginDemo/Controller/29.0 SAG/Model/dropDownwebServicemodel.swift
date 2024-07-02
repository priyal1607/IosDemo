//
//  dropDownwebServicemodel.swift
//  loginDemo
//
//  Created by Priyal on 05/12/23.
//

import Foundation
import UIKit
class DropDownListModel:NSObject{
    typealias Dictionary = [String : Any]
    var id:String
    var title:String

    init(data:Dictionary){
        self.id = getString(anything: data["id"])
        self.title = getString(anything: data["title"])
    }
}
class PlayerRegistrationDropDownModel : NSObject{

    var resultflag : String!
    var message : String!
    var title : [DropDownListModel] = []
    var gender : [DropDownListModel] = []
    var user_category : [DropDownListModel] = []
    var ms_sports_id : [DropDownListModel] = []
    var atelic_category : [DropDownListModel] = []
    var para_sub_category : [DropDownListModel] = []
    var benefit_sag : [DropDownListModel] = []
    
    init(fromDictionary dictionary: [String:Any]){
        resultflag = getString(anything: dictionary["_resultflag"])
        message = getString(anything: dictionary["message"])
        
        title = [DropDownListModel]()
        if let listArray = dictionary["title"] as? [[String:Any]] {
            for dic in listArray{
                let value = DropDownListModel(data: dic)
                title.append(value)
            }
        }
        
        benefit_sag = [DropDownListModel]()
        if let listArray = dictionary["benefit_sag"] as? [[String:Any]] {
            for dic in listArray{
                let value = DropDownListModel(data: dic)
                benefit_sag.append(value)
            }
        }
        
        gender = [DropDownListModel]()
        if let listArray = dictionary["gender"] as? [[String:Any]]{
            for dic in listArray{
                let value = DropDownListModel(data: dic)
                gender.append(value)
            }
        }
        user_category = [DropDownListModel]()
        if let listArray = dictionary["user_category"] as? [[String:Any]]{
            for dic in listArray{
                let value = DropDownListModel(data: dic)
                user_category.append(value)
            }
        }
        ms_sports_id = [DropDownListModel]()
        if let listArray = dictionary["ms_sports_id"] as? [[String:Any]]{
            for dic in listArray{
                let value = DropDownListModel(data: dic)
                ms_sports_id.append(value)
            }
        }
        atelic_category = [DropDownListModel]()
        if let listArray = dictionary["atelic_category"] as? [[String:Any]]{
            for dic in listArray{
                let value = DropDownListModel(data: dic)
                atelic_category.append(value)
            }
        }
        para_sub_category = [DropDownListModel]()
        if let listArray = dictionary["para_sub_category"] as? [[String:Any]]{
            for dic in listArray{
                let value = DropDownListModel(data: dic)
                para_sub_category.append(value)
            }
        }
    }
}
class dropDownwebServicemodel : NSObject {
    var form_type:String = ""
    typealias Dictionary = [String : Any]
    fileprivate var getListUrl:String {
        return "http://sagportal.php-staging.com/apiv2/get-inschool-program-master"
    }
    private var dropDownData: Dictionary {
        let dict: Dictionary = [keys.form_type.rawValue:form_type]
        return dict
    }
    
    enum keys:String {
        case form_type = "form_type"
    }
    
    func getList(block: @escaping ((PlayerRegistrationDropDownModel) -> Swift.Void)) {
        
        var param = WShandler.commonDict1()
        let dict = dropDownData
       
        for key in dict.keys {
            param[key] = dict[key]
        }
        print(param)
        if (WShandler.shared.CheckInternetConnectivity())  {
            
            WShandler.shared.getWebRequest1(urlStr: getListUrl, param: param) { (json, flag) in
                
                var responseModel = PlayerRegistrationDropDownModel(fromDictionary: [:])
                print(json)
                if flag == 200 {
                    responseModel = PlayerRegistrationDropDownModel(fromDictionary: json)
                } else {
                    Global.shared.showBanner(message: getString(anything: json[CommonAPIConstant.key_message]))
                }
                block(responseModel)
            }

            
        }  else {
            block(PlayerRegistrationDropDownModel(fromDictionary: [:]))
            Global.shared.showBanner(message: "Internet Issue")
        }
    }
    
    
}

class PlayerPersonalInfoModel: NSObject {
    
    var title = ""
    var firstName : String = ""
    var middleName : String = ""
    var lastName : String = ""
    var dob = ""
    var age = ""
    var gender = ""
    var userCategory = ""
    var sport = ""
    var sportCategory = ""
    var para_sub_category = ""
    var email = ""
    var mobileNumber : String = ""
    var other_sports = ""
    
    enum Keys: String {
        case title = "title"
        case firstname = "first_name"
        case middlename = "middle_name"
        case lastname = "last_name"
        case dob = "date_of_birth"
        case age = "age"
        case gender = "gender"
        case userCategory = "user_category"
        case sport = "ms_sports_id"
        case sportCategory = "atelic_category"
        case para_sub_category = "para_sub_category"
        case mobileNumber = "mobile_number"
        case email = "email"
        case other_sports = "other_sports"
    }
    
    //MARK:- Initializer
    override init() {
        super.init()
    }
    
    func dicData() -> dictionary {
        return [Keys.title.rawValue : self.title,
                Keys.firstname.rawValue : self.firstName,
                Keys.middlename.rawValue : self.middleName,
                Keys.lastname.rawValue : self.lastName,
                Keys.dob.rawValue : self.dob,
                Keys.age.rawValue : self.age,
                Keys.gender.rawValue : self.gender,
                Keys.userCategory.rawValue : self.userCategory,
                Keys.sport.rawValue : self.sport,
                Keys.sportCategory.rawValue : self.sportCategory,
                Keys.para_sub_category.rawValue : self.para_sub_category,
                Keys.mobileNumber.rawValue : self.mobileNumber,
                Keys.other_sports.rawValue : self.other_sports,
                Keys.email.rawValue : self.email]
    }
}

class DistrictsListModel:NSObject{
    var id:Int
    var title:String
    typealias Dictionary = [String : Any]
    init(data:Dictionary){
        self.id = getInteger(anything: data["id"])
        self.title = getString(anything: data["title"])
    }
}

//MARK: - Coach Mapping Detail
class DistrictMdel : NSObject{
    var resultflag : String!
    var data : [DistrictsListModel]!
    var message : String!
    
    init(fromDictionary dictionary: [String:Any]){
        resultflag = getString(anything: dictionary["_resultflag"])
        data = [DistrictsListModel]()
        if let listArray = dictionary["data"] as? [[String:Any]]{
            for dic in listArray{
                let value = DistrictsListModel(data: dic)
                data.append(value)
            }
        }
        message = getString(anything: dictionary["message"])
    }
}
class PlayerAddressInfoModel: NSObject {
    
    var district = ""
    var taluka = ""
    var village = ""
    var pin = ""
    var address = ""
    typealias Dictionary = [String : Any]
    
    enum Keys: String {
        case district = "ms_districts_id"
        case taluka = "ms_talukas_id"
        case village = "ms_villages_id"
        case pin = "pincode"
        case address = "address"
       
    }
    
    //MARK:- Initializer
    override init() {
        super.init()
    }
    
    func dicData() -> Dictionary {
        return [Keys.district.rawValue : self.district,
                Keys.taluka.rawValue : self.taluka,
                Keys.village.rawValue : self.village,
                Keys.pin.rawValue : self.pin,
                Keys.address.rawValue : self.address]
    }
}
class PlayerLoginInfoModel: NSObject {
    
    var username = ""
    var password = ""
    var benefit_sag = ""
    typealias Dictionary = [String : Any]
    
    enum Keys: String {
        case username = "user_name"
        case password = "password"
        case benefit_sag = "benefit_sag"
    }
    
    //MARK:- Initializer
    override init() {
        super.init()
    }
    
    func dicData() -> Dictionary {
        return [Keys.username.rawValue : self.username,
                Keys.password.rawValue : self.password,
                Keys.benefit_sag.rawValue : self.benefit_sag]
    }
}
