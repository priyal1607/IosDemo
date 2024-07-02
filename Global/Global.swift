//
//  Global.swift
//  Vidyanjali
//
//  Created by Vikram Jagad on 06/11/20.
//  Copyright © 2020 Vikram Jagad. All rights reserved.
//

import UIKit
import BRYXBanner

class Global: NSObject {
    
    static let shared = Global()
    
    func gotoDashboard() {
        
        let homeVC = GalleryVC.instantiate(appStoryboard: AppStoryboard(rawValue: "Gallery")!)
        let navCon = UICustomNavigationController(rootViewController: homeVC)
        UserPreferences.remove(forKey: UserPreferencesKeys.UserInfo.token)
        getwindow().rootViewController = navCon
        getwindow().makeKeyAndVisible()
        Global.shared.showBanner(message: .LanguageLocalisation.message_token_expired)
    }
    func tokenExpired() {
        UserPreferences.remove(forKey:UserPreferencesKeys.General.email)
        UserPreferences.remove(forKey:UserPreferencesKeys.General.name)
        UserPreferences.remove(forKey:UserPreferencesKeys.UserInfo.userID)
        UserPreferences.remove(forKey:UserPreferencesKeys.General.token)
        UserPreferences.remove(forKey:UserPreferencesKeys.General.form_type)
        UserPreferences.remove(forKey: UserPreferencesKeys.General.isUserLoggedIn)
        UserPreferences.remove(forKey: UserPreferencesKeys.General.userImg)
        UserModel.remove()
       // K_NC.post(name: .loginLogoutDone, object: nil)
    }
    
    func logout() {
        if (WShandler.shared.CheckInternetConnectivity()) {
            let dict=[CommonAPIConstant.key_token: UserPreferences.string(forKey: UserPreferencesKeys.UserInfo.token)]
            
            WShandler.shared.postURLQueyWebRequest(apiURLType: .pathType(.logout), queryParam: dict, param: [:]) { json, flag in
            
                if (flag == 200) {
                    let homeVC = GalleryVC.instantiate(appStoryboard: AppStoryboard(rawValue: "Gallery")!)
                    let navCon = UICustomNavigationController(rootViewController: homeVC)
                    self.getwindow().rootViewController = navCon
                    self.getwindow().makeKeyAndVisible()
                } else {
                    if getString(anything: json[CommonAPIConstant.key_message]).isStringEmpty {
                        Global.shared.showBanner(message: .LanguageLocalisation.something_went_wrong_try_some_time)
                    } else {
                        Global.shared.showBanner(message: getString(anything: json[CommonAPIConstant.key_message]))
                    }
                }
            }
        }  else {
            Global.shared.showBanner(message: .LanguageLocalisation.msg_Internet_Issue)
        }
    }
    
   
    
    func showBanner(title: String? = nil, message: String, img: UIImage? = nil, bgColor: UIColor = .white) {
        let banner = Banner(title: title, subtitle: message, image: img, backgroundColor: bgColor, didTapBlock: nil)
        banner.titleLabel.textColor = .red
        banner.titleLabel.font = .boldSystemFont(withSize: .value)
        banner.detailLabel.textColor = .red
        banner.detailLabel.font = .regularSystemFont(withSize: .value)
        banner.dismissesOnTap = true
        banner.dismissesOnSwipe = true
        banner.show(nil, duration: 1.5)
    }
    
    
    
