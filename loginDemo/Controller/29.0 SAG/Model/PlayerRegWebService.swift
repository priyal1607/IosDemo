//
//  PlayerRegWebService.swift
//  loginDemo
//
//  Created by Priyal on 22/12/23.
//

import Foundation
class PlayerRegWebService : NSObject {
    typealias Dictionary = [String : Any]
    var playerRegPersonalInfoModel : PlayerPersonalInfoModel!
    var playerAddressInfoModel : PlayerAddressInfoModel!
    var playerLoginInfoModel : PlayerLoginInfoModel!
    var documentmodel:DocumentModel!
    
    private func playerRegInfo() -> Dictionary {
        return [
            "personalInfo": playerRegPersonalInfoModel.dicData().dicToJsonStr(),
            "addressInfo" : playerAddressInfoModel.dicData().dicToJsonStr(),
            "logininfo" : playerLoginInfoModel.dicData().dicToJsonStr()]
    }
    fileprivate var savePlayerRegURL: String {
        return "http://sagportal.php-staging.com/apiv2/player-registration"
    }
    
    func registerPlayer( block: @escaping (( _ res : Dictionary, _ strMsg : String, _ isSuccess : Bool) -> Swift.Void)) {
        
//        var param = self.playerRegInfo()
        var param = Dictionary()
        
        let dict = WShandler.commonDict1()
        param = param.merging(playerRegPersonalInfoModel.dicData()) { (current, _) in current }
        param = param.merging(playerAddressInfoModel.dicData()) { (current, _) in current }
        param = param.merging(playerLoginInfoModel.dicData()) { (current, _) in current }

        for key in dict.keys {
            param[key] = dict[key]
        }
        
        if (WShandler.shared.CheckInternetConnectivity()) {
            
            print("uploadDocuments strApi - ", savePlayerRegURL)
            print("uploadDocuments param - ", param as Any)

            WShandler.shared.multipartWebRequest1(urlStr: savePlayerRegURL, dictParams: param, documents: [documentmodel]) { json, flag in
                
                print("uploadDocuments json - ", json)
                
                if (flag == 200) {
                    if getInteger(anything: json[CommonAPIConstant.key_resultFlag]) == 2 || getInteger(anything: json[CommonAPIConstant.key_resultFlag]) == 0  {
                        Global.shared.showBanner(message: getString(anything: json[CommonAPIConstant.key_message]))
                        Global.shared.tokenExpired()
                        block(json, getString(anything: json[CommonAPIConstant.key_message]), false)
                        
                    } else {
                        if (getBoolean(anything: json[CommonAPIConstant.key_resultFlag])) {
                            block(json, getString(anything: json[CommonAPIConstant.key_message]), true)
                            
                        } else {
                            block(json, getString(anything: json[CommonAPIConstant.key_errormsg]), false)
                            Global.shared.showBanner(message: getString(anything: json[CommonAPIConstant.key_errormsg]))
                        }
                    }
                    
                } else {
                    block(json, getString(anything: json[CommonAPIConstant.key_errormsg]), false)
                    Global.shared.showBanner(message: getString(anything: json[CommonAPIConstant.key_errormsg]))
                }
            }

        }  else {
            block([:], "", false)
            Global.shared.showBanner(message: "Internet Issue")
        }
    }
}


