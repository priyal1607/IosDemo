//
//  NewsCollVC.swift
//  loginDemo
//
//  Created by Chelsi on 26/05/23.
//

import UIKit
import SDWebImage

class NewsCollVC: UICollectionViewCell {
    
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func btnShareAction(_ sender: Any) {
        let activityViewController = UIActivityViewController(activityItems: [lblTitle.text!], applicationActivities: nil)
        UIApplication.shared.keyWindow?.rootViewController?.present(activityViewController, animated: true, completion: nil)
    }
    func configcell(data : NewsModel){
        let url = URL(string: data.image!)
        imgView?.sd_setImage(with: url)
        lblTitle.text = data.title
        lblDate.text = data.time2
    }
}
