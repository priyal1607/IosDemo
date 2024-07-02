

import UIKit


class UserData {
   
    private var defaults: UserDefaults
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
    
    static var shared = UserData()
    
//    func getStoredData() -> ([CustomizeDashboardListModel]?){
//        if let data = defaults.value(forKey: "storedarr") as? [CustomizeDashboardListModel]{
//            return data
//        }else{
//            return (nil)
//        }
//    }
//
//    @discardableResult
//    func setData(storedData: [CustomizeDashboardListModel]) -> Bool {
//       defaults.set(storedData, forKey: "storedarr")
//       return defaults.synchronize()
//    }
    
    func removeStoredValues(key:String) -> Bool {
        UserDefaults.standard.removeObject(forKey: key)
        return UserDefaults.standard.synchronize()
    }
}
