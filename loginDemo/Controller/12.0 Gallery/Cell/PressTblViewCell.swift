//
//  PressTblViewCell.swift
//  loginDemo
//
//  Created by Priyal on 03/07/23.
//

import UIKit

class PressTblViewCell: UITableViewCell {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        shadowView.addShadow()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configurePressReleaseCell(data : PressReleaseResult,imgUrl:String){
        lbl.text = data.title
        img.downloadImageWithoutProgress(with: imgUrl+(data.image ?? ""),placeholderImage: UIImage(named: "common_placeholder"))
    }
}
