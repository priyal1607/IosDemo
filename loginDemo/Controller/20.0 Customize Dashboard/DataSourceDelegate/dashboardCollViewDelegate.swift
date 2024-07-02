//
//  dashboardCollViewDelegate.swift
//  loginDemo
//
//  Created by Priyal on 26/09/23.
//

import Foundation
import UIKit

class dashboardCollViewDelegate : NSObject {
    
    //MARK:- Types
    typealias T = dashboardList
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
extension dashboardCollViewDelegate: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelect?(colView: collectionView, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.delegate?.willDisplay?(colView: collectionView, cell: cell, indexPath: indexPath)
    }
}

//MARK:- UICollectionViewDataSource Methods
extension dashboardCollViewDelegate: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(with: DashboardCollViewCell.self, for: indexPath)
        cell.imgCircle.tintColor = .white
        cell.configureCell(data: arrSource[indexPath.row])
        return cell
    }
}

extension dashboardCollViewDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: IS_IPAD ? (SCREEN_WIDTH - (IPAD_MARGIN)) : ((SCREEN_WIDTH/3)-15) , height: ((SCREEN_WIDTH/2)-70))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

