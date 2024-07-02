//
//  HomePageCollVC.swift
//  loginDemo
//
//  Created by Chelsi on 24/05/23.
//

import UIKit

class HomePageCollVC: UICollectionViewCell {

    @IBOutlet var cellView: UIView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.asyncAfter(deadline:.now()+0.1)  {
            self.cellView.setCustomCornerRadius(radius: 10 ,borderColor: .systemBlue , borderWidth: 2)
        }
        // Initialization code
    }
    func configcell(data : HomePageModel){
        lblTitle .text = data.TitleKey.localizedString
        imgView?.image = UIImage(named: data.Image)

    }
}
