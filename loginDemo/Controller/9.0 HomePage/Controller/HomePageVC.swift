//
//  HomePageVC.swift
//  loginDemo
//
//  Created by Chelsi on 24/05/23.
//

import UIKit
import SideMenu

class HomePageVC: HeaderViewController   {
    @IBOutlet weak var lblimportant: LocalizedLabel!
    @IBOutlet weak var lblFollow: LocalizedLabel!
    @IBOutlet var newsCollView: UICollectionView!
    @IBOutlet var pgControl: UIPageControl!
    @IBOutlet var NewsCollViewHeight: NSLayoutConstraint!
    @IBOutlet var tblViewHeight: NSLayoutConstraint!
    @IBOutlet var collViewHeight: NSLayoutConstraint!
    @IBOutlet var tblView: UITableView!
    @IBOutlet var collView: UICollectionView!
    var webServicesModel = NewsWebService()
    var colViewDataSourceDelegate:HomePageDataSourceDelegate?
    var tblViewDataSourceDelegate:HomePageTblDataSourceDelegate?
    var colViewNewsDataSourceDelegate:NewsDataSourceDelegate?
    var DataSourceArr : [HomePageModel] = []
    var arrList:[NewsModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblFollow.text = "Follow us on".localizedString
        self.lblimportant.text = "Important Links".localizedString
        getDetails()
        setupcolView()
        setupTableView()
        setupnewscolView()
        addObserver()
        setuptimer()
        setUpHeader()
        
        
        self.pgControl.numberOfPages = arrList.count
        // Do any additional setup after loading the view.
        
    }
    
    func setUpHeader() {
        self.setUpHeaderTitle(strHeaderTitle: "Welcome to STTL".localizedString)
        self.viewHeader.lblHeaderTitle.textColor = .white
        self.setHeaderView_MenuImage()
        self.showFindLocation()
    }
    
    override func btnFindLocationTapped(_ sender: UIButton) {
        UserDefaults.standard.set(false , forKey : "loggedin")
        let story = UIStoryboard(name: "Logout", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "LogoutVC") as! LogoutVC
        vc.modalPresentationStyle = .overFullScreen
        vc.com = {
//            self.navigationController?.popToRootViewController(animated: true)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "LoginVC")as! LoginVC
            let navCon = UINavigationController(rootViewController: vc)
            navCon.isNavigationBarHidden = true
            self.getwindow().rootViewController = navCon
            self.getwindow().makeKeyAndVisible()

        }
        self.present(vc, animated: false, completion: nil)
    
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
    
    @objc func startScrolling() {

        if pgControl.currentPage == pgControl.numberOfPages - 1 {
            pgControl.currentPage = 0
        } else {
            pgControl.currentPage += 1
        }
        newsCollView.scrollToItem(at: IndexPath(row: pgControl.currentPage, section: 0), at: .right, animated: true)
    }
    func setuptimer() {
      Timer.scheduledTimer(timeInterval: 3, target: self , selector:
    #selector(startScrolling), userInfo: nil, repeats: true)

    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func addObserver(){
        collView.addObserver(self, forKeyPath: "contentSize", options: [.old,.new], context: nil)
        tblView.addObserver(self, forKeyPath: "contentSize", options: [.old,.new], context: nil)
        newsCollView.addObserver(self, forKeyPath: "contentSize", options: [.old,.new], context: nil)

    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let obj = object as? UICollectionView, obj == self.collView {
            collViewHeight.constant = collView.contentSize.height + 10
            
        } else if let obj = object as? UITableView, obj == self.tblView {
            tblViewHeight.constant = tblView.contentSize.height + 10
        }
        /* else if let obj = object as? UICollectionView, obj == self.newsCollView {
          NewsCollViewHeight.constant = newsCollView.contentSize.height + 10}*/
    }

    
    fileprivate func setupcolView() {
        if let arr = readPropertyList(ofName: "file1") as? [[String:Any]] {
            self.DataSourceArr = arr.map({ HomePageModel(dict: $0) })
            
        }
        if self.colViewDataSourceDelegate == nil {
            self.colViewDataSourceDelegate = .init(arr: DataSourceArr, colv: collView, del: self , height: 120)
        }
        else{
            self.colViewDataSourceDelegate?.reload(arr: DataSourceArr)
        }
    }
    fileprivate func setupTableView() {
        if self.tblViewDataSourceDelegate == nil {
            self.tblViewDataSourceDelegate = .init(arr: ["Official Website of the corporation","Global City Gurugram","Industries Department Haryana"], tblv: tblView, del: self )
        }
        else{
            self.tblViewDataSourceDelegate?.reload(arr: ["Official Website of the corporation","Global City Gurugram","Industries Department Haryana"])
        }
        
    }
    fileprivate func setupnewscolView() {
       
        if self.colViewNewsDataSourceDelegate == nil {
            self.colViewNewsDataSourceDelegate = .init(arr: arrList, colv: newsCollView, del: self ,pgcontrol :pgControl)
        }
        else{
            self.colViewNewsDataSourceDelegate?.reload(arr: arrList)
        }
    }
}
extension HomePageVC : TblViewDelegate {
    
}
extension HomePageVC: ColViewDelegate {
 func didSelect(colView: UICollectionView, indexPath: IndexPath){
        let story = UIStoryboard(name: "News", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "DetailsNewsVC") as! DetailsNewsVC
         vc.model =  arrList[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}


extension HomePageVC {
    func getDetails() {
        webServicesModel.getUserData { arr in
            self.arrList = arr
            self.setupnewscolView()
        }
        
        }
    }
