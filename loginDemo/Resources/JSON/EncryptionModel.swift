import UIKit
import CryptoSwift

var staticIv : String { return "sagaaetrmi0oo0rn0ia0al0l" }
var staticKey : String { return DeviceID }
typealias dictionary = [String : Any]

final class EncryptionModel: NSObject {
    //MARK:- Variables
    //Private
    static let `default` = EncryptionModel()
    
    private override init() {
        super.init()
    }
    
    //MARK:- Public Methods
    func encrypt(str: String, uuid : String) -> String {
        if str.isEmptyString {
            return ""
        }
        let newKey = uuid.sha256()[0..<32]
        let newIv = staticIv.sha256()[0..<16]
        let data: Array<UInt8> = Array(str.utf8)
        var encryptedStr = ""
        do {
            let enc = try AES(key: newKey, iv: newIv).encrypt(data)
            let encData = Data(bytes: enc, count: enc.count)
            let base64String = encData.base64EncodedString(options: .init(rawValue: 0))
            encryptedStr = base64String
        } catch let error {
            DebugLog("Error encrypting - \(error.localizedDescription)")
        }
        encryptedStr = getString(anything: encryptedStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
        return encryptedStr
    }
    
    
    func decrypt(str: String, uuid : String) -> String {
        let lastTwoChars = str.substring(from: str.count - 1)
        var text = str
        if (lastTwoChars == "\n") {
            text = text.substring(to: text.count - 1)
        }
        let newKey = uuid.sha256()[0..<32]
        let newIv = staticIv.sha256()[0..<16]
        var decryptedStr = ""
        do {
            if (text.isEmptyString) {
                decryptedStr = text
            } else if let base64Data = Data(base64Encoded: text) {
                let data: Array<UInt8> = Array(base64Data)
                let dec = try AES(key: newKey, iv: newIv).decrypt(data)
                let decData = Data(bytes: dec, count: dec.count)
                decryptedStr = getString(anything: String(data: decData, encoding: .utf8))
            } else {
                decryptedStr = text
            }
        } catch let error {
            DebugLog("Error decrypting - \(error.localizedDescription)")
        }
        return decryptedStr
    }
    
    func encryptDic(dic : [String : Any], uuid: String) -> [String : Any] {
        var encryptedDic = [String : Any]()
        for i in dic {
            encryptedDic[i.key] = self.encrypt(str: "\(i.value)", uuid: uuid)
        }
        return encryptedDic
    }
}

extension dictionary {
    func encryptDic(uuid : String) -> [String : Any] {
        var encryptedDic = [String : Any]()
        for i in self {
            if [CommonAPIConstant.key_deviceID].contains(i.key) {
                encryptedDic[i.key] = uuid// i.value
            } else {
                encryptedDic[i.key] = "\(i.value)".encryptStr(uuid: uuid)
            }
        }
        return encryptedDic
    }
    
    func encryptDicWithEncoded(uuid : String) -> [String : Any] {
        var encryptedDic = [String : Any]()
        for i in self {
            if [CommonAPIConstant.device_id].contains(i.key) {
                encryptedDic[i.key] = uuid //i.value
            } else {
                encryptedDic[i.key] = getString(anything: "\(i.value)".encryptStr(uuid: uuid).addingPercentEncoding(withAllowedCharacters: .afURLQueryAllowed))
            }
        }
        return encryptedDic
    }
    
    func decryptDic(uuid : String) -> [String : Any] {
        var decryptedDic = [String : Any]()
        self.forEach { dic in
            
            if dic.value is String { //for String Value
                decryptedDic[dic.key] = "\(dic.value)".decryptStr(uuid: uuid)
                
            } else if let newDic = dic.value as? [String : Any] { //for Dictionary
                decryptedDic[dic.key] = newDic.decryptDic(uuid: uuid)

            } else if let newArr = dic.value as? [[String : Any]] { //for Array
                var newArrValue = [[String : Any]]()
                newArr.forEach { arr1 in
                    newArrValue.append(arr1.decryptDic(uuid: uuid))
                }
                decryptedDic[dic.key] = newArrValue
                
            } else {
                decryptedDic[dic.key] = "\(dic.value)".decryptStr(uuid: uuid)
            }
        }
        return decryptedDic
    }
}

extension String {
    func encryptStr(uuid : String) -> String {
        return EncryptionModel.default.encrypt(str: self, uuid: uuid)
    }
    
    func decryptStr(uuid : String) -> String {
        return EncryptionModel.default.decrypt(str: self, uuid: uuid)
    }
}
