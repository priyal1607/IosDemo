//
//  topCollView.swift
//  loginDemo
//
//  Created by Priyal on 26/09/23.
//

import UIKit

class topCollView: UICollectionViewCell {

    @IBOutlet weak var lbldate: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var bImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configcell(data : ListModel){
        let url = URL(string: data.newsImagePath!)
        img?.sd_setImage(with: url)
        bImg.sd_setImage(with: url)
        lblTitle.text = data.newsHeadline
        lbldate.text = data.newsDate
    }
    @IBAction func btnShareAction(_ sender: UIButton) {
        let activityViewController = UIActivityViewController(activityItems: [lblTitle.text!], applicationActivities: nil)
        UIApplication.shared.keyWindow?.rootViewController?.present(activityViewController, animated: true, completion: nil)
    }
}
