//
//  TopStackContainerView.swift
//  MEAIndia
//
//  Created by MacOS on 13/07/22.
//

import UIKit

class TopStackContainerView: UIView {
    
    @IBOutlet weak var btnView : UIButton!
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var sepView : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.lblTitle.font = UIFont.montserratFont(.regular, .title)
        
        self.sepView.backgroundColor = UIColor.rgb(245, 46, 37)
        self.sepView.setCustomCornerRadius(radius: 4)
    }
    
    func isSelected(isSelected: Bool) {
        self.lblTitle.font = isSelected ? .montserratFont(.bold, .title) : .montserratFont(.regular, .title)
        
        self.sepView.isHidden = !isSelected
    }
    
    static func viewHeightSizeReturn() -> CGFloat {
        return UIFont.montserratFont(.bold, .title).pointSize + 14
    }
}
