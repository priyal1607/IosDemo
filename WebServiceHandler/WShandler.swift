//
//  WShandler.swift
//  MEAIndia
//
//  Created by Pradip on 18/07/22.
//



import UIKit
import Alamofire

typealias WSBlock = (_ json: DICTIONARY, _ flag: Int) -> ()

//MARK:- Definition
class WShandler: NSObject {
    //MARK:- Blocks Definitiolet
   
    var successBlock: (String, AFDataResponse<Any>, WSBlock) -> Void
    var successBlock1: (Bool, String, String, AFDataResponse<Any>, WSBlock) -> Void
    var errorBlock: (String, NSError, WSBlock) -> Void
    
    //MARK:- Initilizer WShandler
    override init() {
        successBlock1 = { (decryption, uuidStr, relativePath, respObj, block) -> Void in
            
            var json = respObj.value as? [String : Any] ?? [:]
            if decryption {
                json = json.decryptDic(uuid: uuidStr)
            }
            
            if respObj.response?.statusCode == 200 {
               
                if respObj.value as? [String : Any] == nil
                {
                    var dict:[String:Any] = [:]
                    dict[CommonAPIConstant.key_list] = json
                    //block([CommonAPIConstant.key_list:respObj.value] as? [String : Any] ?? [:], (respObj.response?.statusCode)!)
                    block(dict, (respObj.response?.statusCode)!)
                }
                else{
                    block(json, (respObj.response?.statusCode)!)
                }
                
            } else if respObj.response?.statusCode == 401 {
                block(json, 200)
                
            } else if ((respObj.response?.statusCode == 404) && !(getString(anything: (respObj.value as? [String : Any])?[CommonAPIConstant.key_message]).isEmptyString)) {
                block(json, 200)
                
            } else if ((respObj.response?.statusCode == 201) && !(getString(anything: (respObj.value as? [String : Any])?[CommonAPIConstant.key_message]).isEmptyString)) {
                block(json, 200)
                
            } else if (respObj.response?.statusCode == 500) {
                block(json, 200)
                
            } else if (respObj.response?.statusCode == 404) {
                block(json, 200)
                
            } else {
                block(json, (respObj.response?.statusCode) ?? 0)
            }
        }
        successBlock = { (relativePath, respObj, block) -> Void in
//            let blankJson : Any = [:] as [String:Any]
            let responseValue = respObj.value as? DICTIONARY ?? [:]
            
            if respObj.response?.statusCode == 200 {
                block(responseValue, respObj.response!.statusCode)
            } else if respObj.response?.statusCode == 401 {
                block(responseValue, 200)
            } else if (respObj.response?.statusCode == 404) {
                block(responseValue, 200)
            } else if (respObj.response?.statusCode == 201) {
                block(responseValue, 200)
            } else if (respObj.response?.statusCode == 500) {
                block(responseValue, 200)
            } else if (respObj.response?.statusCode == 404) {
                block(responseValue, 200)
            } else {
                block(responseValue, (respObj.response?.statusCode) ?? 0)
            }
        }
        errorBlock = { (relativePath, error, block) -> Void in
            if let data = error.userInfo["com.alamofire.serialization.response.error.data"] as? Data {
                let errorDict = (try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers))
//                let blankJson : Any = [:] as [String:Any]
                if errorDict != nil {
                    
                    debugPrint("Error(\(relativePath)): \(errorDict ?? "")")
                    block(errorDict as? DICTIONARY ?? [:], error.code)
                    
                } else {
                    let msg = String.LanguageLocalisation.something_went_wrong_try_some_time
                    block(["errormsg" : msg], error.code)
                    debugPrint(msg)
                }
            } else if error.code == -1009 { // happenes when no internet
                debugPrint("Error Object: \(error)")
                block(["errormsg" : String.LanguageLocalisation.connection_error], error.code)
                return
            } else if error.code == -1003  { // happenes when slow internet or slow server
                block(["errormsg": String.LanguageLocalisation.internet_Issue as AnyObject], error.code)
                return
            } else if error.code == -1001  { // happenes when slow internet or slow server
                debugPrint("Error Object: \(error)")
                block(["errormsg": String.LanguageLocalisation.connection_timed_out], error.code)
                return
            } else {
                block(["errormsg" : String.LanguageLocalisation.something_went_wrong_try_some_time], error.code)
            }
        }
        super.init()
    }
    
    static let shared = WShandler()
}

