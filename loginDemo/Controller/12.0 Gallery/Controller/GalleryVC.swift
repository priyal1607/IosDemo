//
//  GalleryVC.swift
//  loginDemo
//
//  Created by Priyal on 29/06/23.
//

import UIKit

class GalleryVC: HeaderViewController {
    @IBOutlet weak var cView: UIView!
    
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var tblViewHeight: NSLayoutConstraint!
    @IBOutlet weak var collViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var collView: UICollectionView!
    fileprivate var galleryDataSourceDelegate: GalleryDataSourceDelegate!
    fileprivate var pressDataSourceDelegate: PressDataSourceDelegate!
    let webService = GalleryWebService()
    fileprivate var arrGallery : [PressReleaseResult] = []
    fileprivate var arrPress : [PressReleaseResult] = []
    fileprivate var totalCountPress: Int?
    fileprivate var totalCountGal: Int?
    @IBOutlet weak var tblView: UITableView!
    fileprivate var pagePress = 1
    fileprivate var pageGal = 1
    fileprivate var galleryUrl = ""
    fileprivate var PressReleaseUrl = ""
    fileprivate var selectedIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollView()
        setupTblView()
        setUpHeader()
        getGallery()
        getPress()
        addObserver()
        setUpSegmentControl()
        view1.backgroundColor = .orange
        view2.backgroundColor = .clear
        // Do any additional setup after loading the view.
    }
    
    func setUpHeader() {
        self.setUpHeaderTitle(strHeaderTitle: "Gallery & Press Release")
        self.viewHeader.lblHeaderTitle.textColor = .white
        
    }
    
    fileprivate func setUpSegmentControl() {
        segmentedControl.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        segmentedControl.backgroundColor = .white
        segmentedControl.tintColor = .clear
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor(hexStringToUIColor: "#090707"),
            NSAttributedString.Key.font: UIFont.montserratFont(.medium, .value)], for: .normal)
        
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor : UIColor(hexStringToUIColor: "#FC4306"),
            NSAttributedString.Key.font: UIFont.montserratFont(.medium, .value)], for: .selected)
        getGallery()
        
    }
    
    
    fileprivate func setupCollView() {
        if self.galleryDataSourceDelegate == nil {
            self.galleryDataSourceDelegate = .init(arrData: arrGallery, delegate: self, scrl: collView , imgUrl: galleryUrl)
        } else {
            self.galleryDataSourceDelegate?.reloadData(arrData: arrGallery , imgUrl: galleryUrl)
        }
    }
    fileprivate func setupTblView() {
        if self.pressDataSourceDelegate == nil {
            self.pressDataSourceDelegate = .init(arrData: arrPress, delegate: self, tbl: tblView , imgURL: PressReleaseUrl)
        } else {
            self.pressDataSourceDelegate?.reloadData(arr: arrPress , imgURL: PressReleaseUrl)
        }
    }
    
    func addObserver(){
        collView.addObserver(self, forKeyPath: "contentSize", options: [.old,.new], context: nil )
        tblView.addObserver(self, forKeyPath: "contentSize", options: [.old,.new], context: nil)

    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let obj = object as? UICollectionView, obj == self.collView {
            collViewHeight.constant = collView.contentSize.height + 10
            
        } else if let obj = object as? UITableView, obj == self.tblView {
            tblViewHeight.constant = tblView.contentSize.height + 10
        }
    }

    
    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        self.selectedIndex = selectedIndex
        switch selectedIndex {
        case 0:
            setupCollView()
            getGallery()
            view1.backgroundColor = .orange
            view2.backgroundColor = .clear
            tView.isHidden = true
            cView.isHidden = false
            break
        case 1 :
            setupTblView()
            getPress()
            view2.backgroundColor = .orange
            view1.backgroundColor = .clear
            cView.isHidden = true
            tView.isHidden = false
            break
            
        default:
            break
        }
    }
}
    extension GalleryVC : ColViewDelegate {
        func didSelect(colView : UICollectionView, indexPath: IndexPath) {
            let storyboard = UIStoryboard(name: "GallerySeeAll", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "GallerySeeAllVC")as! GallerySeeAllVC
            vc.catid = getString(anything: self.arrGallery[indexPath.row].id)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        func willDisplay(colView: UICollectionView, cell: UICollectionViewCell, indexPath: IndexPath) {
            if (indexPath.row == self.arrGallery.count - 1) && (totalCountGal ?? 0 > arrGallery.count) {
                pageGal += 1
                getGallery()
                
            }
        }
        
    }
extension GalleryVC : TblViewDelegate {
//    func willDisplay(tbl: UITableView, atIndexPath: IndexPath) {
//        if (atIndexPath.row == self.arrPress.count - 1) && (totalCountPress ?? 0 > arrPress.count) {
//            pagePress += 1
//            getPress()
//        }
//    }
    
    func didSelect(tbl : UITableView, indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "PressDetails", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PressDetailsVC")as! PressDetailsVC
        vc.dictData = arrPress[indexPath.row]
        vc.imgURL = PressReleaseUrl
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

    extension GalleryVC {
        func getGallery() {
            CustomActivityIndicator.sharedInstance.showIndicator(view: self.view)
            webService.model = "Gallerycategories"
            webService.page = getString(anything: pageGal)
            webService.getGalleryData{ model, count,imgUrl  in
                guard let model else {
                    Global.shared.showBanner(message: .LanguageLocalisation.something_went_wrong_try_some_time)
                    CustomActivityIndicator.sharedInstance.hideIndicator(view: self.view)
                    return
                }
                if self.pageGal == 1 {
                    self.arrGallery = model
                } else {
                    self.arrGallery.append(contentsOf: model)
                }
                self.totalCountGal = count
                
                CustomActivityIndicator.sharedInstance.hideIndicator(view: self.view)
                self.galleryUrl = imgUrl
                self.setupCollView()
            }
        }
        func getPress() {
            CustomActivityIndicator.sharedInstance.showIndicator(view: self.view)
            webService.model = "Pressreleases"
            webService.page = getString(anything: pageGal)
            webService.getGalleryData{ model, count,imgUrl  in
                guard let model else {
                    Global.shared.showBanner(message: .LanguageLocalisation.something_went_wrong_try_some_time)
                    CustomActivityIndicator.sharedInstance.hideIndicator(view: self.view)
                    return
                }
                if self.pageGal == 1 {
                    self.arrPress = model
                } else {
                    self.arrPress.append(contentsOf: model)
                }
                self.totalCountGal = count
                
                CustomActivityIndicator.sharedInstance.hideIndicator(view: self.view)
                self.PressReleaseUrl = imgUrl
                self.setupTblView()
            }
        }
    }

