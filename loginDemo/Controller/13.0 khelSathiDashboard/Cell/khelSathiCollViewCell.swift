//
//  khelSathiCollViewCell.swift
//  loginDemo
//
//  Created by Priyal on 04/07/23.
//

import UIKit

class khelSathiCollViewCell: UICollectionViewCell {

    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureSportsdata(data : String,index : Int){
        lbl.text = data
        img.image = UIImage(named: "Group 2")
        
    }
    func configCalData(data : String,index : Int){
        lbl.text = data
        img.image = UIImage(named: "im_1")
        
    }
    func configFacData(data : String,index : Int){
        lbl.text = data
        img.image = UIImage(named: "hf_1")
    }
    
}
