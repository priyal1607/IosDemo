//
//  SelBookMarkDelegate.swift
//  loginDemo
//
//  Created by Priyal on 19/10/23.
//

import Foundation
import UIKit

class SelBookMarkDelegate : NSObject {
    typealias TblView = UITableView
    typealias Delegate = TblViewDelegate
    var comp: ((Int) -> ())?
    var compdelete: ((Int) ->())?
 
    //var updateAddNotesCalled : ((String) -> Void)?
    //MARK:- Variables
    var arrSource: [book_mark_model]
    internal var tblView: UITableView
    internal var delegate: TblViewDelegate
    
    
    //MARK:- Initializers
    required init(arrData: [book_mark_model],delegate: TblViewDelegate, tbl: UITableView ) {
        arrSource = arrData
        tblView = tbl
        self.delegate = delegate
        tblView.dragInteractionEnabled = true
        super.init()
        tblView.delegate = self
        tblView.dataSource = self
        registerCell()
        if (arrSource.count > 0) {
            
            tblView.backgroundView = nil
        } else {
            tblView.backgroundView = UIView.makeNoRecordFoundView(frame: tblView.bounds, msg: "No Records Found")
        }
        
    }
    @objc func onClickDelete(_ sender:UIButton){
//        let button = UIButton()
//            let tag = button.tag
        UserDefaults.standard.setValue(arrSource.count, forKey: "countRecords")
        compdelete!(sender.tag)
    }
    internal func registerCell() {
        let cellTypes: [UITableViewCell.Type] = [SelBookMarkTblViewCell.self]
        tblView.register(cellTypes: cellTypes)
    }
   
    
    func reloadData(arr:[book_mark_model]) {
        arrSource = arr
        tblView.reloadData()
        
        if (arrSource.count > 0) {
            
            tblView.backgroundView = nil
        } else {
            tblView.backgroundView = UIView.makeNoRecordFoundView(frame: tblView.bounds, msg: "No Records Found")
        }
    }
    
}
extension SelBookMarkDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate.didSelect?(tbl: tableView, indexPath: indexPath)
    }
   
}

//MARK:- UITableViewDataSource Methods
extension SelBookMarkDelegate: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSource.count
    }
            
                
                    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(with: SelBookMarkTblViewCell.self, for: indexPath)
        Cell.configCell(data: arrSource[indexPath.row])
        Cell.btnBookmark.tintColor = UIColor.init(hexStringToUIColor: arrSource[indexPath.row].color)
        Cell.bgView.backgroundColor = UIColor.init(hexStringToUIColor: arrSource[indexPath.row].color)
        Cell.typeView.backgroundColor = UIColor.init(hexStringToUIColor: arrSource[indexPath.row].color)
        Cell.btnBookmark.tag = indexPath.row
        Cell.btnBookmark.addTarget(self, action: #selector(onClickDelete), for: .touchUpInside)
//        Cell.btnDelete.addTarget(self, action: #selector(onClickDelete), for: .touchUpInside)
        return Cell
        }
    
}
