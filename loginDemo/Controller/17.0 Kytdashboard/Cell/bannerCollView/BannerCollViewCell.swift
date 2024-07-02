//
//  BannerCollViewCell.swift
//  loginDemo
//
//  Created by Priyal on 11/09/23.
//

import UIKit

class BannerCollViewCell: UICollectionViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.setCustomCornerRadius(radius: 20)
        // Initialization code
    }
    
    func configureCell(data : MandirItemModel){
        lbl.text = data.videos_title
        img.image = UIImage(named: data.videos_thumbnail)
    }
   
}