//jignesh new code added.
//MARK:- Post Requests
extension WShandler {
    
    //MARK:- Post Request With URL
    func postWebRequest(apiURLType: API_URL, param: [String : Any]?, block: @escaping WSBlock) {
        /*var header: HTTPHeaders = ["Content-Type" : "application/json"]
        if ((UserModel.signedIn) && !(UserModel.currentUser.token.isEmptyString)) {
            header["Authorization"] = "Bearer \(UserModel.currentUser.token)"
        }*/
        
        let urlStr = apiURLType.fullURLString
        
        AF.request(urlStr, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil,requestModifier: { (request) in
            request.timeoutInterval = 120
        }).responseJSON { (response) in
//            debugPrint("Response - \(WShandler.JSONStringify(value: response.result.value, prettyPrinted: true))")
            self.apiResponsePrettyPrintedPrint(respObj: response)
            switch (response.result) {
            case .success(_):
                self.successBlock(urlStr, response, block)
            case .failure(let error):
                self.errorBlock(urlStr, error as NSError, block)
            }
        }
    }
    
    func postWebRequestWithHeaders(apiURLType: API_URL, param: [String : Any]?, block: @escaping WSBlock) {
        var header: HTTPHeaders = []
        header["Authorization"] = "Bearer \(UserPreferences.string(forKey: UserPreferencesKeys.UserInfo.token))"
        
        let urlStr = apiURLType.fullURLString
        
        AF.request(urlStr, method: .post, parameters: param, encoding: JSONEncoding.default, headers: header,requestModifier: { (request) in
            request.timeoutInterval = 120
        }).responseJSON { (response) in
//            debugPrint("Response - \(WShandler.JSONStringify(value: response.result.value, prettyPrinted: true))")
            self.apiResponsePrettyPrintedPrint(respObj: response)
            switch (response.result) {
            case .success(_):
                self.successBlock(urlStr, response, block)
            case .failure(let error):
                self.errorBlock(urlStr, error as NSError, block)
            }
        }
    }
    
    private func query(_ parameters: [String: Any]) -> String {
        var components: [(String, String)] = []

        for key in parameters.keys.sorted(by: <) {
            let value = parameters[key]!
            components += URLEncoding.queryString.queryComponents(fromKey: key, value: value)
        }
        return components.map { "\($0)=\($1)" }.joined(separator: "&")
    }
    
    func postURLQueyWebRequest(apiURLType: API_URL, queryParam: [String : Any]?, param: [String : Any]?, block: @escaping WSBlock) {
        /*var header: HTTPHeaders = ["Content-Type" : "application/json"]
        if ((UserModel.signedIn) && !(UserModel.currentUser.token.isEmptyString)) {
            header["Authorization"] = "Bearer \(UserModel.currentUser.token)"
        }*/
        
        
        let queryString = query(queryParam ?? [:])
        
        let urlStr = apiURLType.fullURLString + (queryString.isEmpty ? "" : ("?" + queryString))
        
        AF.request(urlStr, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil,requestModifier: { (request) in
            request.timeoutInterval = 60
        }).responseJSON { (response) in
//            debugPrint("Response - \(WShandler.JSONStringify(value: response.result.value, prettyPrinted: true))")
            self.apiResponsePrettyPrintedPrint(respObj: response)
            switch (response.result) {
            case .success(_):
                self.successBlock(urlStr, response, block)
            case .failure(let error):
                self.errorBlock(urlStr, error as NSError, block)
            }
        }
    }
    
