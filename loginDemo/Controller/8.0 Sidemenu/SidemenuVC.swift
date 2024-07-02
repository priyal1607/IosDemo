//
//  SidemenuVC.swift
//  loginDemo
//
//  Created by Chelsi on 10/05/23.
//

import UIKit
var loginvc = LoginVC()
var loginwebService = Loginwebservice()
enum  storyboardId: String {
    case dashboard = "dashboard"
    case student_list = "student_list"
    case CustomizeDashboard = "Customize Dashboard"
    case Search = "Search"
    case settings = "settings"
    case gallery_view = "gallery_view"
    case list_view = "list_view"
    case NewDashboard = "NewDashboard"
    case Language = "Language"
    case gallery = "Gallery"
    case IndianMissionAbroad = "Indian Mission Abroad"
    case MusicPlayer = "MusicPlayer"
    case Kytdashboard = "Kytdashboard"
    case nps = "NPS"
    case MYMEA = "MY MEA"
    case BookMark = "BookMark"
    case sag = "SAG"
    
}

class SidemenuVC: UIViewController {
    
    @IBOutlet weak var imView: UIView!
    @IBOutlet var headerView: UIView!
    
    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var btnProfile: UIButton!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var btnView: UIView!
    @IBOutlet weak var detailsBtn: UIButton!
    
    var arr2 : DashboardModel?
    var tblViewDataSourceDelegate:SidemenuDataSourceDelegate?
    var menuDataSourceArr : [SideMenuModel] = []
    var arr : DashboardModel?
    fileprivate var selectedSection: IndexPath?
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            UIColor(red: 17/255, green: 28/255, blue: 79/255, alpha: 1).cgColor,
            UIColor(red: 53/255, green: 30/255, blue: 148/255, alpha: 1).cgColor,
        ]
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        return gradient
    }()
    
    
    @IBOutlet var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        DispatchQueue.main.asyncAfter(deadline:.now()+0.1)  {
            self.btnProfile.setTitle("My Profile".localizedString , for: .normal)
            self.btnLogout.setTitle("Logout".localizedString , for: .normal)
            self.gradient.frame = self.btnView.bounds
            self.btnView.layer.insertSublayer(self.gradient, at: 0)
            self.imView.setCustomCornerRadius(radius: self.imView.frame.width/2)
            self.imageView.setCustomCornerRadius(radius:self.imageView.frame.width/2 , borderColor: .white , borderWidth: 3)
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if UserDefaults.standard.bool(forKey: "loggedin") {
            getPaymentDetails()
            self.lblEmail.text = arr2?.dept.localizedString
            self.lblName.text = arr2?.name.localizedString
            self.imageView.image = UIImage(named: arr2?.image ?? "usericon")
        } else {
            self.lblName.text = .LanguageLocalisation.Welcomeuser
            self.lblEmail.text = ""
            self.imageView.image = UIImage(named: "usericon")
        }
    }
    fileprivate func setupTableView() {
        if let arr = readPropertyList(ofName: "SideMenu") as? [[String:Any]] {
            self.menuDataSourceArr = arr.map({ SideMenuModel(dict: $0) })
        }
        if self.tblViewDataSourceDelegate == nil {
            self.tblViewDataSourceDelegate = .init(arr : menuDataSourceArr,tblv: tblView, del: self)
        }
        else{
            self.tblViewDataSourceDelegate?.reload(arr: menuDataSourceArr, selectedSection: selectedSection ?? IndexPath(row: 0, section: 0))
        }
        
    }
    
    @IBAction func crossBtnAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func headerViwBtnAction(_ sender: UIButton) {
        if UserDefaults.standard.bool(forKey: "loggedin") {
            let storyboard = UIStoryboard(name: "DetailsStoryboard", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "DetailsViewController")as! DetailsViewController
            vc.model = arr2
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            self.view.showBanner(message: "User not Logged in")
        }
    }
    
    @IBAction func logoutBtnAction(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "loggedin")
        let story = UIStoryboard(name: "Logout", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "LogoutVC") as! LogoutVC
        vc.modalPresentationStyle = .overFullScreen
        
            self.dismiss(animated: true)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc1 = storyboard.instantiateViewController(withIdentifier: "LoginVC")as! LoginVC
            let navCon = UINavigationController(rootViewController: vc1)
            navCon.isNavigationBarHidden = true
            self.getwindow().rootViewController = navCon
            self.getwindow().makeKeyAndVisible()
    
        self.present(vc, animated: false, completion: nil)
        
    }
    
    @IBAction func profileBtnAction(_ sender: UIButton) {
        
        if UserDefaults.standard.bool(forKey: "loggedin") {
            let storyboard = UIStoryboard(name: "DetailsStoryboard", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "DetailsViewController")as! DetailsViewController
            vc.model = arr2
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            self.view.showBanner(message: "User not Logged in")
        }
    }
    
    @IBAction func detailsBtnAction(_ sender: UIButton) {
        /*let storyboard = UIStoryboard(name: "DetailsStoryboard", bundle:nil)
         let vc  = storyboard.instantiateViewController(withIdentifier: "DetailsViewController")as! DetailsViewController
         self.navigationController?.pushViewController(vc, animated: true)*/
    }
}

