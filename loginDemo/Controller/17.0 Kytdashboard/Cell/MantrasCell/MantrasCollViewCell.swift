//
//  MantrasCollViewCell.swift
//  loginDemo
//
//  Created by Priyal on 13/09/23.
//

import UIKit

class MantrasCollViewCell: UICollectionViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var mainView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.mainView.setCustomCornerRadius(radius: self.mainView.frame.width/2)
            self.img.setCustomCornerRadius(radius: self.img.frame.width/2)
        }
        // Initialization code
    }
    func configureCell(data : MandirItemModel){
        img.image = UIImage(named: data.videos_thumbnail)
    }

}