    //MARK:- Get Request With URL
    func getWebRequest(apiURLType: API_URL, param: [String : Any]?, block: @escaping WSBlock) {
        /*var header: HTTPHeaders = [:]
        if ((UserModel.signedIn) && !(UserModel.currentUser.token.isEmptyString)) {
            header["Authorization"] = "Bearer \(UserModel.currentUser.token)"
        }*/
        
        let urlStr = apiURLType.fullURLString
        
        AF.request(urlStr, method: .get, parameters: param, encoding: NEWURLEncoding.queryString, headers: nil).responseJSON { (response) in
//            debugPrint("Response - \(WShandler.JSONStringify(value: response.result.value, prettyPrinted: true))")
            self.apiResponsePrettyPrintedPrint(respObj: response)
            switch(response.result) {
            case .success(_):
                self.successBlock(urlStr, response, block)
            case .failure(let error):
                self.errorBlock(urlStr, error as NSError, block)
            }
        }
    }
    func getWebRequest1(withEncryption : Bool = true, urlStr: String, param: [String : Any]?, block: @escaping WSBlock) {
        var url = urlStr
        
        let uuid = UUID().uuidString
        var paramEncr = param
        if withEncryption {
            paramEncr = param?.encryptDicWithEncoded(uuid: uuid)
        }
        
        if let param1 = paramEncr, param1.keys.count > 0 {
            url += "?\(param1.queryString)"
        }
        /*var header: HTTPHeaders = [:]
        if ((UserModel.signedIn) && !(UserModel.currentUser.token.isEmptyString)) {
            header["Authorization"] = "Bearer \(UserModel.currentUser.token)"
        }*/
        
        AF.request(url, method: .get, parameters:nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            //DebugLog("Response - \(WShandler.JSONStringify(value: response.result.value, prettyPrinted: true))")
            //self.apiResponsePrettyPrintedPrint(respObj: response)
            switch(response.result) {
            case .success(_):
                self.successBlock1(withEncryption, uuid, urlStr, response, block)
            case .failure(let error):
                self.errorBlock(urlStr, error as NSError, block)
            }
        }
    }
    //MARK:- Multipart Request
    func multipartWebRequest(apiURLType: API_URL, dictParams: [String : Any]?, documents: [DocumentModel]?, block: @escaping WSBlock) {
        /*var header: HTTPHeaders = [:]
        if ((UserModel.signedIn) && !(UserModel.currentUser.token.isEmptyString)) {
            header["Authorization"] = "Bearer \(UserModel.currentUser.token)"
        }*/
        
        let urlStr = apiURLType.fullURLString
        
        AF.upload(multipartFormData: { (multipartFormData) in
            if let params = dictParams {
                for (key, value) in params {
                    if value is [[String : Any]] {
                        multipartFormData.append(self.JSONStringify(value: value).data(using: .utf8)!, withName: key)
                    } else if value is [String : Any] {
                        multipartFormData.append(self.JSONStringify(value: value).data(using: .utf8)!, withName: key)
                    } else {
                        multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                    }
                }
            }
            if let documents = documents {
                for document in documents {
                    var data: Data?
                    if let url = document.document as? URL {
                        data = try? Data(contentsOf: url)
                        print("------- data document \(document.key) -------- ", data?.count ?? 0)
                    } else if let url = document.url {
                        data = try? Data(contentsOf: url)
                        print("------- data url \(document.key) -------- ", data?.count ?? 0)
                    } else if let image = document.document as? UIImage {
                        if (document.type.caseInsensitiveCompare(ImageType.png.rawValue) == .orderedSame) {
                            data = image.pngData()
                        } else {
                            data = image.jpegData(compressionQuality: 1.0)
                        }
                    }
                    if let data = data {
                        multipartFormData.append(data, withName: document.key, fileName: document.title + "." + document.type, mimeType: document.mimeType.lowercased())
                    }
                }
            }
        }, to: urlStr, method: .post, headers: nil, requestModifier: { request in
            request.timeoutInterval = 120
        }).uploadProgress { (progress) in
            debugPrint(progress.fractionCompleted)
//            uploadProgress?(progress.fractionCompleted)
        }.responseJSON { (response) in
            
            self.apiResponsePrettyPrintedPrint(respObj: response, multipartDataRequest: (dictJson: dictParams, uploadDict: documents))
            
            switch(response.result) {
            case .success(_):
                self.successBlock(urlStr, response, block)
            case .failure(let error):
                self.errorBlock(urlStr, error as NSError, block)
            }
        }
    }
    
