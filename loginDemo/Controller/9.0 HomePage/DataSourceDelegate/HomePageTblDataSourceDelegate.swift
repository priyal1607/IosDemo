//
//  HomePageTblDataSourceDelegate.swift
//  loginDemo
//
//  Created by Chelsi on 24/05/23.
//

import Foundation
import UIKit
class HomePageTblDataSourceDelegate : NSObject {
    
    typealias tblview = UITableView
    typealias delegate = TblViewDelegate
    
    var arr : [String]
    var tblv  : tblview
    var del : delegate

    init( arr:[String],tblv : tblview , del : delegate){
        self.arr = arr
        self.tblv = tblv
        self.del = del
        super.init()
        setupTableView()
    }
    
    func reload(arr : [String]) {
        self.arr = arr
        tblv.reloadData()
    }
    
    
    
    fileprivate func setupTableView(){
        let nib = UINib(nibName: "HomePageTblVC", bundle: nil)
        tblv.register(nib, forCellReuseIdentifier: "HomePageTblVC")
        tblv.delegate = self
        tblv.dataSource = self
    }
}
extension HomePageTblDataSourceDelegate : UITableViewDelegate {
}
extension HomePageTblDataSourceDelegate :UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomePageTblVC", for: indexPath) as! HomePageTblVC
        cell.configcell(data: arr[indexPath.row])
            return cell
        }
    }


