//
//  NewsDataSourceDelegate.swift
//  loginDemo
//
//  Created by Chelsi on 26/05/23.
//

import Foundation



import UIKit
class NewsDataSourceDelegate : NSObject {
    
    typealias colview = UICollectionView
    typealias delegate = ColViewDelegate
    typealias pgc = UIPageControl
    
    var arr : [NewsModel]
    var colv  : colview
    var del : delegate
    var pgcontrol:pgc

    init( arr:[NewsModel],colv : colview , del : delegate ,pgcontrol:pgc){
        self.arr = arr
        self.colv = colv
        self.del = del
        self.pgcontrol = pgcontrol
        super.init()
        setupTableView()
    }
    
    func reload(arr : [NewsModel]) {
        self.arr = arr
        colv.reloadData()
    }
    
    
    
    fileprivate func setupTableView(){
        let nib = UINib(nibName: "NewsCollVC", bundle: nil)
        colv.register(nib, forCellWithReuseIdentifier: "NewsCollVC")
        colv.delegate = self
        colv.dataSource = self
    }
}
extension NewsDataSourceDelegate : UICollectionViewDelegate {
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            self.del.didSelect?(colView: collectionView, indexPath: indexPath)
        
    }
    
}

extension NewsDataSourceDelegate : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pgcontrol.numberOfPages = arr.count
        pgcontrol.isHidden = !(arr.count > 1)
        
        return self.arr.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCollVC", for: indexPath) as! NewsCollVC
        cell1.configcell(data: arr[indexPath.row])
        return cell1
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let witdh = scrollView.frame.width - (scrollView.contentInset.left*2)
        let index = scrollView.contentOffset.x / witdh
        let roundedIndex = round(index)
        self.pgcontrol.currentPage = Int(roundedIndex)
    }

}
extension NewsDataSourceDelegate : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let a = colv.frame.width
        return CGSize(width: a, height:320)
        
    }
   
}

