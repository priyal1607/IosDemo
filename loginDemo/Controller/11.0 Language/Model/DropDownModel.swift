//
//  DropDownModel.swift
//  Vidyanjali
//
//  Created by Nimitt Nemade on 12/11/20.
//  Copyright © 2020 Vikram Jagad. All rights reserved.
//

import UIKit

class DropDownModel: NSObject {
    let title: String
    let id: String
    var isSelected: Bool
    
    enum Keys: String {
        case title = "title"
        case id = "id"
        case isSelected = "isSelected"
        case interestId = "InterestID"
        case interestName = "InterestName"
        case classId = "ClassId"
        case className = "ClassName"
        case stateId = "StateID"
        case stateName = "StateName"
        case districtId = "DistrictID"
        case districtName = "DistrictName"
        case locationId = "LocationID"
        case place_id = "place_id"
        case locationName = "LocationName"
        case ID = "ID"
        case name = "Name"
        case assistCode = "assistCode"
        case assistName = "assistName"
    }
    
    init(dict: [String : Any]) {
        title = getString(anything: dict[Keys.title.rawValue])
        id = getString(anything: dict[Keys.id.rawValue])
        isSelected = false
    }
    
    init(dictSubcategory: [String : Any]) {
        title = getString(anything: dictSubcategory[Keys.name.rawValue])
        id = getString(anything: dictSubcategory[Keys.ID.rawValue])
        isSelected = false
    }
    
    init(dictMaterialList: [String : Any]) {
        title = getString(anything: dictMaterialList[Keys.name.rawValue])
        id = getString(anything: dictMaterialList[Keys.ID.rawValue])
        isSelected = false
    }
    
    init(dictContributionFilterStatus: [String : Any]) {
        title = getString(anything: dictContributionFilterStatus[Keys.title.rawValue])
        id = getString(anything: dictContributionFilterStatus[Keys.id.rawValue])
        isSelected = false
    }
    
    init(dictGender: [String : Any]) {
        title = getString(anything: dictGender[Keys.title.rawValue])
        id = getString(anything: dictGender[Keys.id.rawValue])
        isSelected = false
    }

    init(dictActivityCategory: [String : Any]) {
        title = getString(anything: dictActivityCategory[Keys.interestName.rawValue])
        id = getString(anything: dictActivityCategory[Keys.interestId.rawValue])
        isSelected = false
    }
    
    init(dictActivityName: [String : Any]) {
        title = getString(anything: dictActivityName[Keys.interestName.rawValue])
        id = getString(anything: dictActivityName[Keys.interestId.rawValue])
        isSelected = false
    }
    
    init(dictActivityStatus: [String : Any]) {
        title = getString(anything: dictActivityStatus[Keys.title.rawValue])
        id = getString(anything: dictActivityStatus[Keys.id.rawValue])
        isSelected = false
    }
    
    init(dictClassGrade: [String : Any]) {
        title = getString(anything: dictClassGrade[Keys.className.rawValue])
        id = getString(anything: dictClassGrade[Keys.classId.rawValue])
        isSelected = false
    }
    
    init(dictRequiredSpecializaion: [String : Any]) {
        title = getString(anything: dictRequiredSpecializaion[Keys.interestName.rawValue])
        id = getString(anything: dictRequiredSpecializaion[Keys.interestId.rawValue])
        isSelected = false
    }
    
    init(dictQualification: [String : Any]) {
        title = getString(anything: dictQualification[Keys.name.rawValue])
        id = getString(anything: dictQualification[Keys.ID.rawValue])
        isSelected = false
    }
    
    init(dictEmployeeStatus: [String : Any]) {
        title = getString(anything: dictEmployeeStatus[Keys.name.rawValue])
        id = getString(anything: dictEmployeeStatus[Keys.ID.rawValue])
        isSelected = false
    }
    
    init(dictState: [String : Any]) {
        title = getString(anything: dictState[Keys.stateName.rawValue])
        id = getString(anything: dictState[Keys.stateId.rawValue])
        isSelected = false
    }
    
    init(dictDistrict: [String : Any]) {
        title = getString(anything: dictDistrict[Keys.districtName.rawValue])
        id = getString(anything: dictDistrict[Keys.districtId.rawValue])
        isSelected = false
    }
    
    init(dictLocation: [String : Any]) {
        title = getString(anything: dictLocation[Keys.locationName.rawValue])
        id = getString(anything: dictLocation[Keys.locationId.rawValue])
        isSelected = false
    }
    
    init(dictFeedback dict: [String:Any]) {
        title = getString(anything: dict[Keys.title.rawValue])
        id = getString(anything: dict[Keys.place_id.rawValue])
        isSelected = false
    }
    
