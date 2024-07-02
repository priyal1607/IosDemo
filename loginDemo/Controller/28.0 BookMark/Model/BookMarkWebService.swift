//
//  BookMarkWebService.swift
//  loginDemo
//
//  Created by Priyal on 18/10/23.
//

import Foundation
class BookMarkWebService: NSObject {
    var id : Int = 51
    
//    func getBookMarkData(block:@escaping (([book_mark_model]) -> Swift.Void)) {
//        if (WShandler.shared.CheckInternetConnectivity()) {
//            
//           
//            WShandler.shared.postWebRequest(apiURLType: .other("https://mea.gov.in/mea_api/MEAMobileServicev2/publication_listing?publicationid=50&startdt=&enddt=&searchtext=&index=0&pagesize=10&languageid=1&Authentication=8500a2e7d1a9083afbba71cf5afb4fee&DeviceID=00000000-3399-631a-ffff-ffffef05ac4a"), param: [:], block: { json, flag in
//                var responseModel = [book_mark_model]()
//                print(json)
//                if (flag == 200) {
//                    print(json["lstPublication"])
//                    responseModel = (json["lstPublication"] as? [DICTIONARY] ?? []).map({ book_mark_model(fromDictionary: $0)})
//                    
//                    
//                } else {
//                    if getString(anything: json[CommonAPIConstant.key_message]).isStringEmpty {
//                        Global.shared.showBanner(message: .LanguageLocalisation.something_went_wrong_try_some_time)
//                    } else {
//                        Global.shared.showBanner(message: getString(anything: json[CommonAPIConstant.key_message]))
//                    }
//                }
//                block(responseModel)
//            })
//        }  else {
//            block([])
//            Global.shared.showBanner(message: .LanguageLocalisation.msg_Internet_Issue)
//        }
//    }
    
    
    func getMediaCenter(block:@escaping (([book_mark_model]) -> Swift.Void)) {
                if (WShandler.shared.CheckInternetConnectivity()) {
        
        
                   WShandler.shared.postWebRequest(apiURLType: .other("https://mea.gov.in/mea_api/MEAMobileServicev2/publication_listing?Authentication=8500a2e7d1a9083afbba71cf5afb4fee&DeviceID=E229D7A3-2F0C-4583-ACDB-1BE4302987A3&enddt=&index=0&languageid=1&pagesize=10&publicationid=\(id)&searchtext=&startdt="), param: [:], block: { json, flag in
                        var responseModel = [book_mark_model]()
                        print(json)
                        if (flag == 200) {
                            print(json["lstPublication"])
                            responseModel = (json["lstPublication"] as? [DICTIONARY] ?? []).map({ book_mark_model(fromDictionary: $0)})
        
                        } else {
                            if getString(anything: json[CommonAPIConstant.key_message]).isStringEmpty {
                                Global.shared.showBanner(message: .LanguageLocalisation.something_went_wrong_try_some_time)
                            } else {
                                Global.shared.showBanner(message: getString(anything: json[CommonAPIConstant.key_message]))
                            }
                        }
                        block(responseModel)
                    })
                }  else {
                    block([])
                    Global.shared.showBanner(message: .LanguageLocalisation.msg_Internet_Issue)
                }
            }
            
    
    
}
