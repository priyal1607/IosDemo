//
//  GallerySeeAllVC.swift
//  loginDemo
//
//  Created by Priyal on 29/06/23.
//

import UIKit

class GallerySeeAllVC: HeaderViewController {
    
    
    @IBOutlet weak var collView: UICollectionView!
    
    fileprivate var gallerySeeAllDelegate: GallerySeeAllDelegate!
    fileprivate var arrGallery : [GalleryDetailsModel] = []
    
    var catid = ""
    var totalCount = 0
    var webService = GalleryDetailsWebServicesModel()
    var page = 1
    var imgURL = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getGalleryDetails()
        setUpHeader()

        // Do any additional setup after loading the view.
    }
    func setUpHeader() {
        self.setUpHeaderTitle(strHeaderTitle: "Gallery")
        self.viewHeader.lblHeaderTitle.textColor = .white
        
    }
    
    fileprivate func setupCollView(imgUrl:String) {
        if self.gallerySeeAllDelegate == nil {
            self.gallerySeeAllDelegate = .init(arrData: arrGallery, delegate: self, scrl: collView, imgURL: imgUrl)
        } else {
            self.gallerySeeAllDelegate?.reloadData(arrData: arrGallery, imgURL: imgUrl)
        }
    }

}
extension GallerySeeAllVC {
    func getGalleryDetails() {
        CustomActivityIndicator.sharedInstance.showIndicator(view: self.view)
        webService.model = "Galleries"
        webService.page = getString(anything: page)
        webService.catID = catid
        webService.getGalleryDetails{ model, count,imgUrl  in
            guard let model else {
                Global.shared.showBanner(message: .LanguageLocalisation.something_went_wrong_try_some_time)
                CustomActivityIndicator.sharedInstance.hideIndicator(view: self.view)
                return
            }
            if self.page == 1 {
                self.arrGallery = model
            } else {
                self.arrGallery.append(contentsOf: model)
            }
            self.totalCount = count
            
            CustomActivityIndicator.sharedInstance.hideIndicator(view: self.view)
            self.imgURL = imgUrl
            self.setupCollView(imgUrl: imgUrl)
        }
    }
}
extension GallerySeeAllVC :ColViewDelegate {
    
    func didSelect(colView: UICollectionView, indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "PhotoGalleryAlbumDetailPopup", bundle: nil)
        let dvc = storyboard.instantiateViewController(withIdentifier: "PhotoGalleryAlbumDetailPopupViewController")as! PhotoGalleryAlbumDetailPopupViewController
        dvc.arrSource = arrGallery
        dvc.index = indexPath.row
        dvc.totalCount = self.totalCount
        dvc.catId = self.arrGallery[indexPath.row].id
        dvc.page = self.page
        dvc.getPopupDatadelegate = self
        dvc.imgURL = imgURL
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    func willDisplay(colView: UICollectionView, cell: UICollectionViewCell, indexPath: IndexPath) {
        if (indexPath.row == self.arrGallery.count - 1) && (totalCount > arrGallery.count) {
            page += 1
            getGalleryDetails()
        }
    }
}

extension GallerySeeAllVC:getPopupData{
    func getUpdatedArrAndOffset(arr: [GalleryDetailsModel], offset: Int,imgURL:String) {
        if self.arrGallery.count < arr.count || self.page < offset {
            self.arrGallery = arr
            self.page = offset
            self.setupCollView(imgUrl: imgURL)
        }
    }
    
    
}
