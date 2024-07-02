//
//  CollectionViewDatasourceDelegate.swift
//  loginDemo
//
//  Created by Chelsi on 27/04/23.
//
import UIKit
class CollectionViewDatasourceDelegate:NSObject {
    
    typealias collview = UICollectionView
    typealias arr = DashboardModel
    typealias delegate = ColViewDelegate
    
    var arrSrc:[arr]
    var colView : collview
    var del : delegate
    
    init(arrSrc:[arr] , colView:collview , del : delegate){
        self.arrSrc = arrSrc
        self.colView = colView
        self.del = del
        super.init()
        setupTable()
    }
    
    fileprivate func setupTable(){
        colView.delegate = self
        colView.dataSource = self
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        colView.register(nib, forCellWithReuseIdentifier: "CollectionViewCell")
    }
    func reloadData(arr: [DashboardModel]) {
        arrSrc = arr
        colView.reloadData()
    }
}
extension CollectionViewDatasourceDelegate:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.del.didSelect?(colView: collectionView, indexPath: indexPath)
    }
}

extension CollectionViewDatasourceDelegate : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrSrc.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colView.dequeueReusableCell(withReuseIdentifier:"CollectionViewCell" , for: indexPath) as! CollectionViewCell
        cell.configureCell(data: arrSrc[indexPath.row])
        return cell
    }
    
    
}
extension CollectionViewDatasourceDelegate: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let a = colView.frame.width/2-23
        return CGSize(width: a, height:a+20)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 15)
    }
}


