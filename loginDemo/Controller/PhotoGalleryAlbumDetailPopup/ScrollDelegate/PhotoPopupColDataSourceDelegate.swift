//
//  PhotoPopupColDelegateDataSource.swift
//  NWM
//
//  Created by Gunjan on 07/05/21.
//

import UIKit

class PhotoPopupColDataSourceDelegate: NSObject {
    
    typealias T = GalleryDetailsModel
    typealias ScrlView = UICollectionView
    typealias Delegate = ColViewDelegate
    
    
    //MARK:- Variables
    internal var arrSource: [GalleryDetailsModel] = []
    internal var delegate: ColViewDelegate?
    internal var scrlView: UICollectionView
    internal var imgURL = ""
    
    required init(arrData: [GalleryDetailsModel], delegate: ColViewDelegate, scrl: ScrlView,imgURL:String) {
        arrSource = arrData
        self.delegate = delegate
        scrlView = scrl
        self.imgURL = imgURL
        super.init()
        setUpScrlView()
    }
    
    //MARK:- Internal Methods
    internal func setUpScrlView() {
        registerCell()
        scrlView.delegate = self
        scrlView.dataSource = self
        if (arrSource.count > 0) {
            scrlView.backgroundView = nil
        } else {
            scrlView.backgroundView = UIView.makeNoRecordFoundView(frame: scrlView.bounds, msg: .LanguageLocalisation.no_record_found)
        }
    }
    
    //Register cells
    internal func registerCell() {
        scrlView.register(cellType: ColPhotoGalleryPopUp.self)
    }
    
    //MARK:- Public Methods
    func reloadScrlView(arr: [GalleryDetailsModel],imgUrl:String) {
        arrSource = arr
        self.imgURL = imgUrl
        scrlView.reloadData()
    }
    
    

}
//MARK:- UICollectionViewDelegate Methods
extension PhotoPopupColDataSourceDelegate: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelect?(colView: collectionView, indexPath: indexPath)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        delegate?.willDisplay?(colView: collectionView, cell: cell, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let getCell = cell as? ColPhotoGalleryPopUp {
            getCell.scrlViewMain?.setZoomScale(1.0, animated: false)
        }
    }
}

//MARK:- UICollectionViewDataSource Methods
extension PhotoPopupColDataSourceDelegate: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: ColPhotoGalleryPopUp.self, for: indexPath)
        cell.configureCell(data: self.arrSource[indexPath.row], imgURL: imgURL)
        return cell
    }
}

//MARK:- UICollectionViewDelegateFlowLayout Methods
extension PhotoPopupColDataSourceDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView.layoutIfNeeded()
          return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return sectionInset
    }
}
