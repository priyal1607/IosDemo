//
//  UserModel.swift
//  Vidyanjali
//
//  Created by Vikram Jagad on 12/11/20.
//  Copyright © 2020 Vikram Jagad. All rights reserved.
//

import UIKit

class UserModel: NSObject, NSCoding {
    
    //School / College
    let address : String
    let contact_mobile_number : String
    var contact_number: String
    let contact_person_name: String
    let created_by: String
    let establishment_date: String
    let email:String
    let id: String
    let is_mobile: String
    let ms_districts_id: String
    var ms_sports_id: String
    let ms_talukas_id :String
    var ms_villages_id :String
    let name :String
    let name_of_principal :String
    let pincode :String
    let principal_contact_number :String
    let reference_number :String
    let register_as :String
    let school_dias_number :String
    let token :String
    let type :String
    let updated_by :String
    let upload_logo :String
    let upload_photo :String
    let user_name :String
    let user_roles_id :String
    let district_name: String
    let taluka_name :String
    var village_name :String
    
    //Player
    let aadhaar_card_number :String
    let achievement_form :String
    let age :String
    let ashthma_bronchitis :String
    let atelic_category :String
    let back_neck_pain :String
    let concussion :String
    let date_of_birth :String
    let diabetes :String
    let dislocation :String
    let first_name :String
    let gender :String
    let last_name :String
    let middle_name :String
    let mobile_number :String
    let sports_complex_id :String
    let terms_check :String
    let title :String
    let user_category :String
    let para_sub_category : String
    
    class var currentUser: UserModel {
        if let decoded = UserPreferences.data(forKey: UserPreferencesKeys.UserInfo.userDetail) {
            return NSKeyedUnarchiver.unarchiveObject(with: decoded) as? UserModel ?? UserModel(dict: [:])
        }
        return UserModel(dict: [:])
    }
    
//    class var signedIn: Bool {
//        get {
//            return UserPreferences.bool(forKey: UserPreferencesKeys.General.isUserLoggedIn)
//        } set {
//            UserPreferences.set(value: newValue, forKey: UserPreferencesKeys.General.isUserLoggedIn)
//        }
//    }
//
//    class var email: String {
//        get {
//            return UserPreferences.string(forKey: UserPreferencesKeys.General.email)
//        } set {
//            UserPreferences.set(value: newValue, forKey: UserPreferencesKeys.General.email)
//        }
//    }
//
//    class var userId: String {
//        get {
//            return UserModel.currentUser.id
//        } set(newString) {
//            let userModel = UserModel.currentUser
//            userModel.id = newString
//            userModel.setUserModel()
//        }
//    }

    enum Keys: String {
        //School / College
        case address
        case contact_mobile_number
        case contact_number
        case contact_person_name
        case created_by
        case establishment_date
        case email
        case id
        case is_mobile
        case ms_districts_id
        case ms_sports_id
        case ms_talukas_id
        case ms_villages_id
        case name
        case name_of_principal
        case pincode
        case reference_number
        case register_as
        case token
        case type
        case updated_by
        case upload_logo
        case upload_photo
        case user_name
        case user_roles_id
        case principal_contact_number
        case school_dias_number
        case district_name
        case taluka_name
        case village_name
        
        //Player
        case aadhaar_card_number
        case achievement_form
        case age
        case ashthma_bronchitis
        case atelic_category
        case back_neck_pain
        case concussion
        case date_of_birth
        case diabetes
        case dislocation
        case first_name
        case gender
        case last_name
        case middle_name
        case mobile_number
        case sports_complex_id
        case terms_check
        case title
        case user_category
        case para_sub_category
    }
    