extension NSObject {
    func readPropertyList(ofName: String) -> Any? {
        if let path = Bundle.main.path(forResource: ofName, ofType: "plist") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: fileUrl, options: .init(rawValue: 0))
                let plistData = try PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil)
                return plistData
            } catch let error {
                debugPrint(error.localizedDescription)
            }
        }
        return nil
    }
}


extension SidemenuVC : TblViewDelegate {
    
    func didSelect(tbl: UITableView, indexPath: IndexPath) {
        let item = self.menuDataSourceArr[indexPath.section]
        
        if indexPath.row == 0 {
            if item.MoreOptions.count > 0 {
                if let aSelectedIndex = selectedSection, aSelectedIndex == indexPath {
                    selectedSection = nil
                } else {
                    selectedSection = indexPath
                }
                
                setupTableView()
                return
            }
        }
        var selectedstoryboard = item.storyboardID
        if item.MoreOptions.count > 0{
            selectedstoryboard = item.MoreOptions[indexPath.row-1].storyboardID
            
            /*switch (selectedstoryboard) {
             case "gallery_view":
             let storyboard = UIStoryboard(name: "CollectionView", bundle: nil)
             let vc = storyboard.instantiateViewController(withIdentifier: "CollectionVC")as! CollectionVC
             self.navigationController?.pushViewController(vc, animated: true)
             
             default:
             self.dismiss(animated: true)
             }
             */        }
        
        switch (storyboardId(rawValue: selectedstoryboard)) {
        case .dashboard:
//            self.dismiss(animated: true)
//            let storyboard = UIStoryboard(name: "HomePage", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "HomePageVC")as! HomePageVC
//            self.navigationController?.pushViewController(vc, animated: true)
//
            let storyboard = UIStoryboard(name: "HomePage", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "HomePageVC")as! HomePageVC
            let navCon = UICustomNavigationController(rootViewController: vc)
            navCon.isNavigationBarHidden = true
            self.getwindow().rootViewController = navCon
            self.getwindow().makeKeyAndVisible()
            
            
            
        case .student_list:
//            let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "DashboardVC")as! DashboardVC
//            self.navigationController?.pushViewController(vc, animated: true)
////            print("list")
            let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "DashboardVC")as! DashboardVC
            let navCon = UICustomNavigationController(rootViewController: vc)
            navCon.isNavigationBarHidden = true
            self.getwindow().rootViewController = navCon
            self.getwindow().makeKeyAndVisible()
            
        case .CustomizeDashboard:
            let storyboard = UIStoryboard(name: "CustomizeDashboard", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "CustomizeDashboardVC")as! CustomizeDashboardVC
            vc.isfromsidemenu = true
            
//            let navCon = UICustomNavigationController(rootViewController: vc)
//            navCon.isNavigationBarHidden = true
//            self.getwindow().rootViewController = navCon
//            self.getwindow().makeKeyAndVisible()
            self.navigationController?.pushViewController(vc, animated: true)
            
        case .gallery_view:
            let storyboard = UIStoryboard(name: "CollectionView", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "CollectionVC")as! CollectionVC
            let navCon = UICustomNavigationController(rootViewController: vc)
            navCon.isNavigationBarHidden = true
            self.getwindow().rootViewController = navCon
            self.getwindow().makeKeyAndVisible()
//            let storyboard = UIStoryboard(name: "CollectionView", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "CollectionVC")as! CollectionVC
//            self.navigationController?.pushViewController(vc, animated: true)
            
        case .list_view:
            let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "DashboardVC")as! DashboardVC
            let navCon = UICustomNavigationController(rootViewController: vc)
            navCon.isNavigationBarHidden = true
            self.getwindow().rootViewController = navCon
            self.getwindow().makeKeyAndVisible()
//            self.dismiss(animated: true, completion: nil)
//            let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "DashboardVC")as! DashboardVC
//            self.navigationController?.pushViewController(vc, animated: true)
            
