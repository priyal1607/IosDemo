//
//  PopularVideoCollViewCell.swift
//  loginDemo
//
//  Created by Priyal on 14/09/23.
//

import UIKit

class PopularVideoCollViewCell: UICollectionViewCell {
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.setCustomCornerRadius(radius: 10)
        // Initialization code
    }
    func configureCell(data : MandirItemModel){
        lbl.text = data.videos_title
        img.image = UIImage(named: data.videos_thumbnail)
    }

}
