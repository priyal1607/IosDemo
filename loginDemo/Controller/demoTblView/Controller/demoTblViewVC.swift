//
//  demoTblViewVC.swift
//  loginDemo
//
//  Created by Priyal on 15/04/24.
//

import UIKit

class demoTblViewVC: UIViewController {
    var arr : [String] = ["1","2","3"]
    var demoTblViewDelegate : demoTblViewDelegate!
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTblView()
        // Do any additional setup after loading the view.
    }
    
   func  setupTblView(){
        if demoTblViewDelegate == nil {
            demoTblViewDelegate = .init(arrData: arr, delegate: self, tbl: tblView, vc: self)
        } else {
            demoTblViewDelegate.reload(arr: arr)
        }
    }
    

}
extension demoTblViewVC : TblViewDelegate {
    
}
