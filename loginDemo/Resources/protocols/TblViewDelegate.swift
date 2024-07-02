//
//  TblViewDelegate.swift
//  loginDemo
//
//  Created by Chelsi on 21/04/23.
//

import UIKit

@objc protocol TblViewDelegate : class {
    @objc optional func didSelect(tbl: UITableView, indexPath: IndexPath)
    @objc optional func willDisplay(tbl: UITableView, atIndexPath: IndexPath)
    @objc optional func tbldidScroll(scrollView:UIScrollView)
    @objc optional func tblViewDidEndDecelerating(scrollView:UIScrollView)
}
