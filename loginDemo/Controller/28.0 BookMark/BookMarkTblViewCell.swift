//
//  BookMarkTblViewCell.swift
//  loginDemo
//
//  Created by Priyal on 17/10/23.
//

import UIKit

class BookMarkTblViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var btnBookMark: UIButton!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblNote: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.setCustomCornerRadius(radius: 10)
        mainView.setCustomCornerRadius(radius: 10)
        bgView.addShadow()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configCell(data : book_mark_model){
        lblDate.text = data.date
        lblNote.text = data.title
        
        
    }
    
}
