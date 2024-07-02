//
//  SelBookMarkTblViewCell.swift
//  loginDemo
//
//  Created by Priyal on 19/10/23.
//

import UIKit

class SelBookMarkTblViewCell: UITableViewCell {

    @IBOutlet weak var btnBookmark: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var typeView: UIView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblType: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        typeView.setCustomCornerRadius(radius: 10)
        mainView.setCustomCornerRadius(radius: 10)
        mainView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        bgView.setCustomCornerRadius(radius: 10)
        bgView.addShadow()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    func configCell(data : book_mark_model){
        lblTitle.text = data.title
        lblType.text = data.type
        lblDate.text = data.date
    }
    
    
}
