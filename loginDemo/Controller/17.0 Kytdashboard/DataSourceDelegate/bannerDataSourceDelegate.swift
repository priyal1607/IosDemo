//
//  bannerDataSourceDelegate.swift
//  loginDemo
//
//  Created by Priyal on 11/09/23.
//

import Foundation
import UIKit
enum MandirCollViewType {
    case banner(padding: UIEdgeInsets, minimumLineSpace: CGFloat, minimumInteritemSpace: CGFloat)
    case shorts(padding: UIEdgeInsets, minimumLineSpace: CGFloat, minimumInteritemSpace: CGFloat)
    case trendingArticles(padding: UIEdgeInsets, minimumLineSpace: CGFloat, minimumInteritemSpace: CGFloat)
    case photos(padding: UIEdgeInsets, minimumLineSpace: CGFloat, minimumInteritemSpace: CGFloat)
    case otherCell(padding: UIEdgeInsets, minimumLineSpace: CGFloat, minimumInteritemSpace: CGFloat)
    case verticalCell(padding: UIEdgeInsets, minimumLineSpace: CGFloat, minimumInteritemSpace: CGFloat)
    case mantras(padding: UIEdgeInsets, minimumLineSpace: CGFloat, minimumInteritemSpace: CGFloat)
    case none
}
class bannerDataSourceDelegate : NSObject {
    
    //MARK:- Types
    typealias T = MandirItemModel
    typealias ScrlView = UICollectionView
    typealias Delegate = ColViewDelegate
    //MARK:- Variables
    internal var arrSource: [T]
    internal weak var delegate: Delegate?
    internal var colView: ScrlView
    internal var mandirCollViewType: MandirCollViewType = .none
    
    
    //MARK:- Initializer
    required init(arrData: [T], delegate: Delegate, scrl: ScrlView ,type:MandirCollViewType ) {
        arrSource = arrData
        self.delegate = delegate
        self.mandirCollViewType = type
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
    
       
        switch mandirCollViewType  {
        case .banner(_, _, _):
            if let layout = self.colView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal
               
            }
        case .shorts(_, _, _):
            if let layout = self.colView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal
               
            }
        case .trendingArticles(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
            if let layout = self.colView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal
               
            }
        case .photos(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
            if let layout = self.colView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal
               
            }
        case .otherCell(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
            if let layout = self.colView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal
               
            }
        case .verticalCell(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
            if let layout = self.colView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .vertical
               
            }
        case .mantras(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
            let collectionFlowLayout = TagCellLayout(alignment: (arrSource.count < 4) ? .left : .center, delegate: self)
            collectionFlowLayout.minimumLineSpacing = 0
            collectionFlowLayout.minimumInteritemSpacing = 0
            self.colView.collectionViewLayout = collectionFlowLayout
            self.colView.collectionViewLayout.invalidateLayout()
            //self.colView.reloadData()
        case .none:
            if let layout = self.colView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal
               
            }
        
        }
       
        self.colView.collectionViewLayout.invalidateLayout()
    }
    
    fileprivate func registerCell() {
        colView.register(cellType: BannerCollViewCell.self)
        colView.register(cellType: shortsCollViewCell.self)
        colView.register(cellType: MantrasCollViewCell.self)
        colView.register(cellType: TrendingArticleCollViewCell.self)
        colView.register(cellType: PopularVideoCollViewCell.self)
        }
    
    //MARK:- Public Methods
    func reloadData(arrData: [T] , type:MandirCollViewType) {
        colView.delegate = self
        colView.dataSource = self
        arrSource = arrData
        self.mandirCollViewType = type

        if (arrData.count > 0) {
            colView.backgroundView = nil
        } else {
            colView.backgroundView = UIView.makeNoRecordFoundView(frame: colView.bounds, msg: .LanguageLocalisation.no_record_found)
        }
        switch mandirCollViewType  {
        case .banner(_, _, _):
            if let layout = self.colView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal
               
            }
        case .shorts(_, _, _):
            if let layout = self.colView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal
               
            }
        case .trendingArticles(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
            if let layout = self.colView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal
               
            }
        case .photos(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
            if let layout = self.colView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal
               
            }
        case .otherCell(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
            if let layout = self.colView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .horizontal
              
            }
        case .verticalCell(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
            if let layout = self.colView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .vertical
                
            }
       
        case .mantras(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
            let collectionFlowLayout = TagCellLayout(alignment: (arrSource.count < 4) ? .left : .center, delegate: self)
            collectionFlowLayout.minimumLineSpacing = 0
            collectionFlowLayout.minimumInteritemSpacing = 0
            colView.collectionViewLayout = collectionFlowLayout
            colView.contentInset = .init(top: 3, left: 0, bottom: 3, right: 0)
           
//            if let layout = self.colView.collectionViewLayout as? UICollectionViewFlowLayout {
//                layout.scrollDirection = .vertical
//            }
            break
        case .none:
            break
       
        }
        self.colView.collectionViewLayout.invalidateLayout()
        colView.reloadData()
        
    }
}

