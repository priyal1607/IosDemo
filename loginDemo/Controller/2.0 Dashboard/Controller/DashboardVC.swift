//
//  dashboardVc.swift
//  loginDemo
//
//  Created by Chelsi on 18/04/23.
//

import UIKit
import SideMenu

class DashboardVC: HeaderViewController {
    
    @IBOutlet var lblDataNotFound: UILabel!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet weak var viewtable: UITableView!
    var search = false
    var sectionArray = [Section]()
    fileprivate var tblViewDataSourceDelegate: DashboardDatasourceDelegate?
    var sea = false
    //MARK: Public Variable
    var webServicesModel = DashboardWebServiceModel()
    var arrList: [DashboardModel] = []
    var arrList2 : [DashboardModel] = []
    var DataSourceDelegate : DashboardDatasourceDelegate?
    var Model : DashboardModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        setUpHeader()
        getPaymentDetails()
        
    }
    
    /*    fileprivate func setuptable() {
            DataSourceDelegate = .init(arr: [["abc","1-2-2003"],["cbc","1-1-2002"]], tblv: viewtable, del: self)
        }*/
    
    func setUpHeader() {
        self.setUpHeaderTitle(strHeaderTitle: "List View")
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
    
    fileprivate func setupTableView(arr : [DashboardModel] , isSearch :Bool , array :[Section]) {
        if self.tblViewDataSourceDelegate == nil {
            self.tblViewDataSourceDelegate = .init(arr: arr, tblv: viewtable, del: self, array: sectionArray, isSearch: isSearch)
                
        }
        else {
            self.tblViewDataSourceDelegate?.reload(arr: arr, isSearch: isSearch, array: array)
            
        }
    }

    @IBAction func SidemenuBtnAction(_ sender: Any) {
    }
    
    @IBAction func ImageBtnAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "CollectionView", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier:"CollectionVC" ) as! CollectionVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    @IBAction func logoutBtnAction(_ sender: Any) {
//        navigationController?.popToRootViewController(animated: true)
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
}
extension DashboardVC: TblViewDelegate {
    func didSelect(tbl: UITableView, indexPath: IndexPath) {
        let story = UIStoryboard(name: "DetailsStoryboard", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        if search == false {
            vc.model =  sectionArray[indexPath.section].names[indexPath.row]
        
        } else {
            vc.model =  arrList2[indexPath.row]
        }
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
extension DashboardVC {
    func getPaymentDetails() {
        webServicesModel.dashboarddata { arr in
            
            self.arrList = arr
            let groupedDictionary = Dictionary(grouping: self.arrList, by:{String($0.name.prefix(1))})
            // get the keys and sort them
            let keys = groupedDictionary.keys.sorted()
            // map the sorted keys to a struct
            self.sectionArray = keys.map{Section(letter: $0, names: groupedDictionary[$0] ?? [])}
            self.setupTableView(arr: arr, isSearch: false, array: self.sectionArray)
            self.viewtable.layoutIfNeeded()
            self.viewtable.layoutSubviews()
                          
        }
        }
    }

extension DashboardVC : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        arrList2 = arrList.filter { $0.name.lowercased().prefix(searchText.count) == searchText.lowercased() }
        if searchText.count > 0 {
            search = true
            if arrList2.count == 0 {
            lblDataNotFound.isHidden = false
            viewtable.isHidden = true
            }
            else {
                lblDataNotFound.isHidden = true
                viewtable.isHidden = false
            }
            setupTableView(arr: arrList2, isSearch: true, array: [])
            
        }
        else {
            search = false
            lblDataNotFound.isHidden = true
            viewtable.isHidden = false
            setupTableView(arr: [], isSearch: false, array: sectionArray)
            
        }
    }
}