        case .Search:
            let storyboard = UIStoryboard(name: "Search", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "SearchVC")as! SearchVC
            self.navigationController?.pushViewController(vc, animated: true)
            
        case .NewDashboard :
            let storyboard = UIStoryboard(name: "HomePage", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "HomePageVC")as! HomePageVC
            let navCon = UICustomNavigationController(rootViewController: vc)
            navCon.isNavigationBarHidden = true
            self.getwindow().rootViewController = navCon
            self.getwindow().makeKeyAndVisible()
//            let storyboard = UIStoryboard(name: "HomePage", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "HomePageVC")as! HomePageVC
//            self.navigationController?.pushViewController(vc, animated: true)
            
        case .Language:
            let storyboard = UIStoryboard(name: "Settings", bundle: nil)
                       let vc = storyboard.instantiateViewController(withIdentifier: "SettingViewController")as! SettingViewController
                      self.navigationController?.pushViewController(vc, animated: true)
//            let storyboard = UIStoryboard(name: "Settings", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "SettingViewController")as! SettingViewController
//            let navCon = UICustomNavigationController(rootViewController: vc)
//            navCon.isNavigationBarHidden = true
//            self.getwindow().rootViewController = navCon
//            self.getwindow().makeKeyAndVisible()
        case .gallery :
            let storyboard = UIStoryboard(name: "Gallery", bundle: nil)
                       let vc = storyboard.instantiateViewController(withIdentifier: "GalleryVC")as! GalleryVC
                      self.navigationController?.pushViewController(vc, animated: true)
        case .IndianMissionAbroad:
            let storyboard = UIStoryboard(name: "IMA", bundle: nil)
                       let vc = storyboard.instantiateViewController(withIdentifier: "IMAVC")as! IMAVC
                      self.navigationController?.pushViewController(vc, animated: true)
            break
        case .Kytdashboard :
            let storyboard = UIStoryboard(name: "Kytdashboard", bundle: nil)
                       let vc = storyboard.instantiateViewController(withIdentifier: "KytdashboardVC")as! KytdashboardVC
                      self.navigationController?.pushViewController(vc, animated: true)
            break
        case .nps:
            let storyboard = UIStoryboard(name: "NPS", bundle: nil)
                       let vc = storyboard.instantiateViewController(withIdentifier: "NPSVc")as! NPSVc
                      self.navigationController?.pushViewController(vc, animated: true)
            break
            
        case .MYMEA :
            let storyboard = UIStoryboard(name: "Notes", bundle: nil)
                       let vc = storyboard.instantiateViewController(withIdentifier: "NotesVC")as! NotesVC
                      self.navigationController?.pushViewController(vc, animated: true)
            break
            
        case .BookMark :
            let storyboard = UIStoryboard(name: "BookMark", bundle: nil)
                       let vc = storyboard.instantiateViewController(withIdentifier: "BookMarkVC")as! BookMarkVC
                      self.navigationController?.pushViewController(vc, animated: true)
            break
            
        case .sag :
            let storyboard = UIStoryboard(name: "SAG", bundle: nil)
                       let vc = storyboard.instantiateViewController(withIdentifier: "SAGVc")as! SAGVc
                      self.navigationController?.pushViewController(vc, animated: true)
            break
        default:
            break
        }
    }
    
}


extension SidemenuVC {
    func getPaymentDetails() {
        loginwebService.getUserData { arr in
            self.arr2 = arr
        }
    }
}
