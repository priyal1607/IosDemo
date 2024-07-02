//
//  IMAcollViewDelegate.swift
//  loginDemo
//
//  Created by Priyal on 28/09/23.
//

import Foundation
import Foundation
import UIKit

class IMAcollViewDelegate : NSObject {
    
    //MARK:- Types
    typealias T = String
    typealias ScrlView = UICollectionView
    typealias Delegate = ColViewDelegate
    
    //MARK:- Variables
    internal var arrSource: [T]
    internal weak var delegate: Delegate?
    internal var colView: ScrlView
  
    //MARK:- Initializer
    required init(arrData: [T], delegate: Delegate, scrl: ScrlView ) {
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
        let cellTypes: [UICollectionViewCell.Type] = [DashboardCollViewCell.self]
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
extension IMAcollViewDelegate: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelect?(colView: collectionView, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.delegate?.willDisplay?(colView: collectionView, cell: cell, indexPath: indexPath)
    }
}

//MARK:- UICollectionViewDataSource Methods
extension IMAcollViewDelegate: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(with: DashboardCollViewCell.self, for: indexPath)
        cell.imgCircle.tintColor = .lightGray
        if indexPath.row == 0 {
            cell.imgView.backgroundColor = UIColor(hexStringToUIColor: "EFB6EA", alpha: 1.0)
        } else {
            cell.imgView.backgroundColor = UIColor(hexStringToUIColor: "9EF3E4", alpha: 1.0)
        }
        cell.configureCellIMA(index: indexPath.row)
        cell.addShadow()
        return cell
    }
}

extension IMAcollViewDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: IS_IPAD ? (SCREEN_WIDTH - (IPAD_MARGIN)) : ((SCREEN_WIDTH/2)-30) , height: 180)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

