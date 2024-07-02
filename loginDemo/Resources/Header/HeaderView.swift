//
//  HeaderView.swift
//  PSIS
//
//  Created by Vikram Jagad on 02/05/19.
//  Copyright © 2019 Vikram Jagad. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    //MARK:- Interface Builder
    //UIView
    @IBOutlet weak var viewHeaderBg: UIView!
    
    //UIButton
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnNotification: UIButton!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var btnDownload: UIButton!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var btnBookMark: UIButton!
    @IBOutlet weak var btnAddNotes: UIButton!
    @IBOutlet weak var btnLocation: UIButton!
    @IBOutlet weak var btnFind: UIButton!
    
    @IBOutlet weak var lblFind: UILabel!

    @IBOutlet weak var imgShare: UIImageView!
    @IBOutlet weak var imgBookMark: UIImageView!
    @IBOutlet weak var imgFindLocation: UIImageView!
    
    //UILabel
    @IBOutlet weak var lblHeaderTitle: UILabel!
    @IBOutlet weak var lblNotificationCount: UILabel!
    
    //NSLayoutConstraint
    @IBOutlet weak var constTopStatus: NSLayoutConstraint!
    @IBOutlet weak var constBtnBackWidth: NSLayoutConstraint!
    
    //UITextField
    @IBOutlet weak var tfSearch: UITextField!
    
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
}