    func multipartWebRequest1(withEncryption : Bool = true, urlStr: String, dictParams: [String : Any]?, documents: [DocumentModel]?, block: @escaping WSBlock) {
        /*var header: HTTPHeaders = [:]
        if ((UserModel.signedIn) && !(UserModel.currentUser.token.isEmptyString)) {
            header["Authorization"] = "Bearer \(UserModel.currentUser.token)"
        }*/
        
        let uuid = UUID().uuidString
        var paramEncr = dictParams
        if withEncryption {
            paramEncr = dictParams?.encryptDic(uuid: uuid)
        }
        
        AF.upload(multipartFormData: { (multipartFormData) in
            if let params = paramEncr {
                for (key, value) in params {
                    if value is [[String : Any]] {
                        multipartFormData.append(self.JSONStringify(value: value).data(using: .utf8)!, withName: key)
                    } else if value is [String : Any] {
                        multipartFormData.append(self.JSONStringify(value: value).data(using: .utf8)!, withName: key)
                    } else {
                        multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                    }
                }
            }
            if let documents = documents {
                for document in documents {
                    var data: Data?
                    if let url = document.document as? URL {
                        data = try? Data(contentsOf: url)
                        debugPrint("------- data document \(document.key) -------- ", data?.count ?? 0)
                    } else if let image = document.document as? UIImage {
                        if (document.type.caseInsensitiveCompare(ImageType.png.rawValue) == .orderedSame) {
                            data = image.pngData()
                        } else {
                            data = image.jpegData(compressionQuality: 1.0)
                        }
                    } else if let url = document.url {
                        data = try? Data(contentsOf: url)
                        debugPrint("------- data url \(document.key) -------- ", data?.count ?? 0)
                    }
                    if let data = data {
                        multipartFormData.append(data, withName: document.key, fileName: document.title + "." + document.type, mimeType: document.mimeType.lowercased())
                    }
                }
            }
        }, to: urlStr, method: .post, headers: nil).uploadProgress { (progress) in
            debugPrint(progress.fractionCompleted)
//            uploadProgress?(progress.fractionCompleted)
        }.responseJSON { (response) in
            
//            self.apiResponsePrettyPrintedPrint(respObj: response, multipartDataRequest: (dictJson: dictParams, uploadDict: documents))
            
            switch(response.result) {
            case .success(_):
                self.successBlock1(withEncryption, uuid, urlStr, response, block)
            case .failure(let error):
                self.errorBlock(urlStr, error as NSError, block)
            }
        }
    }
    
    func multipartWebRequestWithHeaders(apiURLType: API_URL, dictParams: [String : Any]?, documents: [DocumentModel]?, block: @escaping WSBlock) {
        var header: HTTPHeaders = [:]
        header["Authorization"] = "Bearer \(UserPreferences.string(forKey: UserPreferencesKeys.UserInfo.token))"
        
        let urlStr = apiURLType.fullURLString
        
        AF.upload(multipartFormData: { (multipartFormData) in
            if let params = dictParams {
                for (key, value) in params {
                    if value is [[String : Any]] {
                        multipartFormData.append(self.JSONStringify(value: value).data(using: .utf8)!, withName: key)
                    } else if value is [String : Any] {
                        multipartFormData.append(self.JSONStringify(value: value).data(using: .utf8)!, withName: key)
                    } else {
                        multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                    }
                }
            }
            if let documents = documents {
                for document in documents {
                    var data: Data?
                    if let url = document.document as? URL {
                        data = try? Data(contentsOf: url)
                        print("------- data document \(document.key) -------- ", data?.count ?? 0)
                    } else if let url = document.url {
                        data = try? Data(contentsOf: url)
                        print("------- data url \(document.key) -------- ", data?.count ?? 0)
                    } else if let image = document.document as? UIImage {
                        if (document.type.caseInsensitiveCompare(ImageType.png.rawValue) == .orderedSame) {
                            data = image.pngData()
                        } else {
                            data = image.jpegData(compressionQuality: 1.0)
                        }
                    }
                    if let data = data {
                        multipartFormData.append(data, withName: document.key, fileName: document.title + "." + document.type, mimeType: document.mimeType.lowercased())
                    }
                }
            }
        }, to: urlStr, method: .post, headers: header, requestModifier: { request in
            request.timeoutInterval = 120
        }).uploadProgress { (progress) in
            debugPrint(progress.fractionCompleted)
//            uploadProgress?(progress.fractionCompleted)
        }.responseJSON { (response) in
            
            self.apiResponsePrettyPrintedPrint(respObj: response, multipartDataRequest: (dictJson: dictParams, uploadDict: documents))
            
            switch(response.result) {
            case .success(_):
                self.successBlock(urlStr, response, block)
            case .failure(let error):
                self.errorBlock(urlStr, error as NSError, block)
            }
        }
    }
    
