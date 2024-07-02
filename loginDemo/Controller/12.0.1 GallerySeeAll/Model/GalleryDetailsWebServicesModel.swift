//
//  GalleryDetailsWebServicesModle.swift
//  KhelSathi
//
//  Created by Gunjan on 28/06/23.
//

import UIKit

class GalleryDetailsWebServicesModel: NSObject {
    
    var limit = "10"
    var model = ""
    var page = "1"
    var catID = ""
    
    func getGalleryDetails(block:@escaping (([GalleryDetailsModel]?, Int,_ fileUrl:String) -> Swift.Void)) {
        if (WShandler.shared.CheckInternetConnectivity()) {
            
            let catId_dict = [CommonAPIConstant.key_category_id: catID]
            
            let dict = [CommonAPIConstant.key_languageCode: UserPreferences.string(forKey: UserPreferencesKeys.General.languageCode),CommonAPIConstant.key_limit:limit, CommonAPIConstant.key_model: model, CommonAPIConstant.key_page: page,CommonAPIConstant.filters:catId_dict] as DICTIONARY
            print(dict)
            WShandler.shared.postWebRequest(apiURLType: .pathType(.getList), param: dict, block: { json, flag in
                var count = 0
                var fileURL = ""
                var responseModel = [GalleryDetailsModel]()
                print(json)
                if (flag == 200) {
                    count = getInteger(anything: json[CommonAPIConstant.key_totalcount])
                    fileURL = getString(anything: json[CommonAPIConstant.key_fileurl])
                    responseModel = (json[CommonAPIConstant.key_result] as? [DICTIONARY] ?? []).map({ GalleryDetailsModel(dict: $0) })
               
                    
                } else {
                    if getString(anything: json[CommonAPIConstant.key_message]).isStringEmpty {
                        Global.shared.showBanner(message: .LanguageLocalisation.something_went_wrong_try_some_time)
                    } else {
                        Global.shared.showBanner(message: getString(anything: json[CommonAPIConstant.key_message]))
                    }
                }
                block(responseModel, count,fileURL)
            })
        }  else {
            block([], 0,"")
            Global.shared.showBanner(message: .LanguageLocalisation.msg_Internet_Issue)
        }
    }
}
