//
//  TrendingArticleCollViewCell.swift
//  loginDemo
//
//  Created by Priyal on 14/09/23.
//

import UIKit

class TrendingArticleCollViewCell: UICollectionViewCell {
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var imgView: UIView!
    @IBOutlet weak var mainView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.setCustomCornerRadius(radius: 20)
        imgView.setCustomCornerRadius(radius: 2)
        // Initialization code
    }
    func configureCell(data : MandirItemModel){
        img.image = UIImage(named: "MantrasChantsImg6")
    }
}
