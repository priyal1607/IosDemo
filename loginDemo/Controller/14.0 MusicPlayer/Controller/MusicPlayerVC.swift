//
//  MusicPlayerVC.swift
//  loginDemo
//
//  Created by Priyal on 17/08/23.
//
//import MediaPlayer
import UIKit
import AVFoundation
import StreamingKit
import MediaPlayer
import Hero
import SideMenu

class MusicPlayerVC: HeaderViewController {
    @IBOutlet var mainview: UIView!
    @IBOutlet weak var tblView: UITableView!
    var audioPlayer: AVAudioPlayer?
    var isplay: Bool?
    fileprivate var tblViewDataSourceDelegate: MusicPlayerDataSourceDelegate?
    var webService = MusicWebService()
    var arr : [MusicModel] = []
    var co : (() -> ())!
    var coback : (() -> ())!
    var totalCount = 0
    let commandCenter = MPRemoteCommandCenter.shared()
    //let viewMusic = Bundle.main.loadNibNamed("ViewMusicControl", owner: nil, options: nil)![0] as! ViewMusicControl
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHeader()
        getData()
        setupMediaPlayerNotificationView()
//        self.mainview.isUserInteractionEnabled = true

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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesBegan(touches, with: event)
            // Pass the touch events to the parent view controller
            self.parent?.touchesBegan(touches, with: event)
        }

    fileprivate func setUpHeader(){
        self.setUpHeaderTitle(strHeaderTitle: "Music")
        self.viewHeader.lblHeaderTitle.textColor = .white
        self.setHeaderView_MenuImage()
       
    }
    
    func setupMediaPlayerNotificationView()  {
//        commandCenter.playCommand.addTarget { [unowned self] event in
//
//
//        }
    }
    fileprivate func setUpTbl(){
        if self.tblViewDataSourceDelegate == nil {
            self.tblViewDataSourceDelegate = .init(arr: arr, tblv: tblView, del: self)
                
        }
        else {
            self.tblViewDataSourceDelegate?.reload(arr: arr)
            
        }
    }
    func removeMusicBottomView() {
        for childVC in children {
            if let musicBottomVC = childVC as? MusicBottomViewVC {
                musicBottomVC.willMove(toParent: nil)
                musicBottomVC.view.removeFromSuperview()
                musicBottomVC.removeFromParent()
                break // Assuming you only have one instance of MusicBottomViewVC
            }
        }
    }
    func dismissSubView() {
            for childVC in children {
                if childVC is MusicBottomViewVC {
                    let subViewController = childVC as! MusicBottomViewVC
                    subViewController.willMove(toParent: nil)
                    subViewController.view.removeFromSuperview()
                    subViewController.removeFromParent()
                    break
                }
            }
        }

}
extension MusicPlayerVC : TblViewDelegate , MusicPlayPauseUpdateDelegate{
    func didSelect(tbl: UITableView, indexPath: IndexPath) {
        let dVC = getMusicPlayerdVC()
        dVC.previousIndexRow = dVC.index
        dVC.previousList = dVC.arr
        dVC.delegate = self
        dVC.arr = self.arr
        dVC.index = indexPath.row
        //self.navigationController?.pushViewController(dVC, animated: true)
        dVC.modalPresentationStyle = .fullScreen
        self.present(dVC, animated: true)
        //self.bottomBarViewController?.present(dVC, animated: true)
        self.bottomBarViewController?.viewMusic.tag = 0
        
        
//        if  self.bottomBarViewController?.viewMusic.tag == 0 && (self.bottomBarViewController?.viewMusic.isHidden ?? true) {
//            self.bottomBarViewController?.viewMusic.isHidden = false
//        }
    }
    func musicPlayPauseUpdateIndex(index: Int, tbl_Tag: Int) {
        if self.bottomBarViewController?.viewMusic.tag == 0 && (self.bottomBarViewController?.viewMusic.isHidden ?? true) {
            self.bottomBarViewController?.viewMusic.isHidden = false
        }
    }
    
}

        
extension MusicPlayerVC {
    func getData(){
        CustomActivityIndicator.sharedInstance.showIndicator(view: self.view)
        webService.getMusicList {list , result , totalcount in
            self.arr = list
            self.totalCount = totalcount
            CustomActivityIndicator.sharedInstance.hideIndicator(view: self.view)
            self.setUpTbl()
        }
    }
}
