//
//  PDFView.swift
//  StartupHaryana
//
//  Created by Vikram Jagad on 26/09/19.
//  Copyright © 2019 Gunjan Patel. All rights reserved.
//

import UIKit

open class SubTitleView: UIView {
    //MARK:- Interface Builder
    //UIView
    @IBOutlet var contentView: UIView!
    
    var arr : [SideMenuModel] = []
    @IBOutlet var lblName: UILabel!
    @IBOutlet var imageView: UIImageView!
    //MARK:- Lifecycle Methods
    override open func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    
    //MARK:- Private Methods
    //set up lbls
    func setUpLbls(data : SideMenuModel) {
        lblName.text = data.TitleKey.localizedString
        imageView.image = UIImage(named: data.Image)
//        title.font = .poppinsFont(.medium, .value)
//        title.textColor = .customBlack
//        title.numberOfLines = 0
    }

}
extension SubTitleView {
    
}
