//
//  cellSetting.swift
//  MEAIndia
//
//  Created by Pratik on 22/07/22.
//

import UIKit

class cellSetting: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var vwShadown: UIView!
    @IBOutlet weak var vwbg: UIView!
    @IBOutlet weak var imgvMenu: UIImageView!
    @IBOutlet weak var imgvArrow: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        setuplbl()
        setupimg()
        setupvw()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if isDarkModeAppearance {
            vwShadown.addShadow(shadowColor: .clear)
            vwShadown.setCustomCornerRadius(radius: 12)
        } else {
            vwShadown.setCustomCornerRadius(radius: 12)
            vwShadown.addShadow()
        }
    }
    
    //MARK: Private methods
    private func setupvw() {
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        vwbg.backgroundColor = .darkMode_cellWhiteBackground
        vwShadown.backgroundColor = .darkMode_cellWhiteBackground
        vwbg.setCustomCornerRadius(radius: 12)
        
        if isDarkModeAppearance {
            vwShadown.addShadow(shadowColor: .clear)
            vwShadown.setCustomCornerRadius(radius: 12)
        } else {
            vwShadown.setCustomCornerRadius(radius: 12)
            vwShadown.addShadow()
        }
        
    }
    
    private func setuplbl() {
        lblTitle.textColor = .customBlack
        lblTitle.font = .boldSystemFont(withSize: .value)
        
        lblDescription.textColor = .customShadow
        lblDescription.font = .regularSystemFont(withSize: .title)
    }
    
    private func setupimg() {
        changeHeightForiPad(view: imgvArrow,constant: 10)
        changeHeightForiPad(view: imgvMenu, constant: 10)
        
        imgvArrow.image = .ic_rightArrow
        imgvArrow.tintColor = .customBlack
        
    }
    
    //MARK: Public method
    func configureCell(strTitle: String, strImg: String, desc: String) {
        imgvMenu.image = UIImage(named: strImg)?.withRenderingMode(.alwaysTemplate)
        imgvMenu.tintColor = .darkMode_labelCeruleanBlueColor
        
        lblTitle.text = strTitle.localizedString
        lblDescription.text = desc
        lblDescription.isHidden = desc.isEmptyString
        
        if strTitle == "Change Language" {
            imgvArrow.image = .ic_down_arrow
        }
    }
}
