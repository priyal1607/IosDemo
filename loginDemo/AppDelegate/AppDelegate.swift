//
//  AppDelegate.swift
//  loginDemo
//
//  Created by Chelsi on 10/04/23.
//

import UIKit
import IQKeyboardManagerSwift
import SideMenu
import MediaPlayer
import UserNotifications
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate  {

var window: UIWindow?
    let viewMusic = Bundle.main.loadNibNamed("ViewMusicControl", owner: nil, options: nil)![0] as! ViewMusicControl
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey("AIzaSyDofsfa_ZfMaybgputAwrO84xjt8vMo1DM")
        setupIQKeyboard()
        setUpLeftMenu()
        setUpinitialVc()
       // setUpNotification()
     
        if UserDefaults.standard.bool(forKey: "loggedin"){
            let storyboard = UIStoryboard(name: "BottomBarController", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "BottomBarViewController")as! BottomBarViewController
            let navCon = UICustomNavigationController(rootViewController: vc)
            navCon.isNavigationBarHidden = true
//            window?.rootViewController = navCon
//            window?.makeKeyAndVisible()
            self.getwindow().rootViewController = navCon
            self.getwindow().makeKeyAndVisible()
        }
        // Override point for customization after application launch.
        return true
    }
    func setUpinitialVc(){
        if !UserDefaults.standard.bool(forKey: "intro") {
            let vc = OnBoardingVC.instantiate(appStoryboard: .onboarding)
            let navCon = UICustomNavigationController(rootViewController: vc)
            navCon.isNavigationBarHidden = true
            window?.rootViewController = navCon
            window?.makeKeyAndVisible()
        }
        else {
            if !UserPreferences.bool(forKey: UserPreferencesKeys.General.intro){
                let storyboard = UIStoryboard(name: "BottomBarController", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "BottomBarViewController")as! BottomBarViewController
                let navCon = UICustomNavigationController(rootViewController: vc)
                navCon.isNavigationBarHidden = true
                //window?.rootViewController = navCon
                //window?.makeKeyAndVisible()
                self.getwindow().rootViewController = navCon
                self.getwindow().makeKeyAndVisible()
            } else {
                let story = LoginVC.instantiate(appStoryboard: .main)
                let navCon = UICustomNavigationController(rootViewController: story)
                navCon.isNavigationBarHidden = true
                self.getwindow().rootViewController = navCon
                
            }
        }
    }
        

    private func setupIQKeyboard() {
            
            IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "DONE"
            IQKeyboardManager.shared.enable = true
            
            IQKeyboardManager.shared.shouldResignOnTouchOutside = true
            IQKeyboardManager.shared.enable = true
            IQKeyboardManager.shared.enableAutoToolbar = true
            IQKeyboardManager.shared.toolbarManageBehaviour = .byPosition
            IQKeyboardManager.shared.previousNextDisplayMode = .default
            IQKeyboardManager.shared.toolbarPreviousNextAllowedClasses.append(contentsOf: [UIStackView.self, UIView.self, UIScrollView.self, UITextField.self, UITextView.self])
            IQKeyboardManager.shared.toolbarTintColor = .black
        }
    
   
    // MARK: UISceneSession Lifecycle

    private func setUpLeftMenu() {
//        let aSideMenuViewController = SidemenuVC.instantiate(appStoryboard: .Sidemenu)
        let storyboard = UIStoryboard(name: "Sidemenu", bundle: nil)
              let aSideMenuViewController = storyboard.instantiateViewController(withIdentifier: "SidemenuVC")as! SidemenuVC
            
            let sideMenuViewController = SideMenuNavigationController(rootViewController: aSideMenuViewController)
            sideMenuViewController.leftSide = true
            sideMenuViewController.isNavigationBarHidden = true
            SideMenuManager.default.leftMenuNavigationController = sideMenuViewController
            SideMenuManager.default.rightMenuNavigationController = sideMenuViewController
            sideMenuViewController.pushStyle = .default
            sideMenuViewController.presentationStyle = .menuSlideIn
            sideMenuViewController.presentationStyle.backgroundColor = .black
            sideMenuViewController.settings.statusBarEndAlpha = 0
            sideMenuViewController.presentationStyle.presentingEndAlpha = 0.6
        let  SCREEN_WIDTH = UIScreen.main.bounds.size.width
            sideMenuViewController.menuWidth = SCREEN_WIDTH * 0.8
            }
    }

extension AppDelegate : MusicPlayPauseUpdateDelegate {
    func musicPlayPauseUpdateIndex(index: Int, tbl_Tag: Int) {
        let bottomVC = (self.window?.rootViewController as? BottomBarViewController)
        
        if index != -1 && bottomVC?.viewMusic.tag == 0 && (bottomVC?.viewMusic.isHidden ?? true) {
            bottomVC?.viewMusic.isHidden = false
        }
        
        
        func pushScreenOfUserInfo(userInfo: [AnyHashable : Any]) {
            
            let bottomVC = (self.window?.rootViewController as? BottomBarViewController)
            bottomVC?.dismiss(animated: true)
            
            if let viewType = userInfo["type"],
               !getString(anything: viewType).isEmptyString {
                
                let rvmDataString = userInfo["rvmData"] as? String ?? ""
                guard let rvmData = WShandler.textDictionaryToAny(rvmDataString) as? DICTIONARY else {
                    (bottomVC?.selectedViewController as? UINavigationController)?.popToRootViewController(animated: true)
                    return
                }
                
                switch getString(anything: viewType) {
                    
                case "music":
                    
                    let musicSubViewsListItem = MusicModel(dict: [:])
                    musicSubViewsListItem._id = getString(anything: userInfo["nid"])
                    musicSubViewsListItem.music_title = getString(anything: rvmData["rvm_title"])
                    musicSubViewsListItem.music_singer = getString(anything: rvmData["rvm_description"])
                    musicSubViewsListItem.music_thumbnail = getString(anything: rvmData["rvm_thumbnail"])
                    musicSubViewsListItem.music_duration = "00:00"
                    musicSubViewsListItem.music_path = getString(anything: rvmData["rvm_url"])
                    
                    let dVC = getMusicPlayerdVC()
                    dVC.previousIndexRow = dVC.index
                    dVC.previousList = dVC.arr
                    dVC.delegate = self
                    dVC.arr = [musicSubViewsListItem]
                    dVC.index = 0
                    dVC.modalPresentationStyle = .fullScreen
                    bottomVC?.present(dVC, animated: true)
                    bottomVC?.viewMusic.tag = 0
                    
                default:
                    (bottomVC?.selectedViewController as? UINavigationController)?.popToRootViewController(animated: true)
                    break
                }
                
                
            } else {
                (bottomVC?.selectedViewController as? UINavigationController)?.popToRootViewController(animated: true)
            }
            
        }
        
    }
    
}

