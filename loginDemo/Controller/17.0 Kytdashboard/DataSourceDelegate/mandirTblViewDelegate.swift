//
//  mandirTblViewDelegate.swift
//  loginDemo
//
//  Created by Priyal on 11/09/23.
//

import Foundation
import UIKit

class mandirTblViewDelegate: NSObject {
    
    internal var arrSource: [HomePageData]
    internal var tblvw: UITableView
    internal weak var delegate: TblViewDelegate?
    var list: [HomePageData] = []
    
    var block_btnTitleImageClicked: ((_ sectionIndex: Int) -> Void)?
    var block_collViewDidSelected: ((_ sectionIndex: Int, _ rowIndex: Int) -> Void)?
    
    //MARK:- Initializers
    required init(arrData: [HomePageData], delegate: TblViewDelegate, tbl: UITableView) {
        
        arrSource = arrData
        tblvw = tbl
        self.delegate = delegate
        super.init()
        setupTbl()
    }
    
    fileprivate func setupTbl() {
        
        tblvw.register(cellType: homePageTblView.self)
//        tblvw.register(cellType: MantraHorizontalTableViewCell.self)
        tblvw.registerClass(cellType: BlankTableViewCell.self)
        
        tblvw.dataSource = self
        tblvw.delegate = self
        tblvw.separatorStyle = .none
        tblvw.reloadData()
    }
    
    func reload(arr: [HomePageData]) {
        tblvw.dataSource = self
        tblvw.delegate = self
        arrSource = arr
        tblvw.reloadData()
        setUpBackgroundView()
    }
    
    private func setUpBackgroundView() {
        if (self.arrSource.count > 0) {
            self.tblvw.backgroundView = nil
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.tblvw.backgroundView = UIView.makeNoRecordFoundViewWithPullToRefresh(frame: self.tblvw.frame, msg: .LanguageLocalisation.no_record_found)
            }
        }
    }
    
    fileprivate func btnTitleImageClicked(sectionIndex: Int) {
        self.block_btnTitleImageClicked?(sectionIndex)
    }
    
    fileprivate func collectionViewDidSelected(sectionIndex: Int, rowIndex: Int) {
        self.block_collViewDidSelected?(sectionIndex, rowIndex)
    }
    
}

extension mandirTblViewDelegate: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect?(tbl: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        delegate?.willDisplay?(tbl: tableView, atIndexPath: indexPath)
    }
    
}

extension mandirTblViewDelegate: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.arrSource[indexPath.section].viewtype == MandirViewTypes.banner.rawValue && arrSource[indexPath.section].list.count > 0 {
            let cell = tableView.dequeueReusableCell(with: homePageTblView.self, for: indexPath)
            cell.cellData(data: arrSource[indexPath.section].list, type: .banner(padding: .init(top: 8, left: 0, bottom: 0, right: 0), minimumLineSpace: 0, minimumInteritemSpace: 0))
            cell.lblTitle.superview?.isHidden = true
            cell.lblDescription.superview?.isHidden = true
       
            
//            cell.imgIcon.isHidden = false
//            cell.btnTitleImage.isHidden = false
//
            cell.collView.isPagingEnabled = true
//            cell.btnTitleImage.tag = indexPath.section
            cell.collView.tag = indexPath.section
            
//            cell.block_btnTitleImageClicked = self.btnTitleImageClicked
//            cell.block_collViewDidSelected = self.collectionViewDidSelected
            
