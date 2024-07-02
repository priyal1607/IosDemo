//
//  DashboardModel.swift
//  loginDemo
//
//  Created by Chelsi on 19/04/23.
//

import Foundation

struct Section {
    let letter : String
    let names : [DashboardModel]
}

class DashboardModel : NSObject  {
    let isselected : Bool
    let name:String
    let dob:String
    let dept:String
    let id:String
    let gender:String
    let sem1:String
    let sem2:String
    let sem3:String
    let sem4:String
    let sem5:String
    let sem6:String
    let address:String
    let phone:String
    let age:String
    let student_id:String
    let sports_name:String
    let image:String
    var docs : [DetailsDoc]!
    
    enum keys: String {
        case isselected
        case name
        case dob
        case dept
        case id
        case gender
        case sem1 = "sem_one_grade"
        case sem2 = "sem_two_grade"
        case sem3 = "sem_three_grade"
        case sem4 = "sem_four_grade"
        case sem5 = "sem_five_grade"
        case sem6 = "sem_six_grade"
        case address
        case phone = "phone_number"
        case age
        case student_id
        case sports_name
        case image
        case docs
    }
    
    init(dict : [String:Any]){
        docs = [DetailsDoc]()
        if let docsArray = dict["docs"] as? [[String:Any]]{
            for dic in docsArray{
                let value = DetailsDoc(fromDictionary: dic)
                docs.append(value)
            }
        }
        self.isselected = dict[keys.isselected.rawValue] as? Bool ?? false
        self.name = dict[keys.name.rawValue] as? String ?? ""
        self.dob = dict[keys.dob.rawValue] as? String ?? ""
        self.dept = dict[keys.dept.rawValue] as? String ?? ""
        self.id = dict[keys.id.rawValue] as? String ?? ""
        self.gender = dict[keys.gender.rawValue] as? String ?? ""
        self.sem1 = dict[keys.sem1.rawValue] as? String ?? ""
        self.sem2 = dict[keys.sem2.rawValue] as? String ?? ""
        self.sem3 = dict[keys.sem3.rawValue] as? String ?? ""
        self.sem4 = dict[keys.sem4.rawValue] as? String ?? ""
        self.sem5 = dict[keys.sem5.rawValue] as? String ?? ""
        self.sem6 = dict[keys.sem6.rawValue] as? String ?? ""
        self.address = dict[keys.address.rawValue] as? String ?? ""
        self.phone = dict[keys.phone.rawValue] as? String ?? ""
        self.age = dict[keys.age.rawValue] as? String ?? ""
        self.student_id = dict[keys.student_id.rawValue] as? String ?? ""
        self.sports_name = dict[keys.sports_name.rawValue] as? String ?? ""
        self.image = dict[keys.image.rawValue] as? String ?? ""
    }

}