    private func apiResponsePrettyPrintedPrint(respObj: AFDataResponse<Any>,
                                               multipartDataRequest: (dictJson:[String:Any]?, uploadDict:[DocumentModel]?)? = nil) {
        #if DEBUG

        print("url => ",respObj.request?.url ?? "")
        print("http Method => ",respObj.request?.httpMethod ?? "")
        print("Status Code => ",respObj.response?.statusCode ?? "--nil--")

        if let allHTTPHeaderFields = respObj.request?.allHTTPHeaderFields {
            print("HTTP Headers => ")
            if let jsonData = try? JSONSerialization.data(withJSONObject: allHTTPHeaderFields, options: .prettyPrinted) {
                print(NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) ?? allHTTPHeaderFields)
            } else {
                print(allHTTPHeaderFields)
            }
        }

        
        if let httpBody = respObj.request?.httpBody {
            
            print("Parameter => ")
            if let json = try? JSONSerialization.jsonObject(with: httpBody, options: []),
                let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                print(NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) ?? "")
            } else {
                print(NSString(data: httpBody, encoding: String.Encoding.utf8.rawValue) ?? "")
            }
        }
//
//        if let getMultipartDataRequest = multipartDataRequest {
//            print("MultiPart Parameter => ")
//
//            // 1. Pretty Printed Print Like PostMan
////            if let httpBodyJson = getMultipartDataRequest.dictJson {
////                if let jsonData = try? JSONSerialization.data(withJSONObject: httpBodyJson, options: .prettyPrinted) {
////                    print(NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) ?? httpBodyJson)
////                } else {
////                    print(httpBodyJson)
////                }
////            }
//
//            // 2. Bulk Edit Print Like PostMan
//            if let httpBodyJson = getMultipartDataRequest.dictJson {
//                httpBodyJson.sorted(by: { $0.key < $1.key }).forEach({ print("\($0):\($1)") })
//                print("")
//            }
//
//
//            // File Uploads Key Documents
//            if let uploadDict = getMultipartDataRequest.uploadDict {
//                for uploadItem in uploadDict {
//
//                    print("Document Key => \n", uploadItem.key,
//                          "\nDocument URL => \n", uploadItem.url?.absoluteString ?? "",
//                          "\nDocument => \n",
//                          (uploadItem.document as? NSObject)?.className ?? uploadItem.document ?? "",
//                          "\nDocument Title => \n", uploadItem.title,
//                          "\nDocument Type => \n", uploadItem.type
//                          )
//                }
//            }
//        }
//
        if let getData = respObj.data {
            print("Response => ")
            if let json = try? JSONSerialization.jsonObject(with: getData, options: []),
                let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                print(NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) ?? "")
            } else {
                print(NSString(data: getData, encoding: String.Encoding.utf8.rawValue) ?? "")
            }
        }

        if let getError = respObj.error {
            print("Error => ")
            print(getError)
        }

        #endif
    }
}


//MARK: - Methods for APIs
extension WShandler {
    
    func commonDict() -> DICTIONARY {
        
        return ["language": LocalizationParam.getInstance.localizationCode.rawValue,
                
                "Authentication": "8500a2e7d1a9083afbba71cf5afb4fee"]
        
    }
    class func commonDict1() -> [String: Any] {
        UserPreferences.set(value: LanguageCodes.english.rawValue, forKey: UserPreferencesKeys.General.languageCode)
        //EncryptionModel.default.encrypt(str: DeviceID),
        var parameter: [String : Any] = [CommonAPIConstant.device_id: DeviceID]
        parameter[CommonAPIConstant.key_languageCode] = UserPreferences.string(forKey: UserPreferencesKeys.General.languageCode)
//        parameter[CommonAPIConstant.key_languageCode] = EncryptionModel.default.encrypt(str: UserPreferences.string(forKey: UserPreferencesKeys.General.languageCode), key: "lang")
          
        
//        if !UserModel.currentUser.id.isEmptyString{
//            parameter[CommonAPIConstant.key_user_id] = UserModel.currentUser.id
//        }
//
//        if !UserModel.currentUser.token.isEmptyString{
//            parameter[CommonAPIConstant.key_token] = UserModel.currentUser.token
//        }
        return parameter as [String : Any]
    }
    //JSON Conversion to Dictionary
    func JSONStringify(value: Any?, prettyPrinted: Bool = false) -> String {
        if let value = value {
            let options: JSONSerialization.WritingOptions = prettyPrinted ? JSONSerialization.WritingOptions.prettyPrinted : []
            if JSONSerialization.isValidJSONObject(value) {
                do {
                    let data = try JSONSerialization.data(withJSONObject: value, options: options)
                    if let string = String(data: data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) {
                        return string
                    }
                } catch {
                    
                }
            }
        }
        return ""
    }
    class func textDictionaryToAny(_ textDictionary: String) -> Any? {
        if let jsonData = textDictionary.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: jsonData, options: [])
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    //MARK:- Check Internet Connectivity
    func CheckInternetConnectivity() -> Bool {
        if (reachability == nil) {
            reachability = Reachability()!
        }
        return reachability.isReachable
    }
}


