//
//  DashboardCollViewCell.swift
//  loginDemo
//
//  Created by Priyal on 26/09/23.
//

import UIKit

class DashboardCollViewCell: UICollectionViewCell {
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var imgCircle: UIImageView!
    @IBOutlet weak var imgView: UIView!
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainView.setCustomCornerRadius(radius: 10)
        
        // Initialization code
    }
    func configureCell(data : dashboardList){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.imgView.setCustomCornerRadius(radius: self.imgView.frame.width/2 , borderColor: .black, borderWidth: 1)
        }
        lbl.text = data.lbl
        img.image = UIImage(named: data.img ?? "")
        mainView.backgroundColor = UIColor(hexStringToUIColor: data.color ?? "", alpha: 1.0)
    }
    func configureCellIMA(index : Int){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.imgView.setCustomCornerRadius(radius: self.imgView.frame.width/2)
        }
        if index == 0 {
            lbl.text = "Nearest\nMission/post"
            img.image = UIImage(named: "pressReleases")
        } else {
            lbl.text = "What's New\nIn Mission"
            img.image = UIImage(named: "pressReleases")
        }
        
    }
    
    func configureCellNotes(index : Int){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.imgView.setCustomCornerRadius(radius: self.imgView.frame.width/2)
        }
        if index == 0 {
            lbl.text = "MY MEA Notes"
            img.image = UIImage(named: "paper")
        } else {
            lbl.text = "Customize Dashboard"
            img.image = UIImage(named: "dashboard-MEA")
        }
        
    }
}
