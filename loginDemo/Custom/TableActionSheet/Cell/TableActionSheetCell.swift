//
//  TableActionSheetCell.swift
//  MEAIndia
//
//  Created by Gunjan on 27/07/22.
//

import UIKit

class TableActionSheetCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblTitle.textColor = .customBlack
        lblTitle.font = .regularSystemFont(withSize: .value)
    }
    
}
