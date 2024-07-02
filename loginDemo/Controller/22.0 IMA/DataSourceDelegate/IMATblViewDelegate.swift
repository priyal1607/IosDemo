//
//  IMATblViewDelegate.swift
//  loginDemo
//
//  Created by Priyal on 29/09/23.
//

import Foundation
import UIKit

class IMATblViewDelegate : NSObject {
    typealias TblView = UITableView
    typealias Delegate = TblViewDelegate
    
    //MARK:- Variables
    internal var arrSource: [String]
    internal var tblView: UITableView
    internal var delegate: TblViewDelegate
 
    
    //MARK:- Initializers
    required init(arrData: [String],delegate: TblViewDelegate, tbl: UITableView) {
        arrSource = arrData
        tblView = tbl
        self.delegate = delegate
        super.init()
        tblView.delegate = self
        tblView.dataSource = self
        registerCell()
    }
    
    internal func registerCell() {
        let cellTypes: [UITableViewCell.Type] = [IMATblViewCell.self]
        tblView.register(cellTypes: cellTypes)
        //        tblView.contentInset = UIEdgeInsets(top: topBottomInsets, left: 0, bottom: topBottomInsets, right: 0)
    }
    
    func reloadData(arr:[String]) {
        arrSource = arr
        tblView.reloadData()
        
        if (arrSource.count > 0) {
            tblView.backgroundView = nil
        } else {
            tblView.backgroundView = UIView.makeNoRecordFoundView(frame: tblView.bounds, msg: .LanguageLocalisation.no_record_found)
        }
    }
    
    
}
extension IMATblViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.didSelect?(tbl : tableView, indexPath: indexPath)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        delegate.willDisplay?(tbl: tableView, atIndexPath: indexPath)
    }
}

//MARK:- UITableViewDataSource Methods
extension IMATblViewDelegate: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(with: IMATblViewCell.self, for: indexPath)
        Cell.configureCell()
        Cell.imgCircle.tintColor = .lightGray
        //Cell.setCustomCornerRadius(radius: 10)
        //Cell.mainView.setCustomCornerRadius(radius: 10)
        //Cell.mainView.addShadow()
        Cell.addShadow()
       // Cell.lblTitle.text = "Brief On Foreign Relations"
        
       
        //Cell.addShadow()
        //Cell.setCustomCornerRadius(radius: 10)
        //Cell.mainView.setCustomCornerRadius(radius: 10)
        return Cell
    }
}

