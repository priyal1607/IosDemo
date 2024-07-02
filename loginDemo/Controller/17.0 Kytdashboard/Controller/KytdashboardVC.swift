//
//  KytdashboardVC.swift
//  loginDemo
//
//  Created by Priyal on 11/09/23.
//

import UIKit
import SideMenu

enum MandirViewTypes: String {
    case banner = "banner"
    case shorts = "shorts"
    case photos = "photos"
    case horizontal = "horizontal"
    case vertical = "vertical"
    case trendingArticles = "trendingArticles"
    case mantras = "mantras"
    
}

class KytdashboardVC: HeaderViewController {

    @IBOutlet weak var shiv_CollView: UICollectionView!
    @IBOutlet weak var bannerCollView: UICollectionView!
    @IBOutlet weak var collView: UICollectionView!
    var kytDataSourceDelegate : KytDataSourceDelegate!
    var bannerDataSourceDelegate : bannerDataSourceDelegate!
    var arr : [String] = ["mandir" , "genre" , "Darshan" , "podcast"]
    var arrBanner : [MandirItemModel] = []
    var imgurl : String = ""
    var webService = HomePageWebService()
    weak var topController: TopBarViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        self.topController = TopBarViewController.instantiate(appStoryboard: .TopBarViewController)
        self.addChild(topController!)
        self.view.addSubview(self.topController!.view)
        self.topController?.setupController(setVCsTitles: [(MandirViewController.instantiate(appStoryboard: .mandir), "Mandir")])
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
    func setUpView(){
        setUpHeader()
    }
    
    func setUpHeader(){
        self.setUpHeaderTitle(strHeaderTitle: "Kyt Dashboard")
        self.viewHeader.lblHeaderTitle.textColor = .white
        self.setHeaderView_MenuImage()
    }
}
extension KytdashboardVC : ColViewDelegate {
    func didSelect(colView: UICollectionView, indexPath: IndexPath) {
    }
}
