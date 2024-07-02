//
//  HeaderViewController.swift
//  PSIS
//
//  Created by Vikram Jagad on 02/05/19.
//  Copyright © 2019 Vikram Jagad. All rights reserved.
//

import UIKit
import SideMenu

class HeaderViewController: UIViewController {
    
    //MARK:- Variables
    //Public
    var viewHeader: HeaderView = HeaderView.loadNib()
    var btnBack: UIButton! { return viewHeader.btnBack }
    
    var sideMenuViewObj : UIViewController? {
        return SideMenuManager.default.leftMenuNavigationController
    }
    
    //MARK:- View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    
    
    //MARK:- Private Methods
    //View Set Up
    fileprivate func setUpView() {
        setUpHeader()
        setUpBtns()
        setUpLbls()
        setUpTxtField()
        setupImgLocation()
        setHeaderView_BackImage()
    }
    
    //Navigation titleView Set Up
    fileprivate func setUpHeader() {
        self.viewHeader.viewHeaderBg.backgroundColor = .clear
        
        let height = self.navigationController?.navigationBar.frame.size.height ?? 44
        self.viewHeader.clipsToBounds = false
        self.viewHeader.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: height)
        navigationController?.edgesForExtendedLayout = .all
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.titleView = self.viewHeader
        
        self.viewHeader.constTopStatus.constant = -STATUS_BAR_HEIGHT
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        navigationController?.navigationBar.backIndicatorImage = UIImage()
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage()
        
//        self.navigationController?.navigationBar.layer.masksToBounds = false
//        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
//        self.navigationController?.navigationBar.layer.shadowOpacity = 0.3
//        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 3.0)
//        self.navigationController?.navigationBar.layer.shadowRadius = 10
        
