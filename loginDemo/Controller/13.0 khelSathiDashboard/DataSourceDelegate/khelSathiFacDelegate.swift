//
//  khelSathiFacDelegate.swift
//  loginDemo
//
//  Created by Priyal on 04/07/23.
//


import Foundation
import UIKit

class khelSathiFacDelegate : NSObject {
    
    //MARK:- Types
    typealias T = String
    typealias ScrlView = UICollectionView
    typealias Delegate = ColViewDelegate
    
    //MARK:- Variables
    internal var arrSource: [T]
    internal weak var delegate: Delegate?
    internal var colView: ScrlView
    
    //MARK:- Initializer
    required init(arrData: [T], delegate: Delegate, scrl: ScrlView  ) {
        arrSource = arrData
        self.delegate = delegate
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
        let cellTypes: [UICollectionViewCell.Type] = [khelSathiCollViewCell.self]
        colView.register(cellTypes: cellTypes)
    }
    
    //MARK:- Public Methods
    func reloadData(arrData: [T] ) {
        arrSource = arrData
        
        colView.reloadData()
        
        if (arrData.count > 0) {
            colView.backgroundView = nil
        } else {
            colView.backgroundView = UIView.makeNoRecordFoundView(frame: colView.bounds, msg: .LanguageLocalisation.no_record_found)
        }
    }
}

//MARK:- UICollectionViewDelegate Methods
extension khelSathiFacDelegate: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelect?(colView: collectionView, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.delegate?.willDisplay?(colView: collectionView, cell: cell, indexPath: indexPath)
    }
}

//MARK:- UICollectionViewDataSource Methods
extension khelSathiFacDelegate: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(with: khelSathiCollViewCell.self, for: indexPath)
        
        cell.configFacData(data: arrSource[indexPath.row] , index : indexPath.row)
        return cell
    }
}

extension khelSathiFacDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: IS_IPAD ? (SCREEN_WIDTH - (IPAD_MARGIN)) : ((SCREEN_WIDTH/4)-20) , height: ((SCREEN_WIDTH/2)-70)/1.21)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

