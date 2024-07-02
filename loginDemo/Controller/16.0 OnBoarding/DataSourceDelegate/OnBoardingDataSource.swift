//
//  OnBoardingDataSource.swift
//  loginDemo
//
//  Created by Priyal on 01/09/23.
//

import Foundation
import UIKit

class OnBoardingDataSource : NSObject {
    
    //MARK:- Types
    typealias T = String
    typealias ScrlView = UICollectionView
    typealias Delegate = ColViewDelegate
    
    //MARK:- Variables
    internal var arrSource: [T]
    internal weak var delegate: Delegate?
    internal var colView: ScrlView
    let kEdgeInset:CGFloat = 0
    let minimumInterItemandLinespacing:CGFloat = 0
    var index:Int = 0
    
    
    //MARK:- Initializer
    required init(arrData: [T], delegate: Delegate, scrl: ScrlView) {
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
        let cellTypes: [UICollectionViewCell.Type] = [OnBoardingCollView.self]
        colView.register(cellTypes: cellTypes)
    }
    
    //MARK:- Public Methods
    func reloadData(arrData: [T]) {
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
extension OnBoardingDataSource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelect?(colView: collectionView, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.delegate?.willDisplay?(colView: collectionView, cell: cell, indexPath: indexPath)
    }
}

//MARK:- UICollectionViewDataSource Methods
extension OnBoardingDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(with: OnBoardingCollView.self, for: indexPath)
        
        cell.configCell(data: arrSource[indexPath.row] , index : indexPath.row)
        return cell
    }
}

extension OnBoardingDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: IS_IPAD ? (SCREEN_WIDTH - (IPAD_MARGIN)) : SCREEN_WIDTH , height: SCREEN_HEIGHT)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInterItemandLinespacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInterItemandLinespacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: kEdgeInset, left: kEdgeInset, bottom: kEdgeInset, right: kEdgeInset)
    }
}

extension OnBoardingDataSource:UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (scrollView == colView) {
            let total = scrollView.contentSize.width - scrollView.bounds.width
            let offset = scrollView.contentOffset.x
            let percent = Double(offset / total)
            let progress = percent * Double(self.arrSource.count - 1)
            delegate?.changeCurrentPage?(index: progress)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView == colView) {
            let total = scrollView.contentSize.width - scrollView.bounds.width
            let offset = scrollView.contentOffset.x
            let percent = Double(offset / total)
            let progress = percent * Double(self.arrSource.count - 1)
            delegate?.changeCurrentPage?(index: progress)
        }
    }
}

