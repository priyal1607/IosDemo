//
//  CustomizeDashboardVC.swift
//  loginDemo
//
//  Created by Priyal on 25/09/23.
//

import UIKit
import SideMenu
import CHIPageControl

class CustomizeDashboardVC: HeaderViewController {

    @IBOutlet weak var btnDashboard: UIButton!
    @IBOutlet weak var collViewHeight: NSLayoutConstraint!
    @IBOutlet weak var collViewDashboard: UICollectionView!
    @IBOutlet weak var bannerCollView: UICollectionView!
    var centerId:Int = 0
    @IBOutlet weak var pageControl: CHIPageControlJaloro!
    var tempArray : [ListModel] = []
    var arrBanner : [ListModel] = []
    var webService = bannerWebService()
    var bannerCollViewDelegate : bannerCollViewDelegate!
    var dashboardCollViewDelegate : dashboardCollViewDelegate!
    var arrDashboard : [dashboardList] = []
    var isfromsidemenu : Bool = false
    let minimumInterItemandLinespacing:CGFloat = 0
    override func viewDidLoad() {
        
        super.viewDidLoad()
        getBannerData()
        setupnewscolView()
        setUpHeader()
        addObserver()
        //setuptimer()
        getDashboardData()
        setUpPageControl()
        setuptimer()
        btnDashboard.layer.borderWidth = 1.0 // Border width
        btnDashboard.layer.borderColor = UIColor.black.cgColor // Border color
        btnDashboard.layer.cornerRadius = 10.0 // Corner radius (adjust as needed)

               // Optionally, you can set a background color
        btnDashboard.backgroundColor = UIColor.clear

       
       // self.pageControl.numberOfPages = self.arrBanner.count
        // Do any additional setup after loading the view.
    }
    private func setUpPageControl() {
        pageControl.radius = IS_IPAD ? 7.5 : 5
        pageControl.elementWidth = IS_IPAD ? 15 : 10
        pageControl.elementHeight = IS_IPAD ? 15 : 10
        pageControl.numberOfPages = arrBanner.count
//      pageControl.inactiveTransparency = 0.0
        pageControl.borderWidth = 2.0
        pageControl.currentPageTintColor = .lightGray
        pageControl.tintColor = .lightGray
        pageControl.padding = IS_IPAD ? 9 : 6
    }
    override func viewWillAppear(_ animated: Bool) {
        getDashboardData()
    }
    func addObserver(){
        collViewDashboard.addObserver(self, forKeyPath: "contentSize", options: [.old,.new], context: nil )
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            collViewHeight.constant = collViewDashboard.contentSize.height + 10
    }
    func setUpHeader() {
        self.setUpHeaderTitle(strHeaderTitle: "MEA INDIA".localizedString)
        self.viewHeader.lblHeaderTitle.textColor = .white
        self.setHeaderView_MenuImage()
      
    }
    @objc func startScrolling() {
        
        if pageControl.currentPage == pageControl.numberOfPages - 1 {
            changeCurrentPage(index:0)
        } else {
            changeCurrentPage(index: Double(pageControl.currentPage)+1)
        }
        bannerCollView.scrollToItem(at: IndexPath(row: pageControl.currentPage, section: 0), at: .right, animated: true)
    }
    func setuptimer() {
      Timer.scheduledTimer(timeInterval: 3, target: self , selector:
    #selector(startScrolling), userInfo: nil, repeats: true)

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
       
        if self.bannerCollViewDelegate == nil {
            self.bannerCollViewDelegate = .init(arr: arrBanner, colv: bannerCollView , del: self)
        }
        else{
            self.bannerCollViewDelegate?.reload(arr: arrBanner)
        }
    }
    fileprivate func setupnewscolView2(arr : [dashboardList]) {
       
        if self.dashboardCollViewDelegate == nil {
            self.dashboardCollViewDelegate = .init(arrData: arr, delegate: self, scrl: collViewDashboard)
        }
        else{
            self.dashboardCollViewDelegate?.reloadData(arrData: arr)
        }
    }

    @IBAction func btnDashboardAction(_ sender: UIButton) {
        isfromsidemenu = false
        let vc = OptionsVC.instantiate(appStoryboard: .options)
        vc.arr = arrDashboard
        vc.comp = { arr in
            self.arrDashboard = arr
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension CustomizeDashboardVC : ColViewDelegate {
    func changeCurrentPage(index: Double) {
    pageControl.progress = index
}
    func didSelect(colView: UICollectionView, indexPath: IndexPath) {
       // if arrDashboard[indexPath.row].lbl == "Virtual Meeting" {
            let storyboard = UIStoryboard(name: "BookMark", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "BookMarkVC")as! BookMarkVC
            vc.color = arrDashboard[indexPath.row].color!
            vc.titles = arrDashboard[indexPath.row].lbl!
            self.navigationController?.pushViewController(vc, animated: true)
        //}
    }

    
}
extension CustomizeDashboardVC {
    func getBannerData(){
        webService.getBannerData { list in
            self.arrBanner = list
            self.setupnewscolView()
           
        }
        self.pageControl.numberOfPages = self.arrBanner.count
       
    }
    func getDashboardData(){
        webService.getDashboardData{ list in
            if self.isfromsidemenu {
                self.arrDashboard = list
    
                self.setupnewscolView2(arr: self.arrDashboard)
            } else {
                let filteredArray = self.arrDashboard.filter { !$0.isSelected }
               // self.arrDashboard = filteredArray
                self.setupnewscolView2(arr: filteredArray)
            }
            
           
        }
       
    }
}
