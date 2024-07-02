//
//  collectionVCViewController.swift
//  loginDemo
//
//  Created by Chelsi on 27/04/23.
//

import UIKit
import SideMenu

class CollectionVC: HeaderViewController {
    @IBOutlet var lblDataNotFound: UILabel!
    
    @IBOutlet var colSearchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var webServicesModel = DashboardWebServiceModel()
    var colldataSourceDelegate:CollectionViewDatasourceDelegate?
    var search = false
    var arr1: [DashboardModel] = []
    var arr2 : [DashboardModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
            self.colSearchBar.delegate = self
        getDetails()
        setUpHeader()
//        collectionView.backgroundColor = UIColor(red: 222/255, green: 233/255, blue: 247/255, alpha: 1)
        

        // Do any additional setup after loading the view.
    }
    

//        if colldataSourceDelegate == nil {
//            colldataSourceDelegate = .init(arrSrc: ["image_1","image_2","image_3","image_4","image_5","image_6","image_1","image_2","image_3","image_4","image_5","image_6","image_1","image_2","image_3","image_4","image_5","image_6","image_1","image_2","image_3","image_4","image_5","image_6","image_1","image_2","image_3","image_4","image_5","image_6"], colView: collectionView, del: self)
//        }
//        else{
//            colldataSourceDelegate?.reloadData(arr: ["image_1","image_2","image_3","image_4","image_5","image_6","image_1","image_2","image_3","image_4","image_5","image_6","image_1","image_2","image_3","image_4","image_5","image_6","image_1","image_2","image_3","image_4","image_5","image_6","image_1","image_2","image_3","image_4","image_5","image_6"])
//        }
   
    func setUpHeader() {
        self.setUpHeaderTitle(strHeaderTitle: "Grid View")
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
    fileprivate func setupColView(arr:[DashboardModel]) {
            if self.colldataSourceDelegate == nil {
                self.colldataSourceDelegate = .init(arrSrc : arr, colView: collectionView, del: self)
            }
        else{
            self.colldataSourceDelegate?.reloadData(arr: arr)
        }
    }
    @IBAction func BackBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension CollectionVC: ColViewDelegate {
 func didSelect(colView: UICollectionView, indexPath: IndexPath){
        let story = UIStoryboard(name: "DetailsStoryboard", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
     if search == false {
         vc.model =  arr1[indexPath.row]
     } else {

         vc.model =  arr2[indexPath.row]
         
     }
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension CollectionVC {
    func getDetails() {
        webServicesModel.dashboarddata { arr in
            self.arr1 = arr
            self.setupColView(arr:arr)
        }
    }
}

extension CollectionVC : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        arr2 = arr1.filter { $0.name.lowercased().prefix(searchText.count) == searchText.lowercased() }
        if searchText.count > 0 {
            search = true
            if arr2.count == 0 {
                lblDataNotFound.isHidden = false
                collectionView.isHidden = true
            
            }
            else {
                lblDataNotFound.isHidden = true
                collectionView.isHidden = false
            }
            
            setupColView(arr: arr2)
        }
        else {
            
            search = false
            setupColView(arr: arr1)
            
        }
        
        
    }
}
