//
//  MusicTblCell.swift
//  loginDemo
//
//  Created by Priyal on 17/08/23.
//

import UIKit

class MusicTblCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var btnCancel: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        btnCancel.setCustomCornerRadius(radius: btnCancel.frame.width/2)
        mainView.setCustomCornerRadius(radius: 10)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnCancelAction(_ sender: UIButton) {
    }
}