    //Read Json file
   
    
    func formatTimeFromSeconds(totalSeconds : Double) -> String {
        let seconds1 = Int(totalSeconds) % 60
        let minutes = Int(totalSeconds / 60) % 60
        let hours = Int(totalSeconds) / 3600
        if totalSeconds > 3599 {
            if totalSeconds > 35999 {
                return String(format: "%01d:%02d:%02d", hours, minutes, seconds1)
            }
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds1)
        }
        if totalSeconds > 599 {
            return String(format: "%02d:%02d", minutes, seconds1)
        }
        return String(format: "%01d:%02d", minutes, seconds1)
    }
    
    func getSliderThumbImage(color: UIColor = .customTertiary, heightWidth: CGFloat) -> UIImage {
        let customView = UIView(frame: CGRect(origin: .zero, size: .init(width: heightWidth, height: heightWidth)))
        customView.backgroundColor = color
        customView.setCustomCornerRadius(radius: heightWidth / 2)
        let returnImage = customView.takeScreenshot()
        return returnImage
    }
    
    var uuidString: String {
        return UUID().uuidString
    }
    
    //Sharing:-
    
    enum ShareType
    {
        case text
        case image(UIImage?)
    }
    
    func shareAccordtingToType(type: ShareType, dict: [String : Any], VC: UIViewController?, sender: UIView, completionBlock: @escaping ((Bool) -> Void))
    {
        let vc: UIViewController? = VC ?? appDelegate?.window?.rootViewController
        
        let strDetail =  dict[CommonAPIConstant.key_title] as? String
        let strSubject = dict[CommonAPIConstant.key_subject] as? String
        let picURLString = dict[CommonAPIConstant.key_photourl] as? String
        
        var stringSub = ""
        if let strSubject = strSubject {
            stringSub = strSubject
        }
        
        var stringDetail = ""
        if let strDetail = strDetail {
            stringDetail += "\n\n" + strDetail + "\n"
        }
        
        var items: [Any] = [stringSub, stringDetail]
        
        if let picURLString = picURLString,
           picURLString.trimmingCharacters(in: .whitespacesAndNewlines).count > 0,
           let picURL = URL(string: picURLString) ?? URL(string: picURLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) {
            
            items.append(picURL)
        }
        
        switch type {
        case .text:
            break
        case .image(let img):
            if let imge = img {
                items.append(imge)
            }
        }
        
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        activityViewController.setValue(stringSub, forKey: CommonAPIConstant.key_subject)
        
        if (IS_IPAD) {
            activityViewController.popoverPresentationController?.sourceView = sender
            activityViewController.popoverPresentationController?.sourceRect = sender.bounds
        }
        
        activityViewController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            
            completionBlock(completed)
        }
        
        vc?.present(activityViewController, animated: true, completion: nil)
        
    }
    
    class func shareTextWithCompletion(arrayItem:[Any], subject:String?, VC:UIViewController?, sender: UIView, completion: @escaping CompletionBlock1) {
        
        let activityViewController = UIActivityViewController(activityItems: arrayItem as [Any], applicationActivities: nil)
        activityViewController.setValue(subject, forKey: CommonAPIConstant.key_subject)
        
        if(IS_IPAD){
            activityViewController.popoverPresentationController?.sourceView = sender
            activityViewController.popoverPresentationController?.sourceRect = sender.bounds
        }
        
        VC?.present(activityViewController, animated: true, completion: nil)
        activityViewController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if !completed {
                // User canceled
                return
            }
            // User completed activity
            completion(activityType, completed)
        }
    }
    
    func getFileSizeInMb(data:Data) -> String {
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = [.useMB] // optional: restricts the units to MB only
        bcf.countStyle = .file
        let string = bcf.string(fromByteCount: Int64(data.count))
        return string
    }
    
    func getFileSizeInMb(int64Count:Int64) -> String {
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = .useMB
        bcf.countStyle = .file
        let string = bcf.string(fromByteCount: int64Count)
        return string
    }
    
    func getDashedLineView(startX:Double = 0,startY:Double = 0,endX:Double,endY:Double,view:UIView) {
        let lineLayer = CAShapeLayer()
        
        lineLayer.strokeColor = UIColor.gray.cgColor
        lineLayer.lineWidth = 1
        lineLayer.lineDashPattern = [3,2]
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: startX, y: startY),
                                CGPoint(x: endX, y: endY)])
        lineLayer.path = path
        view.layer.addSublayer(lineLayer)
    }
}


extension Global {
    
    class func uniQueID() -> String {
        let keychainItem = KeychainItem(service: Bundle.main.bundleIdentifier!, accessGroup: nil)
        let userDefaultsDeviceID = UserPreferences.string(forKey: UserPreferencesKeys.DeviceInfo.deviceID)
        if (userDefaultsDeviceID == "")
        {
            do
            {
                let deviceID = try keychainItem.saveDeviceID(self.stringWithNewUUID())
                UserPreferences.set(value: deviceID, forKey: UserPreferencesKeys.DeviceInfo.deviceID)
                print("deviceID :- \(deviceID)")
                return deviceID
            }
            catch let error
            {
                print(error.localizedDescription)
            }
        }
        else
        {
            var deviceID = UserPreferences.string(forKey: UserPreferencesKeys.DeviceInfo.deviceID)
            if (deviceID.count < 36)
            {
                do
                {
                    try keychainItem.deleteItem()
                }
                catch let error
                {
                    print(error.localizedDescription)
                }
                do
                {
                    deviceID = try keychainItem.saveDeviceID(self.stringWithNewUUID())
                    UserPreferences.set(value: deviceID, forKey: UserPreferencesKeys.DeviceInfo.deviceID)
                    print("deviceID :- \(deviceID)")
                    return deviceID
                }
                catch let error
                {
                    print(error.localizedDescription)
                }
            }
            else
            {
                print("deviceID :- \(deviceID)")
                return deviceID
            }
        }
        return ""
        //return "12345"
    }
    
    class func stringWithNewUUID() -> String
    {
        let uuidObj = CFUUIDCreate(nil)
        let newUUID = (CFUUIDCreateString(nil, uuidObj) as String)
        return newUUID
    }
    
}