    init(dictSearchList dict: [String:Any]) {
        title = getString(anything: dict[Keys.assistName.rawValue])
        id = getString(anything: dict[Keys.assistCode.rawValue])
        isSelected = false
    }
    
    init(dictPaymentList dict: [String:Any]) {
        title = getString(anything: dict[Keys.assistName.rawValue])
        id = getString(anything: dict[Keys.assistCode.rawValue])
        isSelected = false
    }
    init(selectTitle dict: [String:Any]) {
        title = getString(anything: dict[Keys.assistName.rawValue])
        id = getString(anything: dict[Keys.assistCode.rawValue])
        isSelected = false
    }
    
}

class DropDownResponseModel: NSObject {
    let resultFlag: Bool
    let message: String
    let list: [DropDownModel]
    
    enum Keys: String {
        case list = "list"
        case contributionmaterialList = "ContributionList"
        case contributionFilterstatus = "ContributionStatus"


        case activityCategory = "activityCategoryList"
        case activityName = "InterestAreasList"
        case activityStatus = "ActivityStatus"
        case classGrade = "class"
        case requiredSpecializaion = "RequiredSpecializaionAreasList"

        case gender = "gender"
        case qualification = "QualificationList"
        case emplyeeStatus = "EmploymentList"
        case areaofInterest = "areaofInterest"
        case getState = "StateList"
        case getDistrict = "DistrictList"
        case getLocation = "LocationList"
        case blockList = "BlockList"
        case typeList = "TypeList"
        case uploadDocument = "uploadDocument"
        case types = "types"
        case message
    }
    
    init(dict: [String : Any]) {
        resultFlag = getBoolean(anything: dict[CommonAPIConstant.key_resultFlag])
        message = getString(anything: dict[CommonAPIConstant.key_message])
        if let arr = dict[Keys.list.rawValue] as? [[String : Any]] {
            list = arr.map({ DropDownModel(dict: $0) })
        } else {
            list = []
        }
        super.init()
    }
    

    
    init(dictSubcategory: [String : Any]) {
        resultFlag = getBoolean(anything: dictSubcategory[CommonAPIConstant.key_resultFlag])
        message = getString(anything: dictSubcategory[Keys.message.rawValue])
        if let arr = dictSubcategory[Keys.activityName.rawValue] as? [[String : Any]] {
            list = arr.map({ DropDownModel(dictSubcategory: $0) })
        } else {
            list = []
        }
        super.init()
    }
    
    init(dictMaterialList: [String : Any]) {
        resultFlag = getBoolean(anything: dictMaterialList[CommonAPIConstant.key_resultFlag])
        message = getString(anything: dictMaterialList[Keys.message.rawValue])
        if let arr = dictMaterialList[Keys.contributionmaterialList.rawValue] as? [[String : Any]] {
            list = arr.map({ DropDownModel(dictMaterialList: $0) })
        } else {
            list = []
        }
        super.init()
    }
    
    init(dictContributionFilterStatus: [String : Any]) {
        resultFlag = getBoolean(anything: dictContributionFilterStatus[CommonAPIConstant.key_resultFlag])
        message = getString(anything: dictContributionFilterStatus[CommonAPIConstant.key_message])
        if let arr = dictContributionFilterStatus[Keys.contributionFilterstatus.rawValue] as? [[String : Any]] {
            list = arr.map({ DropDownModel(dictContributionFilterStatus: $0) })
        } else {
            list = []
        }
        super.init()
    }
    
    init(dictGender: [String : Any]) {
        resultFlag = getBoolean(anything: dictGender[CommonAPIConstant.key_resultFlag])
        message = getString(anything: dictGender[CommonAPIConstant.key_message])
        if let arr = dictGender[Keys.gender.rawValue] as? [[String : Any]] {
            list = arr.map({ DropDownModel(dictGender: $0) })
        } else {
            list = []
        }
        super.init()
    }

    init(dictActivityCategory: [String : Any]) {
        resultFlag = getBoolean(anything: dictActivityCategory[CommonAPIConstant.key_resultFlag])
        message = getString(anything: dictActivityCategory[Keys.message.rawValue])
        if let arr = dictActivityCategory[Keys.activityCategory.rawValue] as? [[String : Any]] {
            list = arr.map({ DropDownModel(dictActivityCategory: $0) })
        } else {
            list = []
        }
        super.init()
    }
    
    init(dictActivityName: [String : Any]) {
        resultFlag = getBoolean(anything: dictActivityName[CommonAPIConstant.key_resultFlag])
        message = getString(anything: dictActivityName[Keys.message.rawValue])
        if let arr = dictActivityName[Keys.activityName.rawValue] as? [[String : Any]] {
            list = arr.map({ DropDownModel(dictActivityName: $0) })
        } else {
            list = []
        }
        super.init()
    }
    
