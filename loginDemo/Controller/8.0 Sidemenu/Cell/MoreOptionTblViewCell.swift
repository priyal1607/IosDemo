//
//  MoreOptionTblViewCell.swift
//  loginDemo
//
//  Created by Chelsi on 12/05/23.
//

import UIKit

class MoreOptionTblViewCell: UITableViewCell {

    @IBOutlet var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(aMenuOptionData : SideMenuModel, indexPath : IndexPath) {
            if (aMenuOptionData.MoreOptions.count > 0) {
                lblName.text = aMenuOptionData.MoreOptions[indexPath.row-1].TitleKey.localizedString
                }
            } 
}
