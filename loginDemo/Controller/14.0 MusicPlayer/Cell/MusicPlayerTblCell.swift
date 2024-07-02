//
//  MusicPlayerTblCell.swift
//  loginDemo
//
//  Created by Priyal on 17/08/23.
//

import UIKit

class MusicPlayerTblCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        img.setCustomCornerRadius(radius: 10)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configCell(data : MusicModel){
        lblName.text = "KYT"
        lblTime.text = data.music_duration
        lblTitle.text = data.music_title
    }
    
}
