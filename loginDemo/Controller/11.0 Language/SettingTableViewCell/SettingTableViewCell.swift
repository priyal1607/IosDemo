//
//  SettingTableViewCell.swift
//  LSAttendance
//
//  Created by Vikram Jagad on 30/06/20.
//  Copyright © 2020 Hitesh. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    //MARK: Outlets
    //UIView
    @IBOutlet var viewMain : UIView!
    @IBOutlet var viewShadow : UIView!
    @IBOutlet var viewSeperator : UIView!
    
    //UILabel
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var lblChangeLanguage: UILabel!
    //UIImageView
    @IBOutlet weak var imgDropDown: UIImageView!
    @IBOutlet weak var imgSelectLang: UIImageView!
    
    //UIButton
    @IBOutlet var btnLanguage : UIButton!
    
    
    //MARK: Override Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        setupView()
        setupLabel()
        setupImg()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if isDarkModeAppearance {
            self.viewShadow.setCustomCornerRadius(radius: 12)
            self.viewShadow.addShadow()
        } else {
            self.viewShadow.addShadow(shadowColor: .clear)
            self.viewShadow.setCustomCornerRadius(radius: 12)
        }
    }
    
    //MARK: Privates Methods
    private func setupView() {
        //BackgroundColor
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        viewMain.backgroundColor = .darkMode_cellWhiteBackground
        viewShadow.backgroundColor = .darkMode_cellWhiteBackground
        self.viewMain.setCustomCornerRadius(radius: 12)
        
        if isDarkModeAppearance {
            self.viewShadow.setCustomCornerRadius(radius: 12)
            self.viewShadow.addShadow()
        } else {
            self.viewShadow.addShadow(shadowColor: .clear)
            self.viewShadow.setCustomCornerRadius(radius: 12)
        }
        
        
        self.viewSeperator.backgroundColor = .customSeparator
    }

    private func setupImg() {
        
        imgDropDown.image  = .ic_rightArrow
        imgDropDown.tintColor = .customBlack
        
        let toRadians = 90 * CGFloat.pi / 180
        imgDropDown.transform = .init(rotationAngle: toRadians)
        
        imgSelectLang.image = .ico_language_globe
        imgSelectLang.tintColor = .darkMode_labelCeruleanBlueColor
    }
    
    private func setupLabel() {
        lblLanguage.textColor = .customBlack
        lblLanguage.font = .semiBoldSystemFont(withSize: .value)
    
    }
    
}