    init(dictActivityStatus: [String : Any]) {
        resultFlag = getBoolean(anything: dictActivityStatus[CommonAPIConstant.key_resultFlag])
        message = getString(anything: dictActivityStatus[Keys.message.rawValue])
        if let arr = dictActivityStatus[Keys.activityStatus.rawValue] as? [[String : Any]] {
            list = arr.map({ DropDownModel(dictActivityStatus: $0) })
        } else {
            list = []
        }
        super.init()
    }
    
    init(dictClassGrade: [String : Any]) {
        resultFlag = getBoolean(anything: dictClassGrade[CommonAPIConstant.key_resultFlag])
        message = getString(anything: dictClassGrade[Keys.message.rawValue])
        if let arr = dictClassGrade[Keys.classGrade.rawValue] as? [[String : Any]] {
            list = arr.map({ DropDownModel(dictClassGrade: $0) })
        } else {
            list = []
        }
        super.init()
    }
    
    init(dictRequiredSpecializaion: [String : Any]) {
        resultFlag = getBoolean(anything: dictRequiredSpecializaion[CommonAPIConstant.key_resultFlag])
        message = getString(anything: dictRequiredSpecializaion[Keys.message.rawValue])
        if let arr = dictRequiredSpecializaion[Keys.requiredSpecializaion.rawValue] as? [[String : Any]] {
            list = arr.map({ DropDownModel(dictRequiredSpecializaion: $0) })
        } else {
            list = []
        }
        super.init()
    }
    
    init(dictQualification: [String : Any]) {
        resultFlag = getBoolean(anything: dictQualification[CommonAPIConstant.key_resultFlag])
        message = getString(anything: dictQualification[Keys.message.rawValue])
        if let arr = dictQualification[Keys.qualification.rawValue] as? [[String:Any]] {
            list = arr.map({DropDownModel(dictQualification: $0)})
        } else {
            list = []
        }
    }
    
    init(dictEmployeeStatus:[String:Any]) {
        resultFlag = getBoolean(anything: dictEmployeeStatus[CommonAPIConstant.key_resultFlag])
        message = getString(anything: dictEmployeeStatus[Keys.message.rawValue])
        if let arr = dictEmployeeStatus[Keys.emplyeeStatus.rawValue] as? [[String:Any]] {
            list = arr.map({DropDownModel(dictEmployeeStatus: $0)})
        } else {
            list = []
        }
    }
    
    init(dictState:[String:Any]) {
        resultFlag = getBoolean(anything: dictState[CommonAPIConstant.key_resultFlag])
        message = getString(anything: dictState[Keys.message.rawValue])
        if let arr = dictState[Keys.getState.rawValue] as? [[String:Any]] {
            list = arr.map({DropDownModel(dictState: $0)})
        } else {
            list = []
        }
    }
    
    init(dictDistrict:[String:Any]) {
        resultFlag = getBoolean(anything: dictDistrict[CommonAPIConstant.key_resultFlag])
        message = getString(anything: dictDistrict[Keys.message.rawValue])
        if let arr = dictDistrict[Keys.getDistrict.rawValue] as? [[String:Any]] {
            list = arr.map({DropDownModel(dictDistrict: $0)})
        } else {
            list = []
        }
    }
    
    init(dictLocation: [String : Any]) {
        resultFlag = getBoolean(anything: dictLocation[CommonAPIConstant.key_resultFlag])
        message = getString(anything: dictLocation[Keys.message.rawValue])
        if let arr = dictLocation[Keys.getLocation.rawValue] as? [[String:Any]] {
            list = arr.map({DropDownModel(dictLocation: $0)})
        } else {
            list = []
        }
    }
    
    
    init(FeedbackdictTypes dict: [String : Any]) {
        resultFlag = getBoolean(anything: dict[CommonAPIConstant.key_resultFlag])
        message = getString(anything: dict[Keys.message.rawValue])
        if let arr = dict[Keys.types.rawValue] as? [[String:Any]] {
            list = arr.map({DropDownModel(dictFeedback: $0)})
        } else {
            list = []
        }
        super.init()
    }
    init(selectTitleType dict: [String : Any]) {
        resultFlag = getBoolean(anything: dict[CommonAPIConstant.key_resultFlag])
        message = getString(anything: dict[Keys.message.rawValue])
        if let arr = dict[Keys.types.rawValue] as? [[String:Any]] {
            list = arr.map({DropDownModel(selectTitle: $0)})
        } else {
            list = []
        }
        super.init()
    }
}
