//
//  MusicPlayerDataSourceDelegate.swift
//  loginDemo
//
//  Created by Priyal on 17/08/23.
//

import Foundation
import UIKit

class MusicPlayerDataSourceDelegate: NSObject {
    
    typealias T = MusicModel
    typealias tblview = UITableView
    typealias delegate = TblViewDelegate
    
    var arr : [T]
    var tblv  : tblview
    var del : delegate
 
    
    
    init(arr : [T] , tblv : tblview , del : delegate){
        self.arr = arr
        self.tblv = tblv
        self.del = del
        super.init()
        setupTableView()
    }
    
    func reload(arr : [T]) {
        self.arr = arr
        tblv.reloadData()
    }
    
    fileprivate func setupTableView()  {
    let nib = UINib(nibName: "MusicPlayerTblCell", bundle: nil)
    tblv.register(nib, forCellReuseIdentifier: "MusicPlayerTblCell")
        tblv.delegate = self
        tblv.dataSource = self

    }
}

extension  MusicPlayerDataSourceDelegate : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.del.didSelect?(tbl: tableView, indexPath: indexPath)
    }
   
}

extension  MusicPlayerDataSourceDelegate : UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return arr.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblv.dequeueReusableCell(withIdentifier: "MusicPlayerTblCell", for: indexPath) as! MusicPlayerTblCell
        let section = indexPath.section
            cell.configCell(data: arr[indexPath.row])
        cell.layoutIfNeeded()
        cell.layoutSubviews()
        return cell
        
    }
}