            return cell
            
        } else if self.arrSource[indexPath.section].viewtype == MandirViewTypes.shorts.rawValue,
                  arrSource[indexPath.section].list.count > 0 {
            
            let cell = tableView.dequeueReusableCell(with: homePageTblView.self, for: indexPath)
            cell.cellData(data: arrSource[indexPath.section].list, type: .shorts(padding: .init(top: 10, left: 15, bottom: 10, right: 15), minimumLineSpace: 10, minimumInteritemSpace: 10))
           
            cell.lblTitle.superview?.isHidden = false
            cell.lblTitle.text = self.arrSource[indexPath.section].title
            cell.lblDescription.superview?.isHidden = true
         
            cell.collView.isPagingEnabled = false
            //cell.btnTitleImage.tag = indexPath.section
            cell.collView.tag = indexPath.section
            

//            cell.imgIcon.isHidden = false
//            cell.btnTitleImage.isHidden = false

//            cell.block_btnTitleImageClicked = self.btnTitleImageClicked
//            cell.block_collViewDidSelected = self.collectionViewDidSelected
            
            return cell
            
        } else if self.arrSource[indexPath.section].viewtype == MandirViewTypes.trendingArticles.rawValue,
                  arrSource[indexPath.section].list.count > 0 {
            
            let cell = tableView.dequeueReusableCell(with: homePageTblView.self, for: indexPath)
            cell.cellData(data: arrSource[indexPath.section].list, type: .trendingArticles(padding: .init(top: 10, left: 15, bottom: 10, right: 15), minimumLineSpace: 15, minimumInteritemSpace: 15))
            cell.lblTitle.superview?.isHidden = false
            cell.lblDescription.superview?.isHidden = true
            cell.lblTitle.text = arrSource[indexPath.section].title
            cell.collView.isPagingEnabled = false
//          cell.btnTitleImage.tag = indexPath.section
            cell.collView.tag = indexPath.section

//            cell.imgIcon.isHidden = false
//            cell.btnTitleImage.isHidden = true
//
//            cell.block_btnTitleImageClicked = self.btnTitleImageClicked
//            cell.block_collViewDidSelected = self.collectionViewDidSelected

            return cell
            
        } else if self.arrSource[indexPath.section].viewtype == MandirViewTypes.photos.rawValue,
                  self.arrSource[indexPath.section].list.count > 0 {
            
            let cell = tableView.dequeueReusableCell(with: homePageTblView.self, for: indexPath)
            cell.cellData(data: self.arrSource[indexPath.section].list, type: .photos(padding: .init(top: 10, left: 15, bottom: 10, right: 15), minimumLineSpace: 10, minimumInteritemSpace: 10))
            cell.lblTitle.superview?.isHidden = false
            cell.lblDescription.superview?.isHidden = false
            cell.lblTitle.text = self.arrSource[indexPath.section].title
            cell.lblDescription.text = self.arrSource[indexPath.section].description_desc
            cell.collView.isPagingEnabled = false
            //cell.btnTitleImage.tag = indexPath.section
            cell.collView.tag = indexPath.section

//            cell.imgIcon.isHidden = true
//            cell.btnTitleImage.isHidden = true

//            cell.block_btnTitleImageClicked = self.btnTitleImageClicked
//            cell.block_collViewDidSelected = self.collectionViewDidSelected
            
            return cell
            
        } else if self.arrSource[indexPath.section].viewtype == MandirViewTypes.horizontal.rawValue {
            let cell = tableView.dequeueReusableCell(with: homePageTblView.self, for: indexPath)
//            cell.cellData(data: arrSource[indexPath.section].list, type: .otherCell(padding: .init(top: 3, left: 3, bottom: 3, right: 3), minimumLineSpace: 0, minimumInteritemSpace: 0))
//            cell.lblTitle.superview?.isHidden = false
//            cell.lblDescription.superview?.isHidden = true
//            cell.lblTitle.text = arrSource[indexPath.section].title
//            cell.collView.isPagingEnabled = false
//            cell.btnTitleImage.tag = indexPath.section
//            cell.collView.tag = indexPath.section
//
//            cell.imgIcon.isHidden = false
//            cell.btnTitleImage.isHidden = false
//
//            cell.block_btnTitleImageClicked = self.btnTitleImageClicked
//            cell.block_collViewDidSelected = self.collectionViewDidSelected
//
            return cell
            
        } else if self.arrSource[indexPath.section].viewtype == MandirViewTypes.vertical.rawValue {
            let cell = tableView.dequeueReusableCell(with: homePageTblView.self, for: indexPath)
            cell.cellData(data: arrSource[indexPath.section].list, type: .verticalCell(padding: .init(top: 5, left: 15, bottom: 5, right: 15), minimumLineSpace: 10, minimumInteritemSpace: 10))
            cell.lblTitle.superview?.isHidden = false
            cell.lblDescription.superview?.isHidden = true
            cell.lblTitle.text = arrSource[indexPath.section].title
            cell.collView.isPagingEnabled = false
           // cell.btnTitleImage.tag = indexPath.section
            cell.collView.tag = indexPath.section

//            cell.imgIcon.isHidden = true
//            cell.btnTitleImage.isHidden = true
//
//            cell.block_btnTitleImageClicked = self.btnTitleImageClicked
//            cell.block_collViewDidSelected = self.collectionViewDidSelected
            
            return cell
            
        } else if self.arrSource[indexPath.section].viewtype == MandirViewTypes.mantras.rawValue {
            let cell = tableView.dequeueReusableCell(with: homePageTblView.self, for: indexPath)
            cell.cellData(data: arrSource[indexPath.section].list, type: .mantras(padding: .init(top: 10, left: 15, bottom: 10, right: 15), minimumLineSpace: 10, minimumInteritemSpace: 10))
            cell.lblTitle.superview?.isHidden = false
            cell.lblDescription.superview?.isHidden = true
            cell.lblTitle.text = self.arrSource[indexPath.section].title
            //cell.btnTitleImage.tag = indexPath.section
            cell.collView.tag = indexPath.section
            cell.collView.isPagingEnabled = false
           

//            cell.imgIcon.isHidden = true
//            cell.btnTitleImage.isHidden = true
            
//            cell.block_btnTitleImageClicked = self.btnTitleImageClicked
//            cell.block_collViewDidSelected = self.collectionViewDidSelected
            
            return cell

        }
        else {
            return tableView.dequeueReusableCell(with: BlankTableViewCell.self, for: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.arrSource[indexPath.section].viewtype == MandirViewTypes.banner.rawValue && arrSource[indexPath.section].list.count > 0 {
            return UITableView.automaticDimension
        } else if self.arrSource[indexPath.section].viewtype == MandirViewTypes.shorts.rawValue && arrSource[indexPath.section].list.count > 0 {
            return UITableView.automaticDimension
        } else if self.arrSource[indexPath.section].viewtype == MandirViewTypes.trendingArticles.rawValue && arrSource[indexPath.section].list.count > 0 {
            return UITableView.automaticDimension
        } else if self.arrSource[indexPath.section].viewtype == MandirViewTypes.photos.rawValue && arrSource[indexPath.section].list.count > 0 {
            return UITableView.automaticDimension
        } else if self.arrSource[indexPath.section].viewtype == MandirViewTypes.horizontal.rawValue {
            return UITableView.automaticDimension
        } else if self.arrSource[indexPath.section].viewtype == MandirViewTypes.vertical.rawValue && arrSource[indexPath.section].list.count > 0 {
            return UITableView.automaticDimension
        } else if self.arrSource[indexPath.section].viewtype == MandirViewTypes.mantras.rawValue && arrSource[indexPath.section].list.count > 0 {
            return UITableView.automaticDimension
        }
        return 1
    }
}



class BlankTableViewCell: UITableViewCell {
    
    let newView: UIView = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.newView.backgroundColor = .clear
        
        self.contentView.addSubview(self.newView)
        self.newView.fullFillOnSuperView()
        self.newView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }
    
}
