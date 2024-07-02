//
//  SidemenuTblViewCell.swift
//  loginDemo
//
//  Created by Chelsi on 10/05/23.
//

import UIKit

class SidemenuTblViewCell: UITableViewCell {
    
    @IBOutlet var moreOptionBtn: UIImageView!
    
    @IBOutlet var viewImage: UIImageView!
    
    @IBOutlet var lblName: UILabel!
    
    @IBOutlet var sepView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configcell(data : SideMenuModel){
        lblName.text = data.TitleKey.localizedString
        imageView?.image = UIImage(named: data.Image)
        if data.MoreOptions.count > 0 {
            moreOptionBtn.isHidden = false
        }
        else{
            moreOptionBtn.isHidden = true
        }

    }
    
    
  
    
}
