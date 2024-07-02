//
//  TableActionSheetViewController.swift
//  MEAIndia
//
//  Created by Gunjan on 27/07/22.
//

import UIKit
import SwiftUI

class TableActionSheetViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tblViewHeightConstraint:NSLayoutConstraint!
    
    var arrnames: [String] = []
    
    var selectedIndexCalled : ((String, Int) -> Void)?
    var clearAllCalled : ((Bool) -> Void)?
    var index:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(cellType: TableActionSheetCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 30
        self.lblTitle.textColor = .darkModeReturnVariable(.init(hexStringToUIColor: "#323232"), .init(hexStringToUIColor: "#CDCDCD"))
        self.lblTitle.font = .boldSystemFont(withSize: .medium)
        self.lblTitle.text = "Filter".localizedString
        addObserve()
    }
    
    private func addObserve() {
        tableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let obj = object as? UITableView, obj == self.tableView {
            tblViewHeightConstraint.constant = obj.contentSize.height + obj.contentInset.top + obj.contentInset.bottom
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrnames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: TableActionSheetCell.self, for: indexPath)
        
        cell.lblTitle.text = arrnames[indexPath.row]
        
        if self.index == indexPath.row {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.index != indexPath.row {
            selectedIndexCalled?(self.arrnames[indexPath.row], indexPath.row)
            self.index = indexPath.row
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func ClearAll(_ sender: Any) {
        self.clearAllCalled?(true)
        self.index = nil
        self.dismiss(animated: true, completion: nil)
    }
}
