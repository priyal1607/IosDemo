//
//  BusinessCardActionSheetTableViewCell.swift
//  SharkID
//
//  Created by Jainesh Lad on 10/11/17.
//  Copyright © 2017 sttl. All rights reserved.
//

import UIKit

class ActionSheetTableViewCell: UITableViewCell {

    //MARK:- Interface Builder Connections
    //UIImageView Outlets
    @IBOutlet weak var imgAlertAction: UIImageView!
    
    //UILabel Outlets
    @IBOutlet weak var lblAlertAction: UILabel!
    
    //MARK:- Awake From Nib
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
