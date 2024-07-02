//
//  shortsCollViewCell.swift
//  loginDemo
//
//  Created by Priyal on 12/09/23.
//

import UIKit

class shortsCollViewCell: UICollectionViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        img.setCustomCornerRadius(radius: 20)
        // Initialization code
    }
    func configureCell(data : MandirItemModel){
        lbl.text = data.videos_description
        img.image = UIImage(named: data.videos_thumbnail)
    }

}
