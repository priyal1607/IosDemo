//
//  tbl1DataSourceDelegate.swift
//  loginDemo
//
//  Created by Priyal on 15/09/23.
//

import Foundation
import UIKit

class tbl1DataSourceDelegate : NSObject {
    typealias TblView = UITableView
    typealias Delegate = TblViewDelegate
    
    //MARK:- Variables
    internal var arrSource: [NpsScheme]
    internal var tblView: UITableView
    internal var delegate: TblViewDelegate
    
   
   
    
    //MARK:- Initializers
    required init(arrData: [NpsScheme],delegate: TblViewDelegate, tbl: UITableView ) {
        arrSource = arrData
        tblView = tbl
        self.delegate = delegate
        super.init()
        tblView.delegate = self
        tblView.dataSource = self
        registerCell()
    }
    
    internal func registerCell() {
        let cellTypes: [UITableViewCell.Type] = [NPSTblViewCell.self]
        tblView.register(cellTypes: cellTypes)
        //        tblView.contentInset = UIEdgeInsets(top: topBottomInsets, left: 0, bottom: topBottomInsets, right: 0)
    }
    
    func reloadData(arr:[NpsScheme] ) {
        arrSource = arr
        tblView.reloadData()
        
        if (arrSource.count > 0) {
            tblView.backgroundView = nil
        } else {
            tblView.backgroundView = UIView.makeNoRecordFoundView(frame: tblView.bounds, msg: .LanguageLocalisation.no_record_found)
        }
    }
    
    
}
extension tbl1DataSourceDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.didSelect?(tbl : tableView, indexPath: indexPath)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        delegate.willDisplay?(tbl: tableView, atIndexPath: indexPath)
    }
}

//MARK:- UITableViewDataSource Methods
extension tbl1DataSourceDelegate: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(with: NPSTblViewCell.self, for: indexPath)
        Cell.configureCell(data: arrSource[indexPath.row] , index : indexPath.row)
        return Cell
    }
}

