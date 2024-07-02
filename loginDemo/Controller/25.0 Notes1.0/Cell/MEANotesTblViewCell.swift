//
//  MEANotesTblViewCell.swift
//  loginDemo
//
//  Created by Priyal on 04/10/23.
//

import UIKit

class MEANotesTblViewCell: UITableViewCell {

    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btneditact: UIButton!
    @IBOutlet weak var upView: UIView!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var bgView: UIView!
    var comp: ((Bool) -> ())?
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.setCustomCornerRadius(radius: 10)
        upView.setCustomCornerRadius(radius: 10)
        upView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        bgView.addShadow()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configCell(data : NotesModel){
        lblTitle.text = data.note
        lblTime.text = data.date_time
    }
  
   
}
