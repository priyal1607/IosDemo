//
//  SettingTableViewDataSourceDelegate.swift
//  LSAttendance
//
//  Created by Vikram Jagad on 30/06/20.
//  Copyright © 2020 Hitesh. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

enum AppearanceType: Int {
    case useSystem = 0
    case lightMode = 1
    case darkMode = 2
    
    var displayString: String {
        switch self {
        case .useSystem: return "Use system setting".localizedString
        case .lightMode: return "Light Mode".localizedString
        case .darkMode: return "Dark Mode".localizedString
        }
    }
}

class SettingTableViewDataSourceDelegate : NSObject {

    //MARK: Types
    typealias T = SettingListModel
    typealias ScrlView = UITableView
    typealias Delegate = TblViewDelegate
    
    //MARK: Private variable
    private var arrLanguageSelection:[LanguageListModel] = []
    
    //MARK: Internal variables
    internal var arrSource: [SettingListModel]
    internal weak var delegate: TblViewDelegate?
    internal var scrlView: UITableView

    //MARK: Complition
    var changeLanguage : (() -> Void)?
    
    //MARK: Initializer
    required init(arrData: [T], delegate: Delegate, scrl: ScrlView, arrLanguage:[LanguageListModel]) {
        arrSource = arrData
        self.delegate = delegate
        self.arrLanguageSelection = arrLanguage
        scrlView = scrl
        super.init()
        self.setUpScrlView()
    }
    
    //MARK: Private methods
    fileprivate func setUpScrlView() {
        
        registerCell()
        
        scrlView.estimatedRowHeight = 77
        scrlView.rowHeight = UITableView.automaticDimension
        scrlView.separatorStyle = .none
        scrlView.contentInset = .init(top: 20, left: 0, bottom: 0, right: 0)
        scrlView.delegate = self
        scrlView.dataSource = self
        setupTblBackground()
        scrlView.reloadData()
    }
    
    fileprivate func registerCell() {
        scrlView.register(cellType: SettingTableViewCell.self)
        scrlView.register(cellType: cellSetting.self)
    }
    
    
    fileprivate func setupTblBackground() {
        
        if (arrSource.count > 0) {
            scrlView.backgroundView = nil
        } else {
            scrlView.backgroundView = UIView.makeNoRecordFoundView(frame: scrlView.bounds, msg: .LanguageLocalisation.no_record_found)
        }
    }
    
    //MARK: Public method
    func reloadScrlView(arr: [T]) {
        arrSource = arr
        scrlView.reloadData()
        setupTblBackground()
    }
}

//MARK: UITableView Delegate Methods
extension SettingTableViewDataSourceDelegate:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect?(tbl: tableView, indexPath: indexPath)
    }
}

//MARK: UITableView DataSource Methods
extension SettingTableViewDataSourceDelegate:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(with: SettingTableViewCell.self, for: indexPath)
            cell.btnLanguage.addTarget(self, action: #selector(btnLanguageTapped), for: .touchUpInside)
            cell.btnLanguage.tag = indexPath.row
            
            cell.viewSeperator.isHidden = false
            cell.lblChangeLanguage.text = "Change Language".localizedString
            if UserPreferences.string(forKey: UserPreferencesKeys.General.languageCode) == "hi" {
                cell.lblLanguage.text = "हिन्दी"
            } else {
                cell.lblLanguage.text = "English"
            }
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(with: cellSetting.self, for: indexPath)
            
            var desc : String = ""
            if self.arrSource[indexPath.row].type == SettingType.appearance.rawValue,
               let mode = UserDefaults.standard.value(forKey: UserPreferencesKeys.General.appearanceMode) as? Int,
               let appearanceMode = AppearanceType(rawValue: mode) {
                desc = appearanceMode.displayString
            }
            
            cell.configureCell(strTitle: arrSource[indexPath.row].title, strImg: arrSource[indexPath.row].img, desc: desc)
            return cell
        }
    }
}

//MARK: Button Action
extension SettingTableViewDataSourceDelegate {
    
    @objc func btnLanguageTapped(sender: UIButton) {
        
        let cell = scrlView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as? SettingTableViewCell
        if UserPreferences.string(forKey: UserPreferencesKeys.General.languageCode) == "hi" {
            cell?.lblLanguage.text = "हिन्दी"
        } else {
            cell?.lblLanguage.text = "English"
        }
        
        let language = self.arrLanguageSelection.map({ $0.title })
        
        StringPickerViewController.show(pickerType: .single, initialSelection: cell?.lblLanguage.text, arrSource: [language], doneAction: { (rows, value) in

            cell?.lblLanguage.text = getString(anything: value)
            let index = rows[0]
            let lang_culture = self.arrLanguageSelection[index].culture
            UserPreferences.set(value: lang_culture, forKey: UserPreferencesKeys.General.languageCode)
            LocalizationParam.getInstance.localizationCode = LanguageCodes(rawValue: lang_culture) ?? LanguageCodes.english
            self.changeLanguage?()
            IQKeyboardManager.shared.toolbarDoneBarButtonItemText = .LanguageLocalisation.done
            IQKeyboardManager.shared.enable = true
            self.scrlView.reloadData()
            
        }, animated: true, origin: sender)
        
    }
}