        hideSearch()
        hideNotification()
        hideNotificationCount()
        hideDownload()
        hideShare()
        hideBookMark()
        hideAddNotes()
        hideLocation()
        hideFindLocation()
    }
    
    //Buttons Set Up
    fileprivate func setUpBtns() {
        self.viewHeader.btnBack.setImage(.ic_header_menu, for: .normal)
        self.viewHeader.btnBack.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        self.viewHeader.btnBack.tintColor = .darkMode_headerViewImageTintColor
        self.viewHeader.btnBack.addTarget(self, action: #selector(btnBackTapped(_:)), for: .touchUpInside)
        
        self.viewHeader.btnNotification.setImage(.ic_header_notification, for: .normal)
        self.viewHeader.btnNotification.tintColor = .darkMode_headerViewImageTintColor
        self.viewHeader.btnNotification.addTarget(self, action: #selector(btnNotificationTapped(_:)), for: .touchUpInside)
        
        self.viewHeader.btnSearch.setImage(.ic_header_search, for: .normal)
        self.viewHeader.btnSearch.tintColor = .darkMode_headerViewImageTintColor
        self.viewHeader.btnSearch.isSelected = true
        self.viewHeader.btnSearch.addTarget(self, action: #selector(btnSearchTapped(_:)), for: .touchUpInside)
        
        self.viewHeader.btnFilter.setImage(UIImage.ic_header_filter?.alwaysTemplate, for: .normal)
        self.viewHeader.btnFilter.tintColor = .darkMode_headerViewImageTintColor
        self.viewHeader.btnFilter.addTarget(self, action: #selector(btnFilterTapped(_:)), for: .touchUpInside)
        
        self.viewHeader.btnDownload.setImage(.ic_header_download, for: .normal)
        self.viewHeader.btnDownload.tintColor = .darkMode_headerViewImageTintColor
        self.viewHeader.btnDownload.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.viewHeader.btnDownload.addTarget(self, action: #selector(btnDownloadTapped(_:)), for: .touchUpInside)
        
        self.viewHeader.btnLocation.setImage(.ic_Logout.alwaysTemplate, for: .normal)
        self.viewHeader.btnLocation.tintColor = .white
        self.viewHeader.btnLocation.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.viewHeader.btnLocation.addTarget(self, action: #selector(btnLocationTapped), for: .touchUpInside)
        
        
        self.viewHeader.imgShare.image = .ico_share
        self.viewHeader.btnShare.setImage(nil, for: .normal)
        self.viewHeader.imgShare.tintColor = .darkMode_headerViewImageTintColor
        self.viewHeader.btnShare.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.viewHeader.btnShare.addTarget(self, action: #selector(btnShareTapped), for: .touchUpInside)
        
        self.viewHeader.imgBookMark.image = UIImage.ico_bookmark.alwaysTemplate
        self.viewHeader.btnBookMark.setImage(nil, for: .normal)
        self.viewHeader.btnBookMark.setImage(nil, for: .selected)
        self.viewHeader.imgBookMark.tintColor = .darkMode_headerViewImageTintColor
        self.viewHeader.btnBookMark.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.viewHeader.btnBookMark.addTarget(self, action: #selector(btnBookMarkTapped), for: .touchUpInside)
        self.viewHeader.btnBookMark.isSelected = false
        
        self.viewHeader.btnAddNotes.setImage(.ic_plus, for: .normal)
        self.viewHeader.btnAddNotes.tintColor = .darkMode_headerViewImageTintColor
        self.viewHeader.btnAddNotes.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.viewHeader.btnAddNotes.addTarget(self, action: #selector(btnAddNotesTapped(_:)), for: .touchUpInside)
        
        self.viewHeader.btnFind.addTarget(self, action: #selector(btnFindLocationTapped(_:)), for: .touchUpInside)
    }
    
    //Labels Set Up
    fileprivate func setUpLbls() {
        self.viewHeader.lblHeaderTitle.textColor = .darkMode_headerViewImageTintColor
        self.viewHeader.lblHeaderTitle.font = .poppinsFont(.extraBold, .value)
        
        self.viewHeader.lblNotificationCount.font = .poppinsFont(.regular, .smallest)
        self.viewHeader.lblNotificationCount.textColor = .customWhite
        self.viewHeader.lblNotificationCount.text = ""
        self.viewHeader.lblNotificationCount.setCustomCornerRadius(radius: self.viewHeader.lblNotificationCount.frame.height/2)
        self.viewHeader.lblNotificationCount.backgroundColor = .customRed
        
        self.viewHeader.lblFind.text = "Find"
        self.viewHeader.lblFind.textColor = .darkMode_headerViewImageTintColor
        self.viewHeader.lblFind.font = .poppinsFont(.bold, .medium)
    }
    
    //TextField Set Up
    fileprivate func setUpTxtField() {
        self.viewHeader.tfSearch.isHidden = true
        self.viewHeader.tfSearch.font = .poppinsFont(.regular, .medium)
        self.viewHeader.tfSearch.attributedPlaceholder = NSAttributedString(string: "Search" + "...", attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkMode_placeHolderColor])
        self.viewHeader.tfSearch.textColor = .darkMode_headerViewImageTintColor
        self.viewHeader.tfSearch.returnKeyType = .search
        self.viewHeader.tfSearch.delegate = self
    }
    
    //Title Set Up
    func setUpHeaderTitle(strHeaderTitle: String) {
        self.viewHeader.lblHeaderTitle.numberOfLines = 2
        self.viewHeader.lblHeaderTitle.text = strHeaderTitle.uppercased()
        self.viewHeader.lblHeaderTitle.adjustsFontSizeToFitWidth = true
    }
    
    //MARK:- Public Methods
    func setHeaderView_MenuImage() {
        self.viewHeader.btnBack.tintColor = .white
        self.viewHeader.btnBack.setImage(.ic_header_menu, for: .normal)
        self.viewHeader.btnBack.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }

    func setHeaderView_BackImage() {
        let backImg = UIImage.ic_header_back!.alwaysTemplate
        self.viewHeader.btnBack.setImage(backImg, for: .normal)
        self.viewHeader.btnBack.tintColor = .white
        //let padding = (backImg.size.height / backImg.size.width) * 10
        self.viewHeader.btnBack.imageEdgeInsets = UIEdgeInsets(top: 15, left: 12, bottom: 15, right: 12)
        
    }
    
    func setupImgLocation() {
        
        self.viewHeader.imgFindLocation.image = .ic_Logout
        self.viewHeader.imgFindLocation.tintColor = .white
    }
    
    func hideNotificationCount() {
        self.viewHeader.lblNotificationCount.isHidden = true
    }
    
    func hideNotification() {
        if let viewBtnNotification = self.viewHeader.btnNotification.superview {
            viewBtnNotification.isHidden = true
        }
    }
    
    func hideBack() {
        self.viewHeader.constBtnBackWidth.constant = 0
        self.viewHeader.btnBack.isHidden = true
    }
    
    func hideSearch() {
        if let viewBtnSearch = self.viewHeader.btnSearch.superview {
            viewBtnSearch.isHidden = true
        }
    }
    
    func hideFilter() {
        if let viewBtnFilter = self.viewHeader.btnFilter.superview {
            viewBtnFilter.isHidden = true
        }
    }
    
    func hideDownload() {
        if let viewBtnSearch = self.viewHeader.btnDownload.superview {
            viewBtnSearch.isHidden = true
        }
    }
    
    func hideShare() {
        if let viewBtnShowMore = self.viewHeader.btnShare.superview {
            self.viewHeader.imgShare.image = .ico_share
            self.viewHeader.imgShare.tintColor = .white
            viewBtnShowMore.isHidden = false
        }
    }
    
    func hideBookMark() {
        if let viewBtnShowMore = self.viewHeader.btnBookMark.superview {
            viewBtnShowMore.isHidden = true
        }
    }
    
    func hideAddNotes() {
        if let viewBtnAddNotes = self.viewHeader.btnAddNotes.superview {
            viewBtnAddNotes.isHidden = true
        }
    }
    
    func hideLocation() {
        if let viewBtnLocation = self.viewHeader.btnLocation.superview {
            viewBtnLocation.isHidden = true
            self.viewHeader.btnBack.setImage(.ic_loc, for: .normal)
        }
    }
    
    func showLocation() {
        if let viewBtnLocation = self.viewHeader.btnLocation.superview {
            viewBtnLocation.isHidden = false
        }
    }
    
    func hideFindLocation() {
        if let viewBtnFindLocation = self.viewHeader.btnFind.superview {
        viewBtnFindLocation.isHidden = true
        }
    }
    
    func showNotification() {
        if let viewBtnNotification = self.viewHeader.btnNotification.superview {
            viewBtnNotification.isHidden = true
            self.viewHeader.btnNotification.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
    }
    
    func showBack() {
        self.viewHeader.constBtnBackWidth.constant = 44
        self.viewHeader.btnBack.isHidden = false
    }
    
    func showSearch() {
        if let viewBtnSearch = self.viewHeader.btnSearch.superview {
            viewBtnSearch.isHidden = false
        }
    }
    
    func showFilter() {
        if let viewBtnFilter = self.viewHeader.btnFilter.superview {
            viewBtnFilter.isHidden = false
        }
    }
    
    func showDownload() {
        if let viewBtnFilter = self.viewHeader.btnDownload.superview {
            viewBtnFilter.isHidden = false
        }
    }
    
    func showShare() {
        if let viewBtnDelete = self.viewHeader.btnShare.superview {
            viewBtnDelete.isHidden = false
        }
    }
    
    func showBookMark() {
        if let viewBtnShowMore = self.viewHeader.btnBookMark.superview {
            viewBtnShowMore.isHidden = false
        }
    }
    
    func showaddNotes() {
        if let viewBtnAddNotes = self.viewHeader.btnAddNotes.superview {
            viewBtnAddNotes.isHidden = false
            self.viewHeader.btnAddNotes.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
    }
    
    func showFindLocation() {
        if let viewBtnFindLocation = self.viewHeader.btnFind.superview {
            viewBtnFindLocation.isHidden = false
        }
    }
    
    @discardableResult func showSideMenu() -> UIViewController? {
        UIView.hideKeyBoard()
        if let menuLeftNavigationController = SideMenuManager.default.leftMenuNavigationController {
            if menuLeftNavigationController.presentingViewController != nil {
                menuLeftNavigationController.dismiss(animated: false) {
                    (self.bottomBarViewController ?? self).present(menuLeftNavigationController, animated: true, completion: nil)
                }
            } else {
                (self.bottomBarViewController ?? self).present(menuLeftNavigationController, animated: true, completion: nil)
            }
            return menuLeftNavigationController
        }
        return nil
    }
    
    //MARK:- Selector Methods
    @objc func btnBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnNotificationTapped(_ sender: UIButton) {
        debugPrint(#function)
    }
    
    @objc func btnViewGuidelinesTapped(_ sender: UIButton) {
        debugPrint(#function)
    }
    
    @objc func btnFilterTapped(_ sender: UIButton) {
        debugPrint(#function)
    }
    
    @objc func btnDownloadTapped(_ sender: UIButton) {
        if sender.isSelected {
            sender.setImage(.ic_header_close, for: .normal)
            //sender.imageEdgeInsets = UIEdgeInsets(top: 16, left: 24, bottom: 16, right: 8)
            sender.imageEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            self.viewHeader.tfSearch.becomeFirstResponder()
        } else {
            sender.setImage(.ic_header_search, for: .normal)
            sender.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            self.viewHeader.tfSearch.resignFirstResponder()
            self.viewHeader.tfSearch.text = ""
            didSearch(text: "")
        }
        self.viewHeader.lblHeaderTitle.isHidden = sender.isSelected
        self.viewHeader.tfSearch.superview?.isHidden = !sender.isSelected
        sender.isSelected = !sender.isSelected
    }
    
    @objc func btnLocationTapped(_ sender: UIButton) {
        debugPrint(#function)
    }
    
    @objc func btnSearchTapped(_ sender: UIButton) {
        if sender.isSelected {
            sender.setImage(.ic_header_close, for: .normal)
            //sender.imageEdgeInsets = UIEdgeInsets(top: 16, left: 24, bottom: 16, right: 8)
            sender.imageEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            self.viewHeader.tfSearch.becomeFirstResponder()
            self.btnBack.isHidden = true
            self.viewHeader.btnNotification.superview?.isHidden = true
        } else {
            sender.setImage(.ic_header_search, for: .normal)
            sender.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            self.viewHeader.tfSearch.resignFirstResponder()
            self.viewHeader.tfSearch.text = ""
            didSearch(text: "")
            self.btnBack.isHidden = false
            self.viewHeader.btnNotification.superview?.isHidden = false
        }
        self.viewHeader.lblHeaderTitle.isHidden = sender.isSelected
        self.viewHeader.tfSearch.isHidden = !sender.isSelected
        sender.isSelected = !sender.isSelected
    }
    
    @objc func btnShareTapped(_ sender: UIButton) {
        debugPrint(#function)
    }
    
    @objc func btnBookMarkTapped(_ sender: UIButton) {
        debugPrint(#function)
    }
    
    @objc func btnAddNotesTapped(_ sender: UIButton) {
        debugPrint(#function)
    }
    
    @objc func btnFindLocationTapped(_ sender: UIButton) {
        debugPrint(#function)
    }
}

//MARK:- UITextFieldDelegate
extension HeaderViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.viewHeader.tfSearch {
            textField.resignFirstResponder()
            didSearch(text: textField.text ?? "")
        }
        return true
    }
    
    @objc func didSearch(text: String) {
        debugPrint(text)
    }
}