private var reachability:Reachability!



public struct NEWURLEncoding: ParameterEncoding {
    // MARK: Helper Types

    /// Defines whether the url-encoded query string is applied to the existing query string or HTTP body of the
    /// resulting URL request.
    public enum Destination {
        /// Applies encoded query string result to existing query string for `GET`, `HEAD` and `DELETE` requests and
        /// sets as the HTTP body for requests with any other HTTP method.
        case methodDependent
        /// Sets or appends encoded query string result to existing query string.
        case queryString
        /// Sets encoded query string result as the HTTP body of the URL request.
        case httpBody

        func encodesParametersInURL(for method: HTTPMethod) -> Bool {
            switch self {
            case .methodDependent: return [.get, .head, .delete].contains(method)
            case .queryString: return true
            case .httpBody: return false
            }
        }
    }

    /// Configures how `Array` parameters are encoded.
    public enum ArrayEncoding {
        /// An empty set of square brackets is appended to the key for every value. This is the default behavior.
        case brackets
        /// No brackets are appended. The key is encoded as is.
        case noBrackets
        /// Brackets containing the item index are appended. This matches the jQuery and Node.js behavior.
        case indexInBrackets

        func encode(key: String, atIndex index: Int) -> String {
            switch self {
            case .brackets:
                return "\(key)[]"
            case .noBrackets:
                return key
            case .indexInBrackets:
                return "\(key)[\(index)]"
            }
        }
    }

    /// Configures how `Bool` parameters are encoded.
    public enum BoolEncoding {
        /// Encode `true` as `1` and `false` as `0`. This is the default behavior.
        case numeric
        /// Encode `true` and `false` as string literals.
        case literal

        func encode(value: Bool) -> String {
            switch self {
            case .numeric:
                return value ? "1" : "0"
            case .literal:
                return value ? "true" : "false"
            }
        }
    }

    // MARK: Properties

    /// Returns a default `NEWURLEncoding` instance with a `.methodDependent` destination.
    public static var `default`: NEWURLEncoding { NEWURLEncoding() }

    /// Returns a `NEWURLEncoding` instance with a `.queryString` destination.
    public static var queryString: NEWURLEncoding { NEWURLEncoding(destination: .queryString) }

    /// Returns a `NEWURLEncoding` instance with an `.httpBody` destination.
    public static var httpBody: NEWURLEncoding { NEWURLEncoding(destination: .httpBody) }

    /// The destination defining where the encoded query string is to be applied to the URL request.
    public let destination: Destination

    /// The encoding to use for `Array` parameters.
    public let arrayEncoding: ArrayEncoding

    /// The encoding to use for `Bool` parameters.
    public let boolEncoding: BoolEncoding

    // MARK: Initialization

    /// Creates an instance using the specified parameters.
    ///
    /// - Parameters:
    ///   - destination:   `Destination` defining where the encoded query string will be applied. `.methodDependent` by
    ///                    default.
    ///   - arrayEncoding: `ArrayEncoding` to use. `.brackets` by default.
    ///   - boolEncoding:  `BoolEncoding` to use. `.numeric` by default.
    public init(destination: Destination = .methodDependent,
                arrayEncoding: ArrayEncoding = .brackets,
                boolEncoding: BoolEncoding = .numeric) {
        self.destination = destination
        self.arrayEncoding = arrayEncoding
        self.boolEncoding = boolEncoding
    }

    // MARK: Encoding

    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()

        guard let parameters = parameters else { return urlRequest }

