//
//  ColViewDelegate.swift
//  Vidyanjali
//
//  Created by Vikram Jagad on 22/11/20.
//  Copyright © 2020 Vikram Jagad. All rights reserved.
//

import UIKit

@objc protocol ColViewDelegate: NSObjectProtocol {
//    new
   // func didSelect(colView: UICollectionView, indexPath: IndexPath, type: DashboardColViewType)
    @objc optional func didSelect(colView: UICollectionView, indexPath: IndexPath)
    @objc optional func willDisplay(colView: UICollectionView, cell: UICollectionViewCell, indexPath: IndexPath)
    @objc optional func changeCurrentPage(index: Double)
    @objc optional func shareBtnTapped(index: Int, sender: UIView)
    
}
