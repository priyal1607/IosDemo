//
//  TablePickerViewController.swift
//  CIC1
//
//  Created by Vikram Jagad on 30/01/18.
//  Copyright © 2018 Vikram Jagad. All rights reserved.
//

import UIKit



typealias TablePickerDoneActionloc = (_ selectedloc:String, _ selectedid:[String],_ selectedIndex:Int) -> Bool

enum TablePickerSelectionType: Int {
    case single = 0
    case multiple
}

class TablePickerViewController: UIViewController {

    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var roundRectShadowView: UIView!
    @IBOutlet weak var roundRectView: UIView!
    @IBOutlet weak var headerLblView: UIView!
    @IBOutlet weak var headerSearchView: UIView!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var pickerTableView: UITableView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var doneBtn: UIButton!
    
    @IBOutlet weak var txtSearch: UITextField!
    
    @IBOutlet weak var roundRectViewHeightConstraint: NSLayoutConstraint!
    var arraySelectionIds: [String] = []
    var arrayData: [DropDownModel] = []
    var indexpath = 0
    fileprivate var origanlArrayData: [DropDownModel] = []
    var strHeaderTitle: String = ""
    //var tablePickerDoneAction1: TablePickerDoneAction1?
    private var tablePickerDoneActionloc:TablePickerDoneActionloc?
    var selectionType: TablePickerSelectionType = .single
    var selectToDeselectAllRow : DropDownModel?
    var selectedLocation = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpIPadConstraint()
        setUpView()
        setUpTableView()
        origanlArrayData = arrayData
        pickerTableView.scrollToRow(at: IndexPath(row: indexpath, section: 0), at: .middle, animated: false)
        //doneBtn.isEnabled = self.arraySelectionIds.count > 0
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.heightCalculate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.heightCalculate()
        
        pickerTableView.scrollToRow(at: IndexPath(row: indexpath, section: 0), at: .middle, animated: false)
    }
    
    private func heightCalculate() {
        let tblViewHeight = pickerTableView.contentSize.height
        let otherViewHeight = headerLblView.frame.height + cancelBtn.frame.height + 86 + (self.txtSearch.superview?.frame.height ?? 45)
        
        let maxHeight = SCREEN_HEIGHT - bottomMarginFromSafeArea - STATUS_BAR_HEIGHT
        
        if (tblViewHeight > maxHeight) {
            roundRectViewHeightConstraint.constant = maxHeight - 20
        } else {
            roundRectViewHeightConstraint.constant = pickerTableView.contentSize.height + otherViewHeight
        }
        
        setUpBackgroundView()
    }
    
    private func setUpBackgroundView() {
        if (self.arrayData.count > 0) {
            self.pickerTableView.backgroundView = nil
        } else {
            self.pickerTableView.backgroundView = UIView.makeNoRecordFoundView(frame: self.pickerTableView.bounds, msg: .LanguageLocalisation.no_record_found)
        }
    }
    
    fileprivate func setUpIPadConstraint() {
        changeLeadingTrailingForiPad(view: viewMain)
        changeHeightForiPad(view: headerLblView)
        changeHeightForiPad(view: cancelBtn)
    }
    
    func setUpView() {
        
        headerSearchView.setCustomCornerRadius(radius: 10.0)
        headerSearchView.backgroundColor = .gray .withAlphaComponent(0.5)
        changeHeightForiPad(view: txtSearch)
        txtSearch.delegate = self
        txtSearch.font = .regularSystemFont(withSize: .value)
        txtSearch.clearButtonMode = .whileEditing
        txtSearch.setAttributtedPlaceHolder(text: .LanguageLocalisation.search, ofColor: .gray, font: .regularSystemFont(withSize: .value))
        
        headerLblView.backgroundColor = .blue//kColor_HeaderCenter
        headerLbl.text = strHeaderTitle
        headerLbl.textColor = .customWhite
        headerLbl.font = .semiBoldSystemFont(withSize: .large)
        
        changeHeightForiPad(view: headerLbl, constant: 10)
        
        roundRectView.setCustomCornerRadius(radius: 10.0)
        roundRectShadowView.setCustomCornerRadius(radius: 10)
        
        cancelBtn.setTitle(.LanguageLocalisation.cancel, for: .normal)
        cancelBtn.titleLabel?.font = .regularSystemFont(withSize: .medium)
            if #available(iOS 13, *) {
                cancelBtn.setCustomCornerRadius(radius: 8.0, borderColor: .systemGray, borderWidth: 1.0)//viewWith(radius: 8, borderColor: .systemGray, borderWidth: 1)
                cancelBtn.setTitleColor(.systemGray, for: .normal)
            } else {
                cancelBtn.setCustomCornerRadius(radius: 8.0, borderColor: .gray, borderWidth: 1.0)//.viewWith(radius: 8, borderColor: .gray, borderWidth: 1)
                cancelBtn.setTitleColor(.gray, for: .normal)
            }
        
        doneBtn.setTitle(.LanguageLocalisation.done, for: .normal)
        doneBtn.setTitleColor(UIColor.white, for: .normal)
        doneBtn.backgroundColor = .blue
        doneBtn.setCustomCornerRadius(radius: 8.0)
        doneBtn.titleLabel?.font = .regularSystemFont(withSize: .medium)
        if #available(iOS 13.0, *) {
            view.addVibrancyEffect(withEffect: .systemUltraThinMaterial, bringSubViewToFrontView: viewMain)
        } else {
            view.addVibrancyEffect(bringSubViewToFrontView: viewMain)
        }
    }
    
    /*func setTablePickerDoneAction(tablePickerDoneAction: @escaping TablePickerDoneAction1){
        self.tablePickerDoneAction1 = tablePickerDoneAction
    }*/
    
    func setTablePickerDoneActionLoc(tablePickerDoneActionloc: @escaping TablePickerDoneActionloc){
        self.tablePickerDoneActionloc = tablePickerDoneActionloc
    }
    
    
    @IBAction func cancelBtn(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func doneBtn(_ sender: Any) {
//        tablePickerDoneAction1?(arraySelectionIds)
        if !self.arraySelectionIds.isEmpty {
        if tablePickerDoneActionloc?(selectedLocation,self.arraySelectionIds, indexpath) ?? false {
            self.dismiss(animated: false, completion: nil)
        }
        } else {
            if selectedLocation.isStringEmpty || selectedLocation == .LanguageLocalisation.select {
                self.view.showBanner(message:"Please select a plot")
            }
        }
    }
}

