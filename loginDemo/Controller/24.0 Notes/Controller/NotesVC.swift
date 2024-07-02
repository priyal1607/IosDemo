//
//  NotesVC.swift
//  loginDemo
//
//  Created by Priyal on 04/10/23.
//

import UIKit
import SideMenu

class NotesVC: HeaderViewController {

    @IBOutlet weak var lblRecords: UILabel!
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var collView: UICollectionView!
    var notesDataSourceDelegate : NotesDataSourceDelegate!
    var selBookMarkDelegate : SelBookMarkDelegate!
    var arrBookmark : [book_mark_model] = []
    var arr : [String] = []
    var arrTitle : [String] = []
    var arrTitleWithOutDuplicate : [String] = []
    var filterBookMarkList : [book_mark_model] = []
    var filterTitle: String = ""
    var isfromDelete : Bool = false
    var type : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHeader()
        setData()
        setupnewscolView()
        updateCountLabel()
        // Do any additional setup after loading the view.
    }
    func updateCountLabel() {
        if filterBookMarkList.count > 0 {
            lblRecords.isHidden = false
            btnFilter.isHidden = false
          
        } else {
            lblRecords.isHidden = true
            btnFilter.isHidden = true
        }
        let data = filterBookMarkList.count
        lblRecords.text = getString(anything: data) + " Records"
        }
    
    func setData() {
        if isfromDelete == true && filterBookMarkList.count != 0 {
            setupTblView()
            isfromDelete = false
        } else {
            self.arrBookmark = DBOperation.getInstance().bookmark_list()
            filterBookMarkList = arrBookmark
            for i in filterBookMarkList {
                arrTitle.append(i.type)
            }
            let arr = Set(arrTitle)
            arrTitleWithOutDuplicate = Array(arr)
            
            setupTblView()
        }
    }
    func setUpHeader() {
        self.setUpHeaderTitle(strHeaderTitle: "MY MEA".localizedString)
        self.viewHeader.lblHeaderTitle.textColor = .white
        self.setHeaderView_MenuImage()
      
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
    
    fileprivate func setupnewscolView() {
       
        if self.notesDataSourceDelegate == nil {
            self.notesDataSourceDelegate = .init(arrData: arr, delegate: self, scrl: collView)
        }
        else{
            self.notesDataSourceDelegate.reloadData(arrData: arr)
        }
    }
    fileprivate func setupTblView() {
       
        if self.selBookMarkDelegate == nil {
            self.selBookMarkDelegate = .init(arrData: filterBookMarkList, delegate: self, tbl: tblView)
            self.selBookMarkDelegate.compdelete = { [self]tag in
                    if DBOperation.getInstance().deleteBookmark(id: self.filterBookMarkList[tag].id) {
                        var selId = filterBookMarkList[tag].id
                        var count = -1
                        for i in arrBookmark{
                            count = count + 1
                            if i.id == selId {
                                print(count)
                                break
                            }
                        }
                        self.arrBookmark.remove(at: count)
                        self.filterBookMarkList.remove(at: tag)
                        //self.arrBookmark.remove(at: tag)
                        isfromDelete = true
                       self.setData()
                       self.setupTblView()
//                        if (self.filterBookMarkList.count > 0) {
//                            self.tblView.backgroundView = nil
//                        } else {
//                            self.tblView.backgroundView = UIView.makeNoRecordFoundView(frame: self.tblView.bounds, msg: "No Records Found")
//                        }
                    }
                
                }
            
            updateCountLabel()
            //self.arrBookmark = DBOperation.getInstance().bookmark_list()
             //filterBookMarkList = arrBookmark
        }
        else {
            self.selBookMarkDelegate.reloadData(arr: filterBookMarkList)
            
            updateCountLabel()
        }
    }
    @IBAction func btnFilterAction(_ sender: UIButton) {
        
        guard self.arrBookmark.count > 0 else { return }
        
        let alertcontroller = UIAlertController.init(title: "", message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction.init(title: "cancel", style: .cancel, handler: nil)
        alertcontroller.addAction(cancel)
        
        let tblMore = TableActionSheetViewController.instantiate(appStoryboard: .tableActonSheet)
        alertcontroller.setValue(tblMore, forKey: "contentViewController")
        tblMore.tableView.backgroundColor = UIColor.clear
        tblMore.tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tblMore.arrnames = self.arrBookmark.map({ $0.type }).squeezed
        tblMore.arrnames.insert("All".localizedString.uppercased(), at: 0)
        tblMore.index = tblMore.arrnames.firstIndex(of: self.filterTitle)
        if tblMore.index == nil {
            tblMore.index = 0
        }
        tblMore.selectedIndexCalled = { [self] str, index in
            print(str)
            type = str
            
            if str == "All".localizedString.uppercased() {
                self.filterBookMarkList = self.arrBookmark.reversed()
                self.filterTitle = ""
            } else {
                self.filterBookMarkList = self.arrBookmark.filter({ $0.type == str }).reversed()
                self.filterTitle = str
            }
            self.setupTblView()
        }
        
        tblMore.clearAllCalled = { isClear in
            print(isClear)
            if isClear {
                self.filterBookMarkList = self.arrBookmark.reversed()
                self.filterTitle = ""
                self.setupTblView()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if IS_IPAD {
                alertcontroller.popoverPresentationController?.sourceView = sender
                alertcontroller.popoverPresentationController?.sourceRect = sender.bounds
            }
            self.present(alertcontroller, animated: true, completion: nil)
        }
    }
    
}
extension NotesVC : ColViewDelegate {
    func didSelect(colView: UICollectionView, indexPath: IndexPath) {
        let vc = MEAnotes.instantiate(appStoryboard: .Notes1)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension NotesVC : TblViewDelegate {
    
}
