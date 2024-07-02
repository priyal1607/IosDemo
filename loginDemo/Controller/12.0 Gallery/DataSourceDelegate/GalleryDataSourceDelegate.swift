//
//  GalleryDataSourceDelegate.swift
//  loginDemo
//
//  Created by Priyal on 29/06/23.
//

import Foundation
import UIKit

class GalleryDataSourceDelegate : NSObject {
    
    //MARK:- Types
    typealias T = PressReleaseResult
    typealias ScrlView = UICollectionView
    typealias Delegate = ColViewDelegate
    
    //MARK:- Variables
    internal var arrSource: [T]
    internal weak var delegate: Delegate?
    internal var colView: ScrlView
    internal var imgURL: String
    
    //MARK:- Initializer
    required init(arrData: [T], delegate: Delegate, scrl: ScrlView ,imgUrl:String ) {
        arrSource = arrData
        self.delegate = delegate
        self.imgURL = imgUrl
        colView = scrl
      
        super.init()
        setUp()
    }
    
    //MARK:- Private Methods
    fileprivate func setUp() {
        setUpColView()
    }
    
    fileprivate func setUpColView() {
        registerCell()
        colView.delegate = self
        colView.dataSource = self
    }
    
    fileprivate func registerCell() {
        let cellTypes: [UICollectionViewCell.Type] = [GalleryCollViewCell.self]
        colView.register(cellTypes: cellTypes)
    }
    
    //MARK:- Public Methods
    func reloadData(arrData: [T] , imgUrl:String ) {
        arrSource = arrData
        self.imgURL = imgUrl
        colView.reloadData()
        
        if (arrData.count > 0) {
            colView.backgroundView = nil
        } else {
            colView.backgroundView = UIView.makeNoRecordFoundView(frame: colView.bounds, msg: .LanguageLocalisation.no_record_found)
        }
    }
}

//MARK:- UICollectionViewDelegate Methods
extension GalleryDataSourceDelegate: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelect?(colView: collectionView, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.delegate?.willDisplay?(colView: collectionView, cell: cell, indexPath: indexPath)
    }
}

//MARK:- UICollectionViewDataSource Methods
extension GalleryDataSourceDelegate: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(with: GalleryCollViewCell.self, for: indexPath)
        
        cell.configureGalleryCell(data: arrSource[indexPath.row] , imgUrl:imgURL)
        return cell
    }
}

extension GalleryDataSourceDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: IS_IPAD ? (SCREEN_WIDTH - (IPAD_MARGIN)) : ((SCREEN_WIDTH/2)-26) , height: ((SCREEN_WIDTH/2)-32)/1.21)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

