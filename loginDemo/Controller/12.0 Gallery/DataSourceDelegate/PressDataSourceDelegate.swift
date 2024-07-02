//
//  PressDataSourceDelegate.swift
//  loginDemo
//
//  Created by Priyal on 03/07/23.
//
import Foundation
import UIKit

class PressDataSourceDelegate : NSObject {
    typealias TblView = UITableView
    typealias Delegate = TblViewDelegate
    
    //MARK:- Variables
    internal var arrSource: [PressReleaseResult]
    internal var tblView: UITableView
    internal var delegate: TblViewDelegate
    internal var imgURL: String
    
    //MARK:- Initializers
    required init(arrData: [PressReleaseResult],delegate: TblViewDelegate, tbl: UITableView,imgURL:String) {
        arrSource = arrData
        tblView = tbl
        self.delegate = delegate
        self.imgURL = imgURL
        super.init()
        tblView.delegate = self
        tblView.dataSource = self
        registerCell()
    }
    
    internal func registerCell() {
        let cellTypes: [UITableViewCell.Type] = [PressTblViewCell.self]
        tblView.register(cellTypes: cellTypes)
        //        tblView.contentInset = UIEdgeInsets(top: topBottomInsets, left: 0, bottom: topBottomInsets, right: 0)
    }
    
    func reloadData(arr:[PressReleaseResult],imgURL:String) {
        arrSource = arr
        self.imgURL = imgURL
        tblView.reloadData()
        
        if (arrSource.count > 0) {
            tblView.backgroundView = nil
        } else {
            tblView.backgroundView = UIView.makeNoRecordFoundView(frame: tblView.bounds, msg: .LanguageLocalisation.no_record_found)
        }
    }
    
    
}
extension PressDataSourceDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.didSelect?(tbl : tableView, indexPath: indexPath)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        delegate.willDisplay?(tbl: tableView, atIndexPath: indexPath)
    }
}

//MARK:- UITableViewDataSource Methods
extension PressDataSourceDelegate: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(with: PressTblViewCell.self, for: indexPath)
        Cell.configurePressReleaseCell(data: arrSource[indexPath.row], imgUrl: imgURL)
        return Cell
    }
}

