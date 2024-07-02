//
//  ColPhotoGalleryPopUp.swift
//  NWM
//
//  Created by Gunjan on 07/05/21.
//

import UIKit

class ColPhotoGalleryPopUp: UICollectionViewCell {
    
    //MARK:- Outlets
    //UIView
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var viewImg: UIView!
    @IBOutlet weak var viewTitle: UIView!
   
    //UIImageView
    @IBOutlet weak var imgPopUp: UIImageView!
    
    //UIScrollView
    @IBOutlet weak var scrlViewMain: UIScrollView!
    
    //UILabel
    @IBOutlet weak var lblTitle: UILabel!
    
    //Variable
    //Local
    fileprivate var photoGalleryAlbumDetailPopupScrollViewDelegate: PhotoGalleryAlbumDetailPopupScrollViewDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }
    
    fileprivate func setupCell() {
        setUpView()
        setupLbl()
        setUpPhotoScrlView()
    }

    //View setup
    fileprivate func setUpView() {
        //self.viewTitle?.addShadow()
    }
    
    //Label setup
    private func setupLbl() {
        self.lblTitle.textColor = .customBlack
        self.lblTitle.font = .semiBoldSystemFont(withSize: .value)
    }
    //ScrollView set up
    fileprivate func setUpPhotoScrlView() {
        photoGalleryAlbumDetailPopupScrollViewDelegate = PhotoGalleryAlbumDetailPopupScrollViewDelegate(scrl: scrlViewMain, viewForZooming: imgPopUp)
    }
    
    func configureCell(data:GalleryDetailsModel,imgURL:String) {
        self.imgPopUp.downloadImage(with: imgURL + data.image, placeholderImage: .image_placeholder, options: .continueInBackground, progess: nil)
        self.lblTitle.text = ""//data.
    }
    
}
