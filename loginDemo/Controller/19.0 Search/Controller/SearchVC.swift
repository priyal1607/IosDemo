//
//  SearchVC.swift
//  loginDemo
//
//  Created by Priyal on 21/09/23.
//

import UIKit

class SearchVC: UIViewController {
    @IBOutlet weak var btnSearch: UIButton!
    
    @IBOutlet weak var recentSearchView: UIView!
    @IBOutlet weak var AuthorCollViewHeight: NSLayoutConstraint!
    @IBOutlet weak var categoryCollViewHeight: NSLayoutConstraint!
    @IBOutlet weak var categoryCollView: UICollectionView!
    @IBOutlet weak var AuthorCollView: UICollectionView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var collViewHeight: NSLayoutConstraint!
    @IBOutlet weak var collView: UICollectionView!
    var searchDataSourceDelegate : SearchDataSourceDelegate!
    var categoryDataSourceDelegate : categoryDataSourceDelegate!
    var authorDataSourceDelegate : categoryDataSourceDelegate!
    var isSearchClicked : Bool = false
    var isfromauthor : Bool = false
    var isfromcat : Bool = false
    var arrCat : [SearchModel] = []
    var arrauthor : [SearchModel] = []
    var arr : [String] = []
    var arr2 : [String] = []
    var searchString : String = ""
    var count : Int = 0
    var issel : Bool = false
    var webService = searchWebService()
   // var deleteClickedCallBack: ((IndexPath) -> ())?
    override func viewDidLoad() {
        super.viewDidLoad()
        txtSearch.delegate = self
        getData()
        addObserver()
        getRecentSearchList()
        
        //recentSearchView.isHidden = true
        
       // setupCollView()
        
        txtSearch.addTarget(self, action: #selector(txtchange(_:)), for: .editingChanged)
        //fjhhjbtnCancel.addTarget(self, action: #selector(clearText(_:)), for: .touchUpInside)
        btnSearch.addTarget(self, action: #selector(getSearch(_:)), for: .touchUpInside)
        searchView.setCustomCornerRadius(radius: 10)
        //getRecentSearchList()

        // Do any additional setup after loading the view.
    }
    private func getRecentSearchList() {
        if let getRecentSearchList = UserPreferences.array(forKey: "searcharray") as? [String],
           getRecentSearchList.count > 0 {
            arr = getRecentSearchList
            recentSearchView.isHidden = false
            setupCollView()
//            recentSearchList = getRecentSearchList.map({ SearchModel(title: $0, id: "") })
            //arr = arr.map({ $0 })
        } else {
          //  recentSearchView.isHidden = true
            arr = []
        }
        
    }
    func addObserver(){
        collView.addObserver(self, forKeyPath: "contentSize", options: [.old,.new], context: nil )
        categoryCollView.addObserver(self, forKeyPath: "contentSize", options: [.old,.new], context: nil )
        AuthorCollView.addObserver(self, forKeyPath: "contentSize", options: [.old,.new], context: nil )


    }
//    func setUpHeader(){
//        self.setUpHeaderTitle(strHeaderTitle: "NPS")
//        self.viewHeader.lblHeaderTitle.textColor = .white
//        self.setHeaderView_MenuImage()
//    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            collViewHeight.constant = collView.contentSize.height + 10
        categoryCollViewHeight.constant = categoryCollView.contentSize.height + 10
        AuthorCollViewHeight.constant = AuthorCollView.contentSize.height + 10

        
    }
//    @objc func deleteClickedCallBack(indexPath : IndexPath) {
//        self.arr.remove(at: indexPath.row)
//        let arrs = arr.map({ $0})
//        //UserPreferences.set(value: arrs)
//    }
    fileprivate func setupCollView() {
        self.collView.layoutIfNeeded()
        self.view.layoutIfNeeded()
        if self.searchDataSourceDelegate == nil {
            self.searchDataSourceDelegate = .init(arrData: arr, delegate: self, scrl: collView )
            searchDataSourceDelegate.deleteClickedCallBack = deleteClickedCallBack
        } else {
            self.searchDataSourceDelegate?.reloadData(arrData: arr)
        }
    }
    fileprivate func setupCollView2() {
        if self.categoryDataSourceDelegate == nil {
            self.categoryDataSourceDelegate = .init(arrData: arrCat, delegate: self, scrl: categoryCollView, isfromcat: true )
        } else {
            self.categoryDataSourceDelegate?.reloadData(arrData: arrCat, isfromcat: true)
        }
    }
    fileprivate func setupCollView3() {
        if self.authorDataSourceDelegate == nil {
            self.authorDataSourceDelegate = .init(arrData: arrauthor, delegate: self, scrl: AuthorCollView, isfromcat: false )
        } else {
            self.authorDataSourceDelegate?.reloadData(arrData: arrauthor, isfromcat: false)
        }
    }

    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSearchAction(_ sender: UIButton) {
        searchString = searchString.trimmingCharacters(in: .whitespacesAndNewlines)
        if searchString.count > 0 {
            recentSearchView.isHidden = false
            isSearchClicked = true
            for i in 0..<arr.count {
                if arr[i].trimmingCharacters(in: .whitespacesAndNewlines) == searchString.trimmingCharacters(in: .whitespacesAndNewlines) {
                    count += 1
                }
            }
            if count == 0 {
                arr.append(searchString)
            }
            UserDefaults.standard.set(arr, forKey: "searcharray")
            
            setupCollView()
            count = 0
        }
    }
    @objc func deleteClickedCallBack(indexPath : IndexPath) {
        self.arr.remove(at: indexPath.row)
        let searcharray = arr.map({ $0 })
       // UserPreferences.set(value: getRecentSearchList, forKey: "searcharray")
        UserDefaults.standard.set(arr, forKey: "searcharray")
        if arr.count > 0 {
            recentSearchView.isHidden = false
        } else {
            recentSearchView.isHidden = true
        }
    }
    @IBAction func btnClearAllAction(_ sender: UIButton) {
        arr.removeAll()
        UserDefaults.standard.set(arr, forKey: "searcharray")
        recentSearchView.isHidden = true
        setupCollView()
    }
}
extension SearchVC : ColViewDelegate {
    func didSelect(colView: UICollectionView, indexPath: IndexPath) {
//        var arrIndex : [IndexPath] = []
//        var arrnotsel : [IndexPath] = []
//        arrIndex.append(indexPath)
//        for i in 0...arrIndex.count - 1 {
//            colView.cellForItem(at: arrIndex[i])?.contentView.backgroundColor = .systemPink
//        }
//
//        
        
//        let cell = colView.dequeueReusableCell(with: SearchCollViewCell.self, for: indexPath)
//        cell.mainView.backgroundColor = .lightGray
        
//                if issel == false {
//                    colView.cellForItem(at: indexPath)?.contentView.backgroundColor = .systemPink
//                    issel = true
//                } else {
//                    colView.cellForItem(at: indexPath)?.backgroundColor = .white
//                    issel = false
//                }
        
}
}
extension SearchVC : UITextFieldDelegate {
    @objc func getSearch(_ sender: UIButton) {
       // getPlayerList(isSearch: true)
        txtSearch.resignFirstResponder()
    }
    
    @objc func clearText(_ selector: UIButton) {
        txtSearch.text = ""
    }
    
    @objc  func txtchange(_ txtfld:UITextField){
        //searchString = ""
        if txtfld.text == "" {
        } else if getString(anything: txtfld.text).count > 0 {
            searchString = txtfld.text ?? ""
            //btnCancel.isHidden = false
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
   
}
extension SearchVC {
    func getData(){
        webService.getCategoryData(block: {cat , author in
            self.arrCat = cat
            self.arrauthor = author
            //self.initNPSchartView(arr: valueList)
            self.setupCollView2()
            self.setupCollView3()
        })
    }
}
