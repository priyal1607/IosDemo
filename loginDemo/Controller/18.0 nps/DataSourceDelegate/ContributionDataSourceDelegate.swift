//
//  ContributionDataSourceDelegate.swift
//  loginDemo
//
//  Created by Priyal on 19/09/23.
//

import Foundation
import UIKit

class ContributionDataSourceDelegate : NSObject {
    typealias TblView = UITableView
    typealias Delegate = TblViewDelegate
    
    //MARK:- Variables
    internal var contribution: Double
    internal var totalVal : Double
    internal var tblView: UITableView
    internal var delegate: TblViewDelegate
    
   
   
    
    //MARK:- Initializers
    required init(contribution:Double , totalVal : Double,delegate: TblViewDelegate, tbl: UITableView ) {
        self.contribution = contribution
        self.totalVal = totalVal
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
    
    func reloadData(contribution:Double , totalVal : Double) {
        self.contribution = contribution
        self.totalVal = totalVal
        tblView.reloadData()
    }
    
    
}
extension ContributionDataSourceDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.didSelect?(tbl : tableView, indexPath: indexPath)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        delegate.willDisplay?(tbl: tableView, atIndexPath: indexPath)
    }
}

//MARK:- UITableViewDataSource Methods
extension ContributionDataSourceDelegate: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(with: NPSTblViewCell.self, for: indexPath)
        Cell.configureCellContribution(contribution : contribution , totalVal : totalVal, index : indexPath.row)
        return Cell
    }
}

