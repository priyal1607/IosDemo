//
//  HomePageDataSourceDelegate.swift
//  loginDemo
//
//  Created by Chelsi on 24/05/23.
//

import Foundation


import UIKit
class HomePageDataSourceDelegate : NSObject {
    
    typealias colview = UICollectionView
    typealias delegate = ColViewDelegate
    
    var arr : [HomePageModel]
    var colv  : colview
    var del : delegate
    var height : CGFloat
    init( arr:[HomePageModel],colv : colview , del : delegate ,height:CGFloat ){
        self.arr = arr
        self.colv = colv
        self.del = del
        self.height = height
        super.init()
        setupTableView()
    }
    
    func reload(arr : [HomePageModel]) {
        self.arr = arr
        colv.reloadData()
    }
    
    
    
    fileprivate func setupTableView(){
        let nib = UINib(nibName: "HomePageCollVC", bundle: nil)
        colv.register(nib, forCellWithReuseIdentifier: "HomePageCollVC")
        colv.delegate = self
        colv.dataSource = self
    }
}
extension HomePageDataSourceDelegate : UICollectionViewDelegate {
    
}

extension HomePageDataSourceDelegate : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomePageCollVC", for: indexPath) as! HomePageCollVC
        cell.configcell(data: arr[indexPath.row])
        return cell
    }
    
    
}
extension HomePageDataSourceDelegate : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let a = colv.frame.width/2-20
        return CGSize(width: a, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
}

