//
//  OnBoardingCollView.swift
//  loginDemo
//
//  Created by Priyal on 01/09/23.
//

import UIKit

class OnBoardingCollView: UICollectionViewCell {

    @IBOutlet weak var aspectRatio: NSLayoutConstraint!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl1: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configCell(data : String , index : Int){
        lbl1.text = data
        lbl2.text = "Corporate Social Responsibility (CS) can generate a positive reputation for a company leading to possibly more sales and growth."
      //  print("Onboard" + getString(anything:index))
        if index == 0 {
            aspectRatio = MyConstraint.changeMultiplier(aspectRatio, multiplier: 1.87)
        }
        if index == 1 {
            aspectRatio = MyConstraint.changeMultiplier(aspectRatio, multiplier: 1)
        }
        if index == 2 {
            aspectRatio = MyConstraint.changeMultiplier(aspectRatio, multiplier: 0.87)
        }
        img.image = UIImage(named: "Onboard" + getString(anything:index + 1))
    }
}
