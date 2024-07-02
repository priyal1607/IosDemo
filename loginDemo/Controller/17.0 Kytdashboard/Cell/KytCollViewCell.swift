//
//  KytCollViewCell.swift
//  loginDemo
//
//  Created by Priyal on 11/09/23.
//

import UIKit

class KytCollViewCell: UICollectionViewCell {
    @IBOutlet weak var lbl: UILabel!
 
    @IBOutlet weak var sep: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell(data : String , index : Int){
        lbl.text = data
        sep.isHidden = true
    }
}
extension KytCollViewCell : ColViewDelegate {
    
}
