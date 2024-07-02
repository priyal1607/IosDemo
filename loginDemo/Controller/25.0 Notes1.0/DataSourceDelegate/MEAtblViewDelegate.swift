//
//  MEAtblViewDelegate.swift
//  loginDemo
//
//  Created by Priyal on 05/10/23.
//

import Foundation
import UIKit

class MEAtblViewDelegate : NSObject {
    typealias TblView = UITableView
    typealias Delegate = TblViewDelegate
 
    var updateAddNotesCalled : ((String) -> Void)?
    var comp: ((Int) -> ())?
    var compdelete: ((Int,UIButton) ->Void)?
    //MARK:- Variables
    var arrSource: [NotesModel]
    internal var tblView: UITableView
    internal var delegate: TblViewDelegate
    
    
    //MARK:- Initializers
    required init(arrData: [NotesModel],delegate: TblViewDelegate, tbl: UITableView ) {
        arrSource = arrData
        tblView = tbl
        self.delegate = delegate
        tblView.dragInteractionEnabled = true
        super.init()
        tblView.delegate = self
        tblView.dataSource = self
        registerCell()
        
    }
    
    internal func registerCell() {
        let cellTypes: [UITableViewCell.Type] = [MEANotesTblViewCell.self]
        tblView.register(cellTypes: cellTypes)
    }
  
    
    func reloadData(arr:[NotesModel]) {
        arrSource = arr
        tblView.reloadData()
        
        if (arrSource.count > 0) {
            tblView.backgroundView = nil
        } else {
            tblView.backgroundView = UIView.makeNoRecordFoundView(frame: tblView.bounds, msg: "No Records Found")
        }
    }
    
    @objc func onClickEdit(_ sender:UIButton){
        self.comp?(sender.tag)
    }
    @objc func onClickDelete(_ sender:UIButton){
//        let button = UIButton()
//            let tag = button.tag
        compdelete!(sender.tag, sender)
    }
    
}
extension MEAtblViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate.didSelect?(tbl: tableView, indexPath: indexPath)
    }
   
}

//MARK:- UITableViewDataSource Methods
extension MEAtblViewDelegate: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSource.count
    }
    
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(with: MEANotesTblViewCell.self, for: indexPath)
        Cell.configCell(data: arrSource[indexPath.row])
        Cell.btneditact.tag = indexPath.row
        Cell.btnDelete.tag = indexPath.row
        Cell.btneditact.addTarget(self, action: #selector(onClickEdit), for: .touchUpInside)
        Cell.btnDelete.addTarget(self, action: #selector(onClickDelete), for: .touchUpInside)
        return Cell
        }
    
}
