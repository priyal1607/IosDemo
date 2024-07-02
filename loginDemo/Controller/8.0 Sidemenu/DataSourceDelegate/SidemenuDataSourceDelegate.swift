//
//  TblViewDataSourceDelegate.swift
//  loginDemo
//
//  Created by Chelsi on 11/05/23.
//

import UIKit
class SidemenuDataSourceDelegate : NSObject {
    
    typealias tblview = UITableView
    typealias delegate = TblViewDelegate
    
    var arr : [SideMenuModel]
    var tblv  : tblview
    var del : delegate
    fileprivate var selectedSection: IndexPath?
    var tblViewDataSourceDelegate:SidemenuDataSourceDelegate?
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            UIColor(red: 17/255, green: 28/255, blue: 79/255, alpha: 1).cgColor,
            UIColor(red: 53/255, green: 30/255, blue: 148/255, alpha: 1).cgColor,
        ]
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        return gradient
    }()
    
    
    
    
    init( arr:[SideMenuModel],tblv : tblview , del : delegate){
        self.arr = arr
        self.tblv = tblv
        self.del = del
        super.init()
        setupTableView()
    }
    
    func reload(arr : [SideMenuModel] , selectedSection : IndexPath) {
        self.arr = arr
        self.selectedSection = selectedSection
        tblv.reloadData()
    }
    
    
    
    fileprivate func setupTableView(){
        let nib = UINib(nibName: "SidemenuTblViewCell", bundle: nil)
        let nib1 = UINib(nibName: "MoreOptionTblViewCell", bundle: nil)
        tblv.register(nib, forCellReuseIdentifier: "SidemenuTblViewCell")
        tblv.register(nib1, forCellReuseIdentifier: "MoreOptionTblViewCell")
        tblv.delegate = self
        tblv.dataSource = self
    }
}

extension SidemenuDataSourceDelegate : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.del.didSelect?(tbl: tblv, indexPath: indexPath)
    }
}
extension SidemenuDataSourceDelegate :UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let aMenuItems = arr[section]
        if let expandableArrCount = selectedSection,expandableArrCount.section == section {
            if aMenuItems.MoreOptions.count > 0 {
                return aMenuItems.MoreOptions.count + 1
            }
        }
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aMenuOptionData = arr[indexPath.section]
        if (indexPath.row == 0) {
            let aMenuItenCell = tableView.dequeueReusableCell(withIdentifier: "SidemenuTblViewCell", for: indexPath) as! SidemenuTblViewCell
            if let aSelectedIndex = selectedSection,indexPath == aSelectedIndex {
                aMenuItenCell.configcell(data: aMenuOptionData)
            } else {
                aMenuItenCell.configcell(data: aMenuOptionData)
            }
            if arr.count-1 == indexPath.section {
                aMenuItenCell.sepView.isHidden = true
            }
            
            return aMenuItenCell
        } else {
            let aSubMenuCell = tableView.dequeueReusableCell(withIdentifier: "MoreOptionTblViewCell", for: indexPath) as! MoreOptionTblViewCell
            aSubMenuCell.configureCell(aMenuOptionData: aMenuOptionData, indexPath: indexPath)
            return aSubMenuCell
        }
    }
   
}
