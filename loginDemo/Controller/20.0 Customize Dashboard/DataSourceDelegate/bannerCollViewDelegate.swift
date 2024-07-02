//
//  bannerCollViewDelegate.swift
//  loginDemo
//
//  Created by Priyal on 26/09/23.
//

import Foundation
import UIKit
class bannerCollViewDelegate : NSObject {
    
    typealias colview = UICollectionView
    typealias delegate = ColViewDelegate
    let minimumInterItemandLinespacing:CGFloat = 0
    let kEdgeInset:CGFloat = 0
    
    var arr : [ListModel]
    var colv  : colview
    var del : delegate
   

    init( arr:[ListModel],colv : colview , del : delegate){
        self.arr = arr
        self.colv = colv
        self.del = del
      
        super.init()
        setupTableView()
    }
    
    func reload(arr : [ListModel]) {
        self.arr = arr
        colv.reloadData()
    }
    
    
    
    fileprivate func setupTableView(){
        let nib = UINib(nibName: "topCollView", bundle: nil)
        colv.register(nib, forCellWithReuseIdentifier: "topCollView")
        colv.delegate = self
        colv.dataSource = self
    }
}
extension bannerCollViewDelegate : UICollectionViewDelegate {
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            self.del.didSelect?(colView: collectionView, indexPath: indexPath)
        
    }
    
}

extension bannerCollViewDelegate : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
       // pgcontrol.isHidden = !(arr.count > 1)
        
        return self.arr.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "topCollView", for: indexPath) as! topCollView
        cell1.configcell(data: arr[indexPath.row])
        return cell1
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let witdh = scrollView.frame.width - (scrollView.contentInset.left*2)
//        let index = scrollView.contentOffset.x / witdh
//        let roundedIndex = round(index)
//        //self.pgcontrol.currentPage = Int(roundedIndex)
//    }

}
extension bannerCollViewDelegate : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let a = colv.frame.width
        return CGSize(width: a, height:300)
        
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

extension bannerCollViewDelegate:UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (scrollView == colv) {
            let total = scrollView.contentSize.width - scrollView.bounds.width
            let offset = scrollView.contentOffset.x
            let percent = Double(offset / total)
            let progress = percent * Double(self.arr.count - 1)
            del.changeCurrentPage?(index: progress)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView == colv) {
            let total = scrollView.contentSize.width - scrollView.bounds.width
            let offset = scrollView.contentOffset.x
            let percent = Double(offset / total)
            let progress = percent * Double(self.arr.count - 1)
            del.changeCurrentPage?(index: progress)
        }
    }
}
struct MyConstraint {
  static func changeMultiplier(_ constraint: NSLayoutConstraint, multiplier: CGFloat) -> NSLayoutConstraint {
    let newConstraint = NSLayoutConstraint(
      item: constraint.firstItem,
      attribute: constraint.firstAttribute,
      relatedBy: constraint.relation,
      toItem: constraint.secondItem,
      attribute: constraint.secondAttribute,
      multiplier: multiplier,
      constant: constraint.constant)

    newConstraint.priority = constraint.priority

    NSLayoutConstraint.deactivate([constraint])
    NSLayoutConstraint.activate([newConstraint])

    return newConstraint
  }
}