        if let method = urlRequest.method, destination.encodesParametersInURL(for: method) {
            guard let url = urlRequest.url else {
                throw AFError.parameterEncodingFailed(reason: .missingURL)
            }

            if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
                let percentEncodedQuery = (urlComponents.percentEncodedQuery.map { $0 + "&" } ?? "") + query(parameters)
                urlComponents.percentEncodedQuery = percentEncodedQuery
                urlRequest.url = urlComponents.url
            }
        } else {
            if urlRequest.headers["Content-Type"] == nil {
                urlRequest.headers.update(.contentType("application/x-www-form-urlencoded; charset=utf-8"))
            }

            urlRequest.httpBody = Data(query(parameters).utf8)
        }

        return urlRequest
    }

    /// Creates a percent-escaped, URL encoded query string components from the given key-value pair recursively.
    ///
    /// - Parameters:
    ///   - key:   Key of the query component.
    ///   - value: Value of the query component.
    ///
    /// - Returns: The percent-escaped, URL encoded query string components.
    public func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
        var components: [(String, String)] = []
        switch value {
        case let dictionary as [String: Any]:
            for (nestedKey, value) in dictionary {
                components += queryComponents(fromKey: "\(key)[\(nestedKey)]", value: value)
            }
        case let array as [Any]:
            for (index, value) in array.enumerated() {
                components += queryComponents(fromKey: arrayEncoding.encode(key: key, atIndex: index), value: value)
            }
        case let number as NSNumber:
            if number.issBool {
                components.append((escape(key), escape(boolEncoding.encode(value: number.boolValue))))
            } else {
                components.append((escape(key), escape("\(number)")))
            }
        case let bool as Bool:
            components.append((escape(key), escape(boolEncoding.encode(value: bool))))
        default:
            if key.contains("FalseID") || key.contains("TrueID") {
                components.append((key, "\(value)"))
            } else if key.lowercased() == "searchtext" {
                components.append((escapeWithOutPlus(key), escapeWithOutPlus("\(value)")))
            } else {
                components.append((escape(key), escape("\(value)")))
            }
        }
        return components
    }

    /// Creates a percent-escaped string following RFC 3986 for a query string key or value.
    ///
    /// - Parameter string: `String` to be percent-escaped.
    ///
    /// - Returns:          The percent-escaped `String`.
    public func escape(_ string: String) -> String {
        return string.addingPercentEncoding(withAllowedCharacters: .afsURLQueryAllowed) ?? string
    }

    public func escapeWithOutPlus(_ string: String) -> String {
        return string.addingPercentEncoding(withAllowedCharacters: .afsURLQueryAllowedWithOutPlus) ?? string
    }

    
    private func query(_ parameters: [String: Any]) -> String {
        var components: [(String, String)] = []

        for key in parameters.keys.sorted(by: <) {
            let value = parameters[key]!
            components += queryComponents(fromKey: key, value: value)
        }
        return components.map { "\($0)=\($1)" }.joined(separator: "&")
    }
}

extension NSNumber {
    fileprivate var issBool: Bool {
        // Use Obj-C type encoding to check whether the underlying type is a `Bool`, as it's guaranteed as part of
        // swift-corelibs-foundation, per [this discussion on the Swift forums](https://forums.swift.org/t/alamofire-on-linux-possible-but-not-release-ready/34553/22).
        String(cString: objCType) == "c"
    }
}



extension CharacterSet {
    /// Creates a CharacterSet from RFC 3986 allowed characters.
    ///
    /// RFC 3986 states that the following characters are "reserved" characters.
    ///
    /// - General Delimiters: ":", "#", "[", "]", "@", "?", "/"
    /// - Sub-Delimiters: "!", "$", "&", "'", "(", ")", "*", "+", ",", ";", "="
    ///
    /// In RFC 3986 - Section 3.4, it states that the "?" and "/" characters should not be escaped to allow
    /// query strings to include a URL. Therefore, all "reserved" characters with the exception of "?" and "/"
    /// should be percent-escaped in the query string.
    public static let afsURLQueryAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        let encodableDelimiters = CharacterSet(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return CharacterSet.urlQueryAllowed.subtracting(encodableDelimiters)
    }()
    
    public static let afsURLQueryAllowedWithOutPlus: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*,;="
        let encodableDelimiters = CharacterSet(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return CharacterSet.urlQueryAllowed.subtracting(encodableDelimiters)
    }()
    
    
}
