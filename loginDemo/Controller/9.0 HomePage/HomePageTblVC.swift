//
//  HomePageTblVC.swift
//  loginDemo
//
//  Created by Chelsi on 24/05/23.
//

import UIKit

class HomePageTblVC: UITableViewCell {
    @IBOutlet var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configcell(data : String){
        lblName.text = data.localizedString

    }
}
