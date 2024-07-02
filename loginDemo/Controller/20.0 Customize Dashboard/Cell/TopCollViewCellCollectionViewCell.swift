//
//  topCollViewCellCollectionViewCell.swift
//  loginDemo
//
//  Created by Priyal on 26/09/23.
//

import UIKit

class TopCollViewCellCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var img: UIImageView!
 //   @IBOutlet weak var bgimg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func btnShareAction(_ sender: UIButton) {
    }
    
    func configcell(data : ListModel){
        let url = URL(string: data.newsImagePath!)
        img?.sd_setImage(with: url)
       // bgimg.sd_setImage(with: url)
        lblTitle.text = data.newsHeadline
        lblDate.text = data.newsDate
    }
}
