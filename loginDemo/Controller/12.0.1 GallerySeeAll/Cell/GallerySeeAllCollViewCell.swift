//
//  GallerySeeAllCollViewCell.swift
//  loginDemo
//
//  Created by Priyal on 29/06/23.
//

import UIKit

class GallerySeeAllCollViewCell: UICollectionViewCell {

    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureGalleryDetailsCell(data:GalleryDetailsModel,imgUrl:String) {
        self.img.downloadImageWithoutProgress(with: imgUrl+(data.image ),placeholderImage: UIImage(named: "common_placeholder"))
        
    }

}
