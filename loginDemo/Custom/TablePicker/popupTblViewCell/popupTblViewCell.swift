//
//  popupTblViewCell.swift
//  popuptableview
//
//  Created by Gunjan Patel on 30/08/19.
//  Copyright © 2019 Gunjan Patel. All rights reserved.
//

import UIKit

class popupTblViewCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var imgSelection: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        changeHeightForiPad(view: imgSelection, constant: 10)
    }
}
