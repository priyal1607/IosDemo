//
//  MapPinView.swift
//  MEAIndia
//
//  Created by MacOS on 20/07/22.
//

import UIKit

class MapPinView: UIView {
    
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var imgTelephone: UIImageView!
    @IBOutlet weak var imgArrow: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       // self.lblTitle.font = .proximaExtraBold(withSize: 18)
        self.lblTitle.textColor = .customBlack
        
       // self.lblAddress.font = .ProximaNovaSemibold(withSize: 16)
        self.lblAddress.textColor = .darkMode_labelMineShaftBlackColor
        
        //lblNumber.font = .ProximaNovaSemibold(withSize: 16)
        lblNumber.textColor = .darkMode_labelMineShaftBlackColor
        
        
        
        imgTelephone.image = UIImage(named: "ic_telephone_icon")
        imgTelephone.tintColor = .darkMode_labelMineShaftBlackColor
        
        coverView.setCustomCornerRadius(radius: 10)
        coverView.backgroundColor = .clear
        coverView.subviews.first?.backgroundColor = .darkMode_cellWhiteBackground
        
        if isDarkModeAppearance {
            imgArrow.image = UIImage(named: "bottom_arrow")?.alwaysTemplate
            coverView.subviews.first?.addShadow(shadowColor: .clear, shadowOpacity: 0, shadowRadius: 0, shadowOffset: .zero)
        } else {
            imgArrow.image = UIImage(named: "bottom_arrow")
            coverView.subviews.first?.addShadow(shadowColor: UIColor.black.withAlphaComponent(0.7), shadowOpacity: 0.6, shadowRadius: 10, shadowOffset: .init(width: 0, height: 0))
        }
        imgArrow.tintColor = .darkMode_cellWhiteBackground
        
    }
    
}
