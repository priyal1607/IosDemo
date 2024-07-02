//
//  BookMarkVC.swift
//  loginDemo
//
//  Created by Priyal on 17/10/23.
//

import UIKit
import SideMenu

class BookMarkVC: HeaderViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tblView: UITableView!
    var ar : [book_mark_model] = []
    var bookmarkarray : [String] = []
    fileprivate var bookMarkDataSourceDelegate : BookMarkDataSourceDelegate!
    fileprivate var webService = BookMarkWebService()
    var arr : [book_mark_model] = []
    var color : String = ""
    var titles : String = ""
    var typeId : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        getBookMarkList()
        setUpHeader()
        lblTitle.text = titles
        if titles == "Speeches & Statements" {
            webService.id = 51
            typeId = 51
        }
        else if titles == "Medis briefings" {
            webService.id = 50
            typeId = 50
        }
        else if titles == "response To MediaQueries" {
            webService.id = 69
            typeId = 69
        } else {
            webService.id = 53
            typeId = 53
        }
        print(titles)
        //lblTitle.textColor = UIColor.init(hexStringToUIColor: color)
    
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        getBookMarkList()
    }

    func setUpHeader() {
        self.setUpHeaderTitle(strHeaderTitle: "MY MEA".localizedString)
        self.viewHeader.lblHeaderTitle.textColor = .white
      
    }
    func getBookMarkList(){
        self.ar = DBOperation.getInstance().bookmark_list()
        for i in ar {
            bookmarkarray.append(i.id)
        }
        UserDefaults.standard.set(bookmarkarray, forKey: "myArray")
    }
 
    
    func setUpTblView(){
        if self.bookMarkDataSourceDelegate == nil {
            self.bookMarkDataSourceDelegate = .init(arrData: arr, delegate: self, tbl: tblView , color : color , typeId : typeId)
        } else {
            self.bookMarkDataSourceDelegate?.reloadData(arr: arr ,  color : color , typeId : typeId)
        }
    }

}
extension BookMarkVC : TblViewDelegate {
    func didSelect(tbl: UITableView, indexPath: IndexPath) {
        
    }
    
}
extension BookMarkVC {
    func getData(){
        getBookMarkList()
        CustomActivityIndicator.sharedInstance.showIndicator(view: self.view)
        if titles == "Speeches & Statements" {
            webService.id = 51
            typeId = 51
        }
        else if titles == "Medis briefings" {
            webService.id = 50
            typeId = 50
        }
        else if titles == "response To MediaQueries" {
            webService.id = 69
            typeId = 69
        } else {
            webService.id = 53
            typeId = 53
        }
        webService.getMediaCenter { list in
            self.arr = list
            self.setUpTblView()
            CustomActivityIndicator.sharedInstance.hideIndicator(view: self.view)
        }
    }
}