    init(dict: [String : Any]) {
        //School / College
        address = getString(anything: dict[Keys.address.rawValue])
        contact_mobile_number = getString(anything: dict[Keys.contact_mobile_number.rawValue])
        contact_number = getString(anything: dict[Keys.contact_number.rawValue])
        contact_person_name = getString(anything: dict[Keys.contact_person_name.rawValue])
        created_by = getString(anything: dict[Keys.created_by.rawValue])
        establishment_date = getString(anything: dict[Keys.establishment_date.rawValue])
        email = getString(anything: dict[Keys.email.rawValue])
        id = getString(anything: dict[Keys.id.rawValue])
        is_mobile = getString(anything: dict[Keys.is_mobile.rawValue])
        ms_districts_id = getString(anything: dict[Keys.ms_districts_id.rawValue])
        ms_sports_id = getString(anything: dict[Keys.ms_sports_id.rawValue])
        ms_talukas_id = getString(anything: dict[Keys.ms_talukas_id.rawValue])
        ms_villages_id = getString(anything: dict[Keys.ms_villages_id.rawValue])
        name = getString(anything: dict[Keys.name.rawValue])
        name_of_principal = getString(anything: dict[Keys.name_of_principal.rawValue])
        principal_contact_number = getString(anything: dict[Keys.principal_contact_number.rawValue])
        pincode = getString(anything: dict[Keys.pincode.rawValue])
        reference_number = getString(anything: dict[Keys.reference_number.rawValue])
        register_as = getString(anything: dict[Keys.register_as.rawValue])
        token = getString(anything: dict[Keys.token.rawValue])
        type = getString(anything: dict[Keys.type.rawValue])
        updated_by = getString(anything: dict[Keys.updated_by.rawValue])
        upload_logo = getString(anything: dict[Keys.upload_logo.rawValue])
        upload_photo = getString(anything: dict[Keys.upload_photo.rawValue])
        user_name = getString(anything: dict[Keys.user_name.rawValue])
        user_roles_id = getString(anything: dict[Keys.user_roles_id.rawValue])
        school_dias_number = getString(anything: dict[Keys.school_dias_number.rawValue])
        district_name = getString(anything: dict[Keys.district_name.rawValue])
        taluka_name = getString(anything: dict[Keys.taluka_name.rawValue])
        village_name = getString(anything: dict[Keys.village_name.rawValue])
        
        //Player
        aadhaar_card_number = getString(anything: dict[Keys.aadhaar_card_number.rawValue])
        achievement_form = getString(anything: dict[Keys.achievement_form.rawValue])
        age = getString(anything: dict[Keys.age.rawValue])
        ashthma_bronchitis = getString(anything: dict[Keys.ashthma_bronchitis.rawValue])
        atelic_category = getString(anything: dict[Keys.atelic_category.rawValue])
        back_neck_pain = getString(anything: dict[Keys.back_neck_pain.rawValue])
        concussion = getString(anything: dict[Keys.concussion.rawValue])
        date_of_birth = getString(anything: dict[Keys.date_of_birth.rawValue])
        diabetes = getString(anything: dict[Keys.diabetes.rawValue])
        dislocation = getString(anything: dict[Keys.dislocation.rawValue])
        gender = getString(anything: dict[Keys.gender.rawValue])
        first_name = getString(anything: dict[Keys.first_name.rawValue])
        last_name = getString(anything: dict[Keys.last_name.rawValue])
        middle_name = getString(anything: dict[Keys.middle_name.rawValue])
        mobile_number = getString(anything: dict[Keys.mobile_number.rawValue])
        sports_complex_id = getString(anything: dict[Keys.sports_complex_id.rawValue])
        terms_check = getString(anything: dict[Keys.terms_check.rawValue])
        title = getString(anything: dict[Keys.title.rawValue])
        user_category = getString(anything: dict[Keys.user_category.rawValue])
        para_sub_category = getString(anything: dict[Keys.para_sub_category.rawValue])
        super.init()
    }
    
    
//    /**
//     Generates description of the object in the form of a NSDictionary.
//     - returns: A Key value pair containing all valid values in the object.
//     */
//    public func dictionaryRepresentation() -> [String: Any] {
//        var dictionary: [String: Any] = [:]
//        dictionary[Keys.first_name.rawValue] = first_name
//        dictionary[Keys.last_name.rawValue] = last_name
//        dictionary[Keys.email.rawValue] = email
//        dictionary[Keys.mobileNo.rawValue] = mobileno
//        dictionary[Keys.gender.rawValue] = gender
//        dictionary[Keys.imageUrl.rawValue] = imageUrl
//        dictionary[Keys.token.rawValue] = token
//        dictionary[Keys.access_token.rawValue] = access_token
//        dictionary[Keys.date_of_birth.rawValue] = date_of_birth
//        dictionary[Keys.id.rawValue] = id
//        dictionary[Keys.device_id.rawValue] = device_id
//        return dictionary
//    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        //School / College
        user_roles_id = getString(anything: aDecoder.decodeObject(forKey: Keys.user_roles_id.rawValue))
        user_name = getString(anything: aDecoder.decodeObject(forKey: Keys.user_name.rawValue))
        upload_photo = getString(anything: aDecoder.decodeObject(forKey: Keys.upload_photo.rawValue))
        upload_logo = getString(anything: aDecoder.decodeObject(forKey: Keys.upload_logo.rawValue))
        updated_by = getString(anything: aDecoder.decodeObject(forKey: Keys.updated_by.rawValue))
        type = getString(anything: aDecoder.decodeObject(forKey: Keys.type.rawValue))
        token = getString(anything: aDecoder.decodeObject(forKey:Keys.token.rawValue))
        register_as = getString(anything: aDecoder.decodeObject(forKey:Keys.register_as.rawValue))
        reference_number = getString(anything: aDecoder.decodeObject(forKey: Keys.reference_number.rawValue))
        pincode = getString(anything: aDecoder.decodeObject(forKey: Keys.pincode.rawValue))
        name_of_principal = getString(anything: aDecoder.decodeObject(forKey: Keys.name_of_principal.rawValue))
        name = getString(anything: aDecoder.decodeObject(forKey: Keys.name.rawValue))
        ms_villages_id = getString(anything: aDecoder.decodeObject(forKey: Keys.ms_villages_id.rawValue))
        ms_talukas_id = getString(anything: aDecoder.decodeObject(forKey: Keys.ms_talukas_id.rawValue))
        ms_sports_id = getString(anything: aDecoder.decodeObject(forKey: Keys.ms_sports_id.rawValue))
        ms_districts_id = getString(anything: aDecoder.decodeObject(forKey: Keys.ms_districts_id.rawValue))
        is_mobile = getString(anything: aDecoder.decodeObject(forKey: Keys.is_mobile.rawValue))
        email = getString(anything: aDecoder.decodeObject(forKey: Keys.email.rawValue))
        establishment_date = getString(anything: aDecoder.decodeObject(forKey: Keys.establishment_date.rawValue))
        created_by = getString(anything: aDecoder.decodeObject(forKey: Keys.created_by.rawValue))
        contact_person_name = getString(anything: aDecoder.decodeObject(forKey: Keys.contact_person_name.rawValue))
        contact_number = getString(anything: aDecoder.decodeObject(forKey: Keys.contact_number.rawValue))
        contact_mobile_number = getString(anything: aDecoder.decodeObject(forKey: Keys.contact_mobile_number.rawValue))
        address = getString(anything: aDecoder.decodeObject(forKey: Keys.address.rawValue))
        principal_contact_number = getString(anything: aDecoder.decodeObject(forKey: Keys.principal_contact_number.rawValue))
        school_dias_number = getString(anything: aDecoder.decodeObject(forKey: Keys.school_dias_number.rawValue))
        id = getString(anything: aDecoder.decodeObject(forKey: Keys.id.rawValue))
        district_name = getString(anything: aDecoder.decodeObject(forKey: Keys.district_name.rawValue))
        taluka_name = getString(anything: aDecoder.decodeObject(forKey: Keys.taluka_name.rawValue))
        village_name = getString(anything: aDecoder.decodeObject(forKey: Keys.village_name.rawValue))
        
