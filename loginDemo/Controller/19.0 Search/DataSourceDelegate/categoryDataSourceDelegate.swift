//
//  categoryDataSourceDelegate.swift
//  loginDemo
//
//  Created by Priyal on 22/09/23.
//

import Foundation
import UIKit

class categoryDataSourceDelegate : NSObject {
    
    //MARK:- Types
    typealias T = SearchModel
    typealias ScrlView = UICollectionView
    typealias Delegate = ColViewDelegate
    var cellWidth : CGFloat = 0
    var index : Int = 0
    var selectedIndexPaths: [IndexPath] = []
    var isfromcat : Bool = false
  //  var deleteClickedCallBack: ((IndexPath) -> ())?
    //var comp : (() -> (()))
    //MARK:- Variables
    internal var arrSource: [T]
    internal weak var delegate: Delegate?
    internal var colView: ScrlView
    
    //MARK:- Initializer
    required init(arrData: [T], delegate: Delegate, scrl: ScrlView , isfromcat : Bool) {
        arrSource = arrData
        self.delegate = delegate
        self.isfromcat = isfromcat
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
    func reloadData(arrData: [T] , isfromcat : Bool) {
        arrSource = arrData
        self.isfromcat = isfromcat
        colView.reloadData()
        
        if (arrData.count > 0) {
            colView.backgroundView = nil
        } else {
            colView.backgroundView = UIView.makeNoRecordFoundView(frame: colView.bounds, msg: .LanguageLocalisation.no_record_found)
        }
    }
//    @objc func btnDeleteClickedCallBack(sender: SearchCollViewCell) {
//        guard let indexPath = self.colView.indexPath(for: sender) else { return }
//        deleteClickedCallBack?(indexPath)
//        arrSource.remove(at: indexPath.row)
//        self.colView.deleteItems(at: [indexPath])
//        UserPreferences.set(value: arrSource, forKey: "arr")
////        self.colvw?.reloadData()
//    }
}

//MARK:- UICollectionViewDelegate Methods
extension categoryDataSourceDelegate: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelect?(colView: collectionView, indexPath: indexPath)
        if selectedIndexPaths.contains(indexPath) {
                if let index = selectedIndexPaths.firstIndex(of: indexPath) {
                        selectedIndexPaths.remove(at: index)
                    }
                } else {
                    selectedIndexPaths.append(indexPath)
                }
                collectionView.reloadItems(at: [indexPath])
            
                
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.delegate?.willDisplay?(colView: collectionView, cell: cell, indexPath: indexPath)
        
    }
}

//MARK:- UICollectionViewDataSource Methods
extension categoryDataSourceDelegate: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(with: SearchCollViewCell.self, for: indexPath)
        cell.configCellCategory(data: arrSource[indexPath.row])
        if isfromcat {
            cell.imgUser.image = UIImage(named: "trending")
        } else {
            cell.imgUser.image = UIImage(named: "user-placeholder")
        }
        cell.btnCancel.isHidden = true
        // cell.btnDeleteClickedCallBack = btnDeleteClickedCallBack
        
        if selectedIndexPaths.contains(indexPath) {
            cell.mainView.backgroundColor = UIColor(hexStringToUIColor: "#E8ADA2")
        } else {
            cell.mainView.backgroundColor = .white
        }
        
        //        cell.compForward = {
        //            self.arrSource.remove(at: indexPath.row)
        //        }
        //cellWidth = cell.lblSearch.frame.width
        return cell
    }
}

extension categoryDataSourceDelegate: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height = arrSource[indexPath.row].title?.height(withConstrainedWidth: CGFloat.infinity, font: UIFont(name: "Poppins", size: 18)!)
        
        var width = arrSource[indexPath.row].title?.width(withConstrainedHeight: height ?? 5, font: UIFont(name: "Poppins", size: 18)!)
        let extraSpacing : CGFloat = 70
        //let extraSpacing : CGFloat = colletionViewType == .recentSearch ? 60 : 55
        
        if ((width ?? 0) + extraSpacing) > collectionView.frame.width {
            width = collectionView.frame.width - extraSpacing
            height = arrSource[indexPath.row].title?.height(withConstrainedWidth: width ?? 0, font: UIFont(name: "Poppins", size: 18)!)
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
