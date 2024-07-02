//
//  IMAVC.swift
//  loginDemo
//
//  Created by Priyal on 28/09/23.
//

import UIKit
import SideMenu

class IMAVC: HeaderViewController {
    @IBOutlet weak var collView: UICollectionView!
    var IMAcollViewDelegate : IMAcollViewDelegate!
    var IMATblViewDelegate : IMATblViewDelegate!
    var arr : [String] = []
    
    @IBOutlet weak var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupnewscolView()
        setupnewsTblView()
        setUpHeader()
        //imgView.backgroundColor = UIColor(hexStringToUIColor: "9EF3E4")
        // Do any additional setup after loading the view.
    }
    override func btnBackTapped(_ sender: UIButton) {
        if let menuLeftNavigationController = SideMenuManager.default.leftMenuNavigationController {
            if menuLeftNavigationController.presentingViewController != nil {
                menuLeftNavigationController.dismiss(animated: false) {
                    self.present(menuLeftNavigationController, animated: true, completion: nil)
                }
            } else {
                self.present(menuLeftNavigationController, animated: true, completion: nil)
            }
        }
    }
    func setUpHeader() {
        self.setUpHeaderTitle(strHeaderTitle: "INDIAN MISSION ABROAD".localizedString)
        self.viewHeader.lblHeaderTitle.textColor = .white
        self.setHeaderView_MenuImage()
      
    }
    fileprivate func setupnewscolView() {
       
        if self.IMAcollViewDelegate == nil {
            self.IMAcollViewDelegate = .init(arrData: arr, delegate: self, scrl: collView)
        }
        else{
            self.IMAcollViewDelegate.reloadData(arrData: arr)
        }
    }
    fileprivate func setupnewsTblView() {
       
        if self.IMATblViewDelegate == nil {
            self.IMATblViewDelegate = .init(arrData: arr, delegate: self, tbl: tblView)
        }
        else{
            self.IMATblViewDelegate.reloadData(arr: arr)
        }
    }
    
    
}
extension IMAVC : ColViewDelegate {
    func didSelect(colView: UICollectionView, indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = MapVC.instantiate(appStoryboard: .map)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
extension IMAVC : TblViewDelegate {
    
}
