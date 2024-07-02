//
//  SearchDataSourceDelegate.swift
//  loginDemo
//
//  Created by Priyal on 21/09/23.
//

import Foundation
import UIKit

class SearchDataSourceDelegate : NSObject {
    
    //MARK:- Types
    typealias T = String
    typealias ScrlView = UICollectionView
    typealias Delegate = ColViewDelegate
    var cellWidth : CGFloat = 0
    var index : Int = 0
    var deleteClickedCallBack: ((IndexPath) -> ())?
    //var comp : (() -> (()))
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
        let layout = UICollectionViewCenterLayout()
        layout.spacing = 5
        colView.setCollectionViewLayout(layout, animated: true)
        
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
        let cellTypes: [UICollectionViewCell.Type] = [SearchCollViewCell.self]
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
    @objc func btnDeleteClickedCallBack(sender: SearchCollViewCell) {
        guard let indexPath = self.colView.indexPath(for: sender) else { return }
        deleteClickedCallBack?(indexPath)
        arrSource.remove(at: indexPath.row)
        self.colView.deleteItems(at: [indexPath])
        //reloadData(arrData: arrSource)
//        self.colvw?.reloadData()
    }
}

//MARK:- UICollectionViewDelegate Methods
extension SearchDataSourceDelegate: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelect?(colView: collectionView, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.delegate?.willDisplay?(colView: collectionView, cell: cell, indexPath: indexPath)
    }
}

//MARK:- UICollectionViewDataSource Methods
extension SearchDataSourceDelegate: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(with: SearchCollViewCell.self, for: indexPath)
        cell.configureCell(data: arrSource[indexPath.row], arr: arrSource)
        cell.btnDeleteClickedCallBack = btnDeleteClickedCallBack
        return cell
    }
}

extension SearchDataSourceDelegate: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let cell = collectionView.dequeueReusableCell(with: SearchCollViewCell.self, for: indexPath)
//        cell.configureCell(data: arrSource[indexPath.row], arr: arrSource)
        var height = arrSource[indexPath.row].height(withConstrainedWidth: CGFloat.infinity, font: UIFont(name: "Poppins", size: 18)!)
        let extraSpacing : CGFloat = 70
        var width = arrSource[indexPath.row].width(withConstrainedHeight: height ?? 5, font: UIFont(name: "Poppins", size: 18)!)
        
        //let extraSpacing : CGFloat = colletionViewType == .recentSearch ? 60 : 55
        
        if ((width ?? 0) + extraSpacing) > collectionView.frame.width {
            width = collectionView.frame.width - extraSpacing
            height = arrSource[indexPath.row].height(withConstrainedWidth: width ?? 0, font: UIFont(name: "Poppins", size: 18)!)
        }
        
        return CGSize(width: (width ?? 0) + extraSpacing, height: (height ?? 0) + 5)
    }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 15
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
        
        
        
    }
