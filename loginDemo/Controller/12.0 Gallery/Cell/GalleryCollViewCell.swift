//
//  GalleryCollViewCell.swift
//  loginDemo
//
//  Created by Priyal on 29/06/23.
//

import UIKit

class GalleryCollViewCell: UICollectionViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureGalleryCell(data : PressReleaseResult,imgUrl:String){
        lblName.text = data.title
        img.downloadImageWithoutProgress(with: imgUrl+(data.image ?? ""),placeholderImage: UIImage(named: "common_placeholder"))
    }
}
