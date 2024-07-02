//
//  BottomStackContainerView.swift
//  MEAIndia
//
//  Created by MacOS on 13/07/22.
//

import UIKit

class BottomStackContainerView: UIView {
    
    @IBOutlet weak var imgView : UIImageView!
    @IBOutlet weak var btnView : UIButton!
    @IBOutlet weak var lblTitle : UILabel!
    
    @IBOutlet weak var anchorImgViewHeightConstraint : NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if UIDevice.deviceModelType.contains(.iPhone_4, .iPhone_5, .iPhone_5c, .iPhone_5s, .iPhone_SE, .iPhone_SE_2nd_generation, .iPhone_SE_3rd_generation, .iPhone_6, .iPhone_6s) {
            self.anchorImgViewHeightConstraint = self.anchorImgViewHeightConstraint.setMultiplier(multiplier: 0.4)
            self.anchorImgViewHeightConstraint.constant = -2
            
            self.lblTitle.font = .systemFont(ofSize: 8)
            
        } else if UIDevice.deviceModelType.contains(.iPhone_7, .iPhone_8, .iPhone_X, .iPhone_XS, .iPhone_11_Pro, .iPhone_12, .iPhone_12_Pro, .iPhone_12_mini, .iPhone_13) {
            
            self.lblTitle.font = .systemFont(ofSize: 9)
            
        } else if UIDevice.deviceModelType.contains(.iPhone_6s_Plus, .iPhone_7_Plus, .iPhone_8_Plus, .iPhone_XS_Max, .iPhone_XR, .iPhone_11, .iPhone_11_Pro_Max, .iPhone_12_Pro_Max, .iPhone_13_Pro) {
          
            self.lblTitle.font = .poppinsFont(.regular, .smallest)
            
        } else {
            
            self.lblTitle.font = .poppinsFont(.regular, .value)
        }
    }
    
    func isSelected(isSelected: Bool) {
        
        self.lblTitle.font = isSelected ? .poppinsFont(.medium, .smallest) : .poppinsFont(.regular, .smallest)
    }
}
