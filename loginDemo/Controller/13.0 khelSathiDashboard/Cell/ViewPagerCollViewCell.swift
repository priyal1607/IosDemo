//
//  ViewPagerCollViewCell.swift
//  loginDemo
//
//  Created by Priyal on 04/07/23.
//

import UIKit

class ViewPagerCollViewCell: UICollectionViewCell {

    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configPager(data : String,index : Int){
        img.image = UIImage(named: "pager_1")
        
    }
    func configCal(data : String,index : Int){
        img.image = UIImage(named: "Group 2")
        
    }
}
