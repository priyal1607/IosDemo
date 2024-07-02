//
//  SettingViewController.swift
//  LSAttendance
//
//  Created by Vikram Jagad on 30/06/20.
//  Copyright © 2020 Hitesh. All rights reserved.
//

import UIKit

enum SettingType: String
{
    case language = "language"
    case shareApp = "shareApp"
    case privacyPolicy = "privacyPolicy"
    case termsOfUse = "termsofUse"
    case appearance = "appearance"
}

class SettingViewController : HeaderViewController {
    
    //MARK: Outlet
    @IBOutlet var settingTblView : UITableView!
    @IBOutlet weak var mainView: UIView!
    
    //MARK: Private variables
    fileprivate var settingTableViewDataSourceDelegate : SettingTableViewDataSourceDelegate!
    fileprivate var settingListModel : [SettingListModel] = []
    fileprivate var languageListModel : [LanguageListModel] = []
    
    
    //MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpVC()
    }
    
    
    //MARK: Privates Methods
    fileprivate func setUpVC() {
        setUpIPadConstraint()
        setupView()
        setupData()
        setUpHeader()
    }
    func setUpHeader() {
        self.setUpHeaderTitle(strHeaderTitle: "Change Language")
        self.viewHeader.lblHeaderTitle.textColor = .white
    }
    
    fileprivate func setUpIPadConstraint() {
        changeLeadingTrailingForiPad(view: self.view)
    }
    
    private func setupView() {
        self.settingTblView.backgroundColor = .clear
//        mainView.addGradient(ofColors: [.DashGradientOne, .DashGradientTwo, .DashGradientThree], direction: .topBottom)
//        setHeaderView_BackImage()
    }
    
    private func setupData() {
        
        let dictJson = readJsonFile(ofName: "Settings")
        if let settingData = dictJson["list"] as? [[String : Any]] {
            self.settingListModel = settingData.map({ SettingListModel(dict: $0) })
        }
        if let arrlanguage = dictJson["lang_list"] as? [[String : Any]] {
            self.languageListModel = arrlanguage.map({ LanguageListModel(dict: $0) })
        }
     
        if #available(iOS 13.0, *) {
            
        } else {
            for idx in 0..<self.settingListModel.count {
                if self.settingListModel[idx].type == SettingType.appearance.rawValue {
                    self.settingListModel.remove(at: idx)
                }
            }
        }
        
        settingTableViewDataSourceDelegate = SettingTableViewDataSourceDelegate(arrData: self.settingListModel, delegate: self, scrl: self.settingTblView, arrLanguage: self.languageListModel)
        settingTableViewDataSourceDelegate.changeLanguage = changeLanguageCallBack
    }
    @IBAction func btnBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func changeLanguageCallBack() {
//        setUpHeaderTitle(strHeaderTitle: .LanguageLocalisation.setting)
        K_NC.post(name: .languageChanged, object: nil)
    }
}

//MARK: Custom UITableview Delegate
extension SettingViewController : TblViewDelegate {
    
    func didSelect(tbl: UITableView, indexPath: IndexPath) {
        
    }
}
