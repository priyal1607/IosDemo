//
//  dashboardtableviewcellTableViewCell.swift
//  loginDemo
//
//  Created by Chelsi on 18/04/23.
//

import UIKit

class DashboardTblViewCell: UITableViewCell {

    @IBOutlet var imgView: UIImageView!
    @IBOutlet weak var se: UIView!
    @IBOutlet weak var lblDept: UILabel!
    @IBOutlet weak var lblchar: UILabel!
    @IBOutlet weak var charview: UIView!
    @IBOutlet weak var charView: UIView!
    @IBOutlet weak var lblDob: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var seperator: UIView!
    @IBOutlet weak var lbldob: UILabel!
    @IBOutlet weak var lblname: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.asyncAfter(deadline:.now()+0.1)  {
            self.charView.setCustomCornerRadius(radius: self.charView.frame.height/2 , borderColor: .systemPink, borderWidth: 2)
        }
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    func configureCell(data:DashboardModel){
        lblName.text = data.name
        let c:String = lblName.text!
        let prefix = c.index(c.startIndex, offsetBy: 1)
        let i = c[..<prefix]
//        lblchar.text = String(i)
        lblDob.text = data.dob
        lblDept.text = data.dept
        imgView.image = UIImage(named: data.image)

        
    }
}
