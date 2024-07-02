////
////  tbl2DataSourceDelegate.swift
////  loginDemo
////
////  Created by Priyal on 15/09/23.
////
//
import Foundation
import UIKit

class tbl2DataSourceDelegate : NSObject {
    typealias TblView = UITableView
    typealias Delegate = TblViewDelegate
    
    //MARK:- Variables
    internal var arrSource: [NpsScheme]
    internal var tblView: UITableView
    internal var delegate: TblViewDelegate
    internal var total : Double
   
    
    //MARK:- Initializers
    required init(arrData: [NpsScheme],delegate: TblViewDelegate, tbl: UITableView , total : Double) {
        arrSource = arrData
        self.total = total
        tblView = tbl
        self.delegate = delegate
        super.init()
        tblView.delegate = self
        tblView.dataSource = self
        registerCell()
    }
    
    internal func registerCell() {
        let cellTypes: [UITableViewCell.Type] = [NPSTblViewCell.self , NPSTblViewCell2.self]
        tblView.register(cellTypes: cellTypes)
        //        tblView.contentInset = UIEdgeInsets(top: topBottomInsets, left: 0, bottom: topBottomInsets, right: 0)
    }
    
    func reloadData(arr:[NpsScheme] , total : Double) {
        arrSource = arr
        self.total = total
        tblView.reloadData()
        
        if (arrSource.count > 0) {
            tblView.backgroundView = nil
        } else {
            tblView.backgroundView = UIView.makeNoRecordFoundView(frame: tblView.bounds, msg: .LanguageLocalisation.no_record_found)
        }
    }
    
    
}
extension tbl2DataSourceDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.didSelect?(tbl : tableView, indexPath: indexPath)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        delegate.willDisplay?(tbl: tableView, atIndexPath: indexPath)
    }
}

//MARK:- UITableViewDataSource Methods
extension tbl2DataSourceDelegate: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSource.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(with: NPSTblViewCell2.self, for: indexPath)
        var index : Int = 0
        if indexPath.row == 0 {
             index = indexPath.row - 2
        } else {
             index = indexPath.row - 1
        }
        if index == -2 {
            Cell.confifcell1()
        } else if index == arrSource.count   {
            Cell.confifcell2(total: total)
        } else {
            Cell.configureCell(data: arrSource[index] , index : index )
        }
        return Cell
    }
}

