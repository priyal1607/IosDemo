//
//  CollViewDatasourcedelegate.swift
//  loginDemo
//
//  Created by Chelsi on 28/04/23.
//
import UIKit

class DetailsCollViewDatasourcedelegate : NSObject {
    typealias collview = UICollectionView
    typealias arr = DetailsDoc
    typealias delegate = ColViewDelegate
    
    
    var arrSrc:[arr]
    var colView : collview
    var del : delegate
    
    
    init(arrSrc:[arr] , colView:collview , del : delegate){
        self.arrSrc = arrSrc
        self.colView = colView
        self.del = del
        super.init()
        setupView()
        
    }
    fileprivate func setupView(){
        colView.delegate = self
        colView.dataSource = self
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        colView.register(nib, forCellWithReuseIdentifier: "CollectionViewCell")
    }
    
}
extension DetailsCollViewDatasourcedelegate:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.del.didSelect?(colView: collectionView, indexPath: indexPath)
        
    }
    
}
extension DetailsCollViewDatasourcedelegate : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrSrc.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colView.dequeueReusableCell(withReuseIdentifier:"CollectionViewCell" , for: indexPath) as! CollectionViewCell
        cell.configureCell1(data: arrSrc[indexPath.row])
        return cell
    }
}
extension DetailsCollViewDatasourcedelegate: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let a = colView.frame.width/2-40
        return CGSize(width: a, height:a-2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    

}