extension TablePickerViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.text = ""
        searchData(with: "")
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let fullString = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
        searchData(with: fullString.trimming_WS_NL)
        return true
    }
    
    func searchData(with string: String) {
        if string.count > 0 {
            arrayData = origanlArrayData.filter({ $0.title.lowercased().contains(string.lowercased()) })
        } else {
            arrayData = origanlArrayData
        }
        pickerTableView.reloadData()
        heightCalculate()
    }
    
}

extension TablePickerViewController: UITableViewDelegate, UITableViewDataSource{
    
    func setUpTableView() {
        pickerTableView.register(UINib(nibName: "popupTblViewCell", bundle: nil), forCellReuseIdentifier: "popupTblViewCell")
        pickerTableView.dataSource = self
        pickerTableView.delegate = self
        pickerTableView.estimatedRowHeight = 50
        pickerTableView.rowHeight = UITableView.automaticDimension
        pickerTableView.tableFooterView = UIView()
        pickerTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: popupTblViewCell.self, for: indexPath)
        
        cell.lblTitle?.text = self.arrayData[indexPath.row].title
        cell.lblTitle.textColor = .customBlack
        cell.lblTitle.font = .regularSystemFont(withSize: .value)
        
        if arraySelectionIds.count > 0 {
            if arraySelectionIds.contains(where: { (id) -> Bool in
                id == arrayData[indexPath.row].id
            }) {
                cell.imgSelection.image = UIImage (named: "isselectedremember")
                cell.imgSelection.tintColor = .black
            } else {
                cell.imgSelection.image = UIImage (named: "notselectedrem")
                
                cell.imgSelection.tintColor = .gray
                if let deselectId = selectToDeselectAllRow?.id,
                   arraySelectionIds.contains(where: { $0 == deselectId }) {
                    cell.lblTitle.textColor = .gray
                }
            }
        } else {
            cell.imgSelection.image = UIImage (named: "isselectedremember")
            
            cell.imgSelection.tintColor = .gray
            if let deselectId = selectToDeselectAllRow?.id,
               arraySelectionIds.contains(where: { $0 == deselectId }) {
                cell.lblTitle.textColor = .gray
            }
        }
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch selectionType {
        case .single:
            if (arraySelectionIds.count == 0) {
                arraySelectionIds.append(arrayData[indexPath.row].id)
            } else {
                let tempArr = arraySelectionIds.filter { (id) -> Bool in
                    (getString(anything: id) != getString(anything: arrayData[indexPath.row].id))
                }
                if tempArr.count > 0 {
                    arraySelectionIds.removeAll(where: {( getString(anything: $0) == getString(anything: tempArr[0])) })
                }
                arraySelectionIds.append(arrayData[indexPath.row].id)
            }
            selectedLocation = self.arrayData[indexPath.row].title
            indexpath = indexPath.row
            //doneBtn.isEnabled = self.arraySelectionIds.count > 0
        case .multiple:
            let tempArr = arraySelectionIds.filter { (id) -> Bool in
                (getString(anything: id) != getString(anything: arrayData[indexPath.row].id))
            }
            if (tempArr.count == arraySelectionIds.count) {
                if let deselectId = selectToDeselectAllRow?.id,
                   arraySelectionIds.contains(where: { $0 == deselectId }) {
                    pickerTableView.reloadData()
                    return
                }
                if arrayData[indexPath.row].id == selectToDeselectAllRow?.id {
                    arraySelectionIds = [arrayData[indexPath.row].id]
                } else {
                    arraySelectionIds.append(arrayData[indexPath.row].id)
                }
            } else {
                arraySelectionIds = tempArr
            }
            //doneBtn.isEnabled = self.arraySelectionIds.count > 0
        }
        pickerTableView.reloadData()
    }
}
