//
//  IMATblViewCell.swift
//  loginDemo
//
//  Created by Priyal on 29/09/23.
//

import UIKit

class IMATblViewCell: UITableViewCell {

    @IBOutlet weak var imgCircle: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var imgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.imgView.setCustomCornerRadius(radius: self.imgView.frame.width/2)
            self.imgView.backgroundColor = UIColor(hexStringToUIColor: "9EF3E4")
        }
        //mainView.setCustomCornerRadius(radius: 10)
        //mainView.addShadow()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(){
        
    }
}
