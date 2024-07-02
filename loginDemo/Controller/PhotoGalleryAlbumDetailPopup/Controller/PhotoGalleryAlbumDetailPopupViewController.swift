//
//  PhotoGalleryDetailViewController.swift
//  MyGovMaharashtra
//
//  Created by Jignesh Ashara on 27/12/17.
//  Copyright © 2017 Jignesh Ashara. All rights reserved.
//

import UIKit
import SDWebImage

protocol getPopupData {
    func getUpdatedArrAndOffset(arr:[GalleryDetailsModel],offset:Int,imgURL:String)
}

class PhotoGalleryAlbumDetailPopupViewController: HeaderViewController
{    
    //MARK:- Outlets
    //UIView
    @IBOutlet weak var viewForImage: UIView!
    @IBOutlet weak var viewMain: UIView!
    //UIImageView
    @IBOutlet weak var imgView: UIImageView!
    
    //UIScrollView
    @IBOutlet weak var scrlView: UIScrollView!
    
    //UILabel
    @IBOutlet weak var lblTitle: UILabel!
    
    //UICollectionView
    @IBOutlet weak var colPopUp: UICollectionView!

    //MARK:- Variables
    //Local
    var photoPopupColDataSourceDelegate : PhotoPopupColDataSourceDelegate!
    
    var webService = GalleryDetailsWebServicesModel()
    
    var getPopupDatadelegate:getPopupData?
    //Public
    var arrSource:[GalleryDetailsModel] = []
    var index = 0
    var catId = ""
    var totalCount = 0
    var page = 1
    var imgURL = ""
    
    //MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewController()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view!.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    //MARK:- Private Methods
    //ViewController set up
    fileprivate func setUpViewController() {
        setUpHeader()
        setUpView()
        setupLbl()
        setupValues()
        setupColView(imgUrl: imgURL)
        scrollToIndexCell()
    }
    
    //Header set up
    fileprivate func setUpHeader() {
        self.setUpHeaderTitle(strHeaderTitle: "Details")
        self.viewHeader.lblHeaderTitle.textColor = .white
        setHeaderView_BackImage()
        
    }
    
    //View set up
    fileprivate func setUpView() {
        self.lblTitle.superview?.addShadow()
    }
    
    func setupColView(imgUrl: String) {
        
        if photoPopupColDataSourceDelegate != nil {
            photoPopupColDataSourceDelegate.reloadScrlView(arr:arrSource, imgUrl: imgURL )
        } else {
            photoPopupColDataSourceDelegate = PhotoPopupColDataSourceDelegate(arrData: arrSource, delegate: self, scrl: colPopUp, imgURL: imgUrl)
        }
    }
    
    func scrollToIndexCell() {
        DispatchQueue.main.async { [weak self] in
            self?.colPopUp.scrollToItem(at: IndexPath(row: self?.index ?? 0, section: 0), at: .centeredHorizontally, animated: false)
        }
    }
    
    private func setupValues() {
        self.imgView.downloadImage(with: imgURL + self.arrSource[index].image, placeholderImage: .ic_user_placeholder, options: .continueInBackground, progess: nil, completed: nil)
        self.lblTitle.text = ""//getString(anything: arrSource[index].title)
    }
    
    private func setupLbl() {
        self.lblTitle.textColor = .customBlack
        self.lblTitle.font = .semiBoldSystemFont(withSize: .value)
    }
    
    //MARK:- IBActions
    override func btnBackTapped(_ sender: UIButton) {
        
            UIView.hideKeyBoard()
        getPopupDatadelegate?.getUpdatedArrAndOffset(arr: self.arrSource, offset: page, imgURL: imgURL)
        self.navigationController?.popViewController(animated: true)
    }
}

extension PhotoGalleryAlbumDetailPopupViewController:UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return true
    }
}

extension PhotoGalleryAlbumDetailPopupViewController : ColViewDelegate {
    func willDisplay(colView: UICollectionView, cell: UICollectionViewCell, indexPath: IndexPath) {
        if indexPath.row == arrSource.count - 2,
           arrSource.count < totalCount {
            page += 1
            getGalleryDetails()
        }
    }
}

extension PhotoGalleryAlbumDetailPopupViewController {
        func getGalleryDetails() {
            CustomActivityIndicator.sharedInstance.showIndicator(view: self.view)
            webService.model = "Galleries"
            webService.page = getString(anything: page)
            webService.catID = catId
            webService.getGalleryDetails{ model, count,imgUrl  in
                guard let model else {
                    Global.shared.showBanner(message: .LanguageLocalisation.something_went_wrong_try_some_time)
                    CustomActivityIndicator.sharedInstance.hideIndicator(view: self.view)
                    return
                }
                if self.page == 1 {
                    self.arrSource = model
                } else {
                    self.arrSource.append(contentsOf: model)
                }
                self.totalCount = count
                
                CustomActivityIndicator.sharedInstance.hideIndicator(view: self.view)
                self.imgURL = imgUrl
                self.setupColView(imgUrl: imgUrl)
            }
        }
}