//MARK:- UICollectionViewDelegate Methods
extension bannerDataSourceDelegate: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelect?(colView: collectionView, indexPath: indexPath)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.delegate?.willDisplay?(colView: collectionView, cell: cell, indexPath: indexPath)
    }
}

//MARK:- UICollectionViewDataSource Methods
extension bannerDataSourceDelegate: UICollectionViewDataSource , TagCellLayoutDelegate {
    func tagCellLayoutTagSize(layout: TagCellLayout, atIndex index: Int) -> CGSize {
        let cWidthHeight = (SCREEN_WIDTH - 30) / 4
        return CGSize(width: cWidthHeight, height: cWidthHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch mandirCollViewType  {
        case .banner(_, _, _):
            let cell = collectionView.dequeueReusableCell(with: BannerCollViewCell.self, for: indexPath)
            
            cell.configureCell(data: arrSource[indexPath.row])
            return cell
        case .shorts(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
            let cell = collectionView.dequeueReusableCell(with: shortsCollViewCell.self, for: indexPath)
            
            cell.configureCell(data: arrSource[indexPath.row])
            return cell
        case .trendingArticles(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
            let cell = collectionView.dequeueReusableCell(with: TrendingArticleCollViewCell.self, for: indexPath)
            
            cell.configureCell(data: arrSource[indexPath.row])
            
            return cell
        case .photos(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
            let cell = collectionView.dequeueReusableCell(with: shortsCollViewCell.self, for: indexPath)
            
            cell.configureCell(data: arrSource[indexPath.row])
            return cell
        case .otherCell(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
            let cell = collectionView.dequeueReusableCell(with: shortsCollViewCell.self, for: indexPath)
            
            cell.configureCell(data: arrSource[indexPath.row])
            return cell
        case .verticalCell(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
            let cell = collectionView.dequeueReusableCell(with: PopularVideoCollViewCell.self, for: indexPath)
            
            cell.configureCell(data: arrSource[indexPath.row])
            return cell
        case .mantras(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
            let cell = collectionView.dequeueReusableCell(with: MantrasCollViewCell.self, for: indexPath)
            
            cell.configureCell(data: arrSource[indexPath.row])
            return cell
        
        case .none:
            let cell = collectionView.dequeueReusableCell(with: shortsCollViewCell.self, for: indexPath)
            cell.configureCell(data: arrSource[indexPath.row])
            return cell
            
        
        }
    }
}
extension bannerDataSourceDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch mandirCollViewType  {
        case .banner(_, _, _):
            return CGSize(width: SCREEN_WIDTH, height: 250)
        case .shorts(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
            return CGSize(width: SCREEN_WIDTH/1.3, height: 170)
        case .trendingArticles(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
            return CGSize(width: SCREEN_WIDTH/4, height: SCREEN_WIDTH/3.5 * 1.5)
        case .photos(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
            return CGSize(width: SCREEN_WIDTH/1.3, height: 170)
        case .otherCell(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
            break
        case .verticalCell(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
            return CGSize(width: SCREEN_WIDTH/2 - 23, height: 140)
        case .mantras(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
            return CGSize(width: SCREEN_WIDTH/4 - 40 , height: SCREEN_WIDTH/4 - 20 )
       
        case .none:
            return CGSize(width: screenWidth, height: 200)
        
        }
        return CGSize(width: IS_IPAD ? (SCREEN_WIDTH - (IPAD_MARGIN)) : ((SCREEN_WIDTH)) , height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch mandirCollViewType  {
        case .banner(_, _, _):
            return 0
        case .shorts(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
            return 0
        case .trendingArticles(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
            return 15
        case .photos(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
            return 0
        case .otherCell(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
            break
        case .verticalCell(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
            return 15
        case .mantras(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
            return 20
        
        case .none:
            return 0
        
        }
        return 0
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        switch mandirCollViewType  {
//        case .banner(_, _, _):
//            return 0
//        case .shorts(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
//            return 0
//        case .trendingArticles(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
//            return 15
//        case .photos(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
//            return 0
//        case .otherCell(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
//            break
//        case .verticalCell(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
//            break
//        case .mantras(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
//            return 20
//        case .none:
//            return 0
//
//        }
//        return 0
//    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    switch mandirCollViewType  {
    case .banner(_, _, _):
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    case .shorts(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    case .trendingArticles(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    case .photos(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    case .otherCell(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    case .verticalCell(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    case .mantras(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    case .none:
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    }
}
}

