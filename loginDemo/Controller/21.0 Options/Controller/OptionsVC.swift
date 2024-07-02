//
//  OptionsVC.swift
//  loginDemo
//
//  Created by Priyal on 26/09/23.
//

import UIKit

class OptionsVC: HeaderViewController {
    var optionsTblViewDelegate : OptionsTblViewDelegate!
    var arr : [dashboardList] = []
    var webService = bannerWebService()
    var comp: (([dashboardList]) -> ())?
   // var comp : (([dashboardList]) -> ())
   

    @IBOutlet weak var lblselCount: UILabel!
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHeader()
        setupTblView()
        updateCountLabel()
    //    getData()
        

        // Do any additional setup after loading the view.
    }
    
    func updateCountLabel() {
                let selectedCount = arr.filter { !$0.isSelected }.count
                lblselCount.text = "\(selectedCount) Selected"
        }
    override func btnBackTapped(_ sender: UIButton) {
       
        //vc.isfromsidemenu = false
        comp?(arr)
        self.navigationController?.popViewController(animated: true)
    }

    func setUpHeader() {
        self.setUpHeaderTitle(strHeaderTitle: "CUSTOMIZE DASHBOARD".localizedString)
        self.viewHeader.lblHeaderTitle.textColor = .white
      
    }
    fileprivate func setupTblView() {
        if self.optionsTblViewDelegate == nil {
            self.optionsTblViewDelegate = .init(arrData: arr, delegate: self, tbl: tblView)
            self.optionsTblViewDelegate.comp = { arr in
                self.arr = arr
                self.updateCountLabel()
                self.tblView.reloadData()
            }
        } else {
            self.optionsTblViewDelegate?.reloadData(arr: arr)
            self.updateCountLabel()
        }
    }
     

}
extension OptionsVC {
    func getData(){
        webService.getDashboardData{ list in
            self.arr = list
            self.setupTblView()
        }
    }
}
extension OptionsVC : TblViewDelegate {
    
}