        //Player
        aadhaar_card_number = getString(anything: aDecoder.decodeObject(forKey: Keys.aadhaar_card_number.rawValue))
        achievement_form = getString(anything: aDecoder.decodeObject(forKey: Keys.achievement_form.rawValue))
        age = getString(anything: aDecoder.decodeObject(forKey: Keys.age.rawValue))
        ashthma_bronchitis = getString(anything: aDecoder.decodeObject(forKey: Keys.ashthma_bronchitis.rawValue))
        atelic_category = getString(anything: aDecoder.decodeObject(forKey: Keys.atelic_category.rawValue))
        back_neck_pain = getString(anything: aDecoder.decodeObject(forKey: Keys.back_neck_pain.rawValue))
        concussion = getString(anything: aDecoder.decodeObject(forKey: Keys.concussion.rawValue))
        date_of_birth = getString(anything: aDecoder.decodeObject(forKey: Keys.date_of_birth.rawValue))
        diabetes = getString(anything: aDecoder.decodeObject(forKey: Keys.diabetes.rawValue))
        dislocation = getString(anything: aDecoder.decodeObject(forKey: Keys.dislocation.rawValue))
        gender = getString(anything: aDecoder.decodeObject(forKey: Keys.gender.rawValue))
        first_name = getString(anything: aDecoder.decodeObject(forKey: Keys.first_name.rawValue))
        last_name = getString(anything: aDecoder.decodeObject(forKey: Keys.last_name.rawValue))
        middle_name = getString(anything: aDecoder.decodeObject(forKey: Keys.middle_name.rawValue))
        mobile_number = getString(anything: aDecoder.decodeObject(forKey: Keys.mobile_number.rawValue))
        sports_complex_id = getString(anything: aDecoder.decodeObject(forKey: Keys.sports_complex_id.rawValue))
        terms_check = getString(anything: aDecoder.decodeObject(forKey: Keys.terms_check.rawValue))
        title = getString(anything: aDecoder.decodeObject(forKey: Keys.title.rawValue))
        user_category = getString(anything: aDecoder.decodeObject(forKey: Keys.user_category.rawValue))
        para_sub_category = getString(anything: aDecoder.decodeObject(forKey: Keys.para_sub_category.rawValue))
    }

    public func encode(with aCoder: NSCoder) {
        //School / College
        aCoder.encode(user_roles_id, forKey: Keys.user_roles_id.rawValue)
        aCoder.encode(user_name, forKey: Keys.user_name.rawValue)
        aCoder.encode(upload_photo, forKey: Keys.upload_photo.rawValue)
        aCoder.encode(upload_logo, forKey: Keys.upload_logo.rawValue)
        aCoder.encode(updated_by, forKey: Keys.updated_by.rawValue)
        aCoder.encode(type, forKey: Keys.type.rawValue)
        aCoder.encode(token, forKey: Keys.token.rawValue)
        aCoder.encode(register_as, forKey: Keys.register_as.rawValue)
        aCoder.encode(reference_number, forKey: Keys.reference_number.rawValue)
        aCoder.encode(pincode, forKey: Keys.pincode.rawValue)
        aCoder.encode(name_of_principal, forKey: Keys.name_of_principal.rawValue)
        aCoder.encode(principal_contact_number, forKey: Keys.principal_contact_number.rawValue)
        aCoder.encode(name, forKey: Keys.name.rawValue)
        aCoder.encode(ms_villages_id, forKey: Keys.ms_villages_id.rawValue)
        aCoder.encode(ms_talukas_id, forKey: Keys.ms_talukas_id.rawValue)
        aCoder.encode(ms_sports_id, forKey: Keys.ms_sports_id.rawValue)
        aCoder.encode(ms_districts_id, forKey: Keys.ms_districts_id.rawValue)
        aCoder.encode(is_mobile, forKey: Keys.is_mobile.rawValue)
        aCoder.encode(id, forKey: Keys.id.rawValue)
        aCoder.encode(email, forKey: Keys.email.rawValue)
        aCoder.encode(establishment_date, forKey: Keys.establishment_date.rawValue)
        aCoder.encode(created_by, forKey: Keys.created_by.rawValue)
        aCoder.encode(contact_person_name, forKey: Keys.contact_person_name.rawValue)
        aCoder.encode(contact_number, forKey: Keys.contact_number.rawValue)
        aCoder.encode(contact_mobile_number, forKey: Keys.contact_mobile_number.rawValue)
        aCoder.encode(address, forKey: Keys.address.rawValue)
        aCoder.encode(school_dias_number, forKey: Keys.school_dias_number.rawValue)
        aCoder.encode(village_name, forKey: Keys.village_name.rawValue)
        aCoder.encode(taluka_name, forKey: Keys.taluka_name.rawValue)
        aCoder.encode(district_name, forKey: Keys.district_name.rawValue)
        
        //Player
        aCoder.encode(aadhaar_card_number, forKey: Keys.aadhaar_card_number.rawValue)
        aCoder.encode(achievement_form, forKey: Keys.achievement_form.rawValue)
        aCoder.encode(age, forKey: Keys.age.rawValue)
        aCoder.encode(ashthma_bronchitis, forKey: Keys.ashthma_bronchitis.rawValue)
        aCoder.encode(atelic_category, forKey: Keys.atelic_category.rawValue)
        aCoder.encode(back_neck_pain, forKey: Keys.back_neck_pain.rawValue)
        aCoder.encode(concussion, forKey: Keys.concussion.rawValue)
        aCoder.encode(date_of_birth, forKey: Keys.date_of_birth.rawValue)
        aCoder.encode(diabetes, forKey: Keys.diabetes.rawValue)
        aCoder.encode(dislocation, forKey: Keys.dislocation.rawValue)
        aCoder.encode(first_name, forKey: Keys.first_name.rawValue)
        aCoder.encode(gender, forKey: Keys.gender.rawValue)
        aCoder.encode(last_name, forKey: Keys.last_name.rawValue)
        aCoder.encode(middle_name, forKey: Keys.middle_name.rawValue)
        aCoder.encode(mobile_number, forKey: Keys.mobile_number.rawValue)
        aCoder.encode(sports_complex_id, forKey: Keys.sports_complex_id.rawValue)
        aCoder.encode(terms_check, forKey: Keys.terms_check.rawValue)
        aCoder.encode(title, forKey: Keys.title.rawValue)
        aCoder.encode(user_category, forKey: Keys.user_category.rawValue)
        aCoder.encode(para_sub_category, forKey: Keys.para_sub_category.rawValue)
    }

    func setUserModel() {
        var encodedData: Data?
        if #available(iOS 12, *) {
            do {
                encodedData = try NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
            } catch let error {
                DebugLog("Error archiving User Model - \(error.localizedDescription)")
            }
        } else {
            encodedData = NSKeyedArchiver.archivedData(withRootObject: self)
        }
        UserPreferences.set(value: encodedData, forKey: UserPreferencesKeys.UserInfo.userDetail)
    }
    
    class func remove() {
        UserPreferences.remove(forKey: UserPreferencesKeys.UserInfo.userDetail)
    }
}

