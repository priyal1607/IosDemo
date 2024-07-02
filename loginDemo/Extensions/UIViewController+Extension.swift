//
//  UIViewController+Extension.swift
//  Vidyanjali
//
//  Created by Vikram Jagad on 06/11/20.
//  Copyright © 2020 Vikram Jagad. All rights reserved.
//

import UIKit

enum AppStoryboard: String {
    
    case main = "Main"
    case homepage = "HomePage"
    case dashboard = "Dashboard"
    case collectionview = "CollectionView"
    case Music = "Music"
    case musicPlayer = "MusicPlayer"
    case onboarding = "OnBoarding"
    case Kytdashboard = "Kytdashboard"
    case TopBarViewController = "TopBarViewController"
    case mandir = "Mandir"
    case options = "Options"
    case map = "map"
    case disclaimer = "Disclaimer"
    case Notes1 = "MEAnotes"
    case presentNote = "presentNote"
    case pNote = "pNote"
    case note = "Notes"
    case tableActonSheet = "TableActonSheet"
    case SAG = "SAG"
}

extension UIViewController {
    class func instantiate(appStoryboard: AppStoryboard) -> Self {
        let storyboard = UIStoryboard(name: appStoryboard.rawValue, bundle: nil)
        let identifier = String(describing: Self.self)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
    }
}

extension UIViewController {
func popupAlert(title: String?, message: String?, actionTitles:[String?], actions:[((UIAlertAction) -> Void)?]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, title) in actionTitles.enumerated() {
            let action = UIAlertAction(title: title, style: .default, handler: actions[index])
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: nil)
    }
}
