//
//  demoTblViewDelegate.swift
//  loginDemo
//
//  Created by Priyal on 15/04/24.
//

import Foundation
import UIKit

class demoTblViewDelegate: NSObject {
    
    typealias T = String
    typealias tbl = UITableView
    typealias del = TblViewDelegate
    typealias vc = UIViewController
    
    internal var arrSource: [T]
    internal var tblvw: tbl
    internal var delegate: del
    internal var vc: vc?
    
    
    //MARK:- Initializers
    required init(arrData: [T], delegate: del, tbl: tbl, vc: vc) {
        arrSource = arrData
        tblvw = tbl
        self.delegate = delegate
        self.vc = vc
        super.init()
        setupTbl()
    }
    
    fileprivate func setupTbl(){
        tblvw.register(cellType: tblViewCell.self)
        tblvw.dataSource = self
        tblvw.delegate = self
        setUpBackgroundView()
        self.tblvw.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tblvw.reloadData()
        
    }
    
    func reload(arr:[T ]){
        arrSource = arr
        setUpBackgroundView()
        tblvw.reloadData()
        
    }
    
    private func setUpBackgroundView() {
        if (self.arrSource.count > 0) {
            self.tblvw.backgroundView = nil
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.tblvw.backgroundView = UIView.makeNoRecordFoundView(frame: self.tblvw.bounds, msg: "No records found")
            }
        }
    }
}

extension demoTblViewDelegate:UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.didSelect?(tbl: tblvw, indexPath: indexPath)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        delegate.willDisplay?(tbl: tblvw, atIndexPath: indexPath)
    }
}
extension demoTblViewDelegate:UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "title"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: tblViewCell.self, for: indexPath)
        cell.selectionStyle = .none
        return cell
    }
}

