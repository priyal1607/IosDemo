//
//  OptionsTblViewCell.swift
//  loginDemo
//
//  Created by Priyal on 26/09/23.
//

import UIKit

class OptionsTblViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var upView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var imgSelect: UIImageView!
    var selArray : [Any] = UserDefaults.standard.array(forKey: "selArray") ?? []
    //var issel : Bool = true
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainView.setCustomCornerRadius(radius: 10)
        upView.setCustomCornerRadius(radius: 10)
        upView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
        mainView.addShadow()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
        func configCell(data : dashboardList){
        
        mainView.backgroundColor = UIColor(hexStringToUIColor: data.color ?? "", alpha: 1.0)
        lblTitle.text = data.lbl

  }
}
