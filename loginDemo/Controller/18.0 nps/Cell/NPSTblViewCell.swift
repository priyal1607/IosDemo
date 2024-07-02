//
//  NPSTblViewCell.swift
//  loginDemo
//
//  Created by Priyal on 15/09/23.
//

import UIKit

class NPSTblViewCell: UITableViewCell {

    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var secView: UIView!
    @IBOutlet weak var mainView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        mainView.setCustomCornerRadius(radius: 10)
//        mainView.backgroundColor = UIColor(hexStringToUIColor: "#FF0000" , alpha: 1)
//        secView.backgroundColor = UIColor(hexStringToUIColor: "#FFFFFF" , alpha: 0.8)

        // Configure the view for the selected state
    }
    func configureCell(data : NpsScheme , index : Int){
        if index == 0 {
            mainView.backgroundColor = UIColor(hexStringToUIColor: "#33328DDA" , alpha: 1)
            secView.backgroundColor = UIColor(hexStringToUIColor: "#FFFFFF" , alpha: 0.8)
            lbl2.textColor = UIColor(hexStringToUIColor: "#328DDA")
        }
        else if index == 1 {
            mainView.backgroundColor = UIColor(hexStringToUIColor: "#F39639" , alpha: 1)
            secView.backgroundColor = UIColor(hexStringToUIColor: "#FFFFFF" , alpha: 0.8)
            lbl2.textColor = UIColor(hexStringToUIColor: "#F39639")
        }
        else if index == 2 {
            mainView.backgroundColor = UIColor(hexStringToUIColor: "#6AA25C" , alpha: 1)
            secView.backgroundColor = UIColor(hexStringToUIColor: "#FFFFFF" , alpha: 0.8)
            lbl2.textColor = UIColor(hexStringToUIColor: "#6AA25C")
        }
        else if index == 3 {
            mainView.backgroundColor = UIColor(hexStringToUIColor: "#645FA4" , alpha: 1)
            secView.backgroundColor = UIColor(hexStringToUIColor: "#FFFFFF" , alpha: 0.8)
            lbl2.textColor = UIColor(hexStringToUIColor: "#645FA4")
        }
        else if index == 4 {
            mainView.backgroundColor = UIColor(hexStringToUIColor: "#F4525D" , alpha: 1)
            secView.backgroundColor = UIColor(hexStringToUIColor: "#FFFFFF" , alpha: 0.8)
            lbl2.textColor = UIColor(hexStringToUIColor: "#F4525D")
        }
        else if index == 5 {
            mainView.backgroundColor = UIColor(hexStringToUIColor: "#375CB4" , alpha: 1)
            secView.backgroundColor = UIColor(hexStringToUIColor: "#FFFFFF" , alpha: 0.8)
            lbl2.textColor = UIColor(hexStringToUIColor: "#375CB4")
        }
        else if index == 6 {
            mainView.backgroundColor = UIColor(hexStringToUIColor: "#FFCB05" , alpha: 1)
            secView.backgroundColor = UIColor(hexStringToUIColor: "#FFFFFF" , alpha: 0.8)
            lbl2.textColor = UIColor(hexStringToUIColor: "#FFCB05")
        }
        else if index == 7 {
            mainView.backgroundColor = UIColor(hexStringToUIColor: "#F00FF0" , alpha: 1)
            secView.backgroundColor = UIColor(hexStringToUIColor: "#FFFFFF" , alpha: 0.8)
            lbl2.textColor = UIColor(hexStringToUIColor: "#F00FF0")
        }
        else if index == 8 {
            mainView.backgroundColor = UIColor(hexStringToUIColor: "#FFFF00" , alpha: 1)
            secView.backgroundColor = UIColor(hexStringToUIColor: "#FFFFFF" , alpha: 0.8)
            lbl2.textColor = UIColor(hexStringToUIColor: "#FFFF00")
        }
        else if index == 9 {
            mainView.backgroundColor = UIColor(hexStringToUIColor: "#008000" , alpha: 1)
            secView.backgroundColor = UIColor(hexStringToUIColor: "#FFFFFF" , alpha: 0.8)
            lbl2.textColor = UIColor(hexStringToUIColor: "#008000")
        }
        lblTitle.text = data.schemeName
        let formattedNumber = String(format: "%.2f", Double(data.value))
        lbl2.text = "₹" + getString(anything: formattedNumber)
    }
    func configureCellContribution(contribution : Double , totalVal : Double , index : Int ){
        if index == 0 {
            mainView.backgroundColor = UIColor(hexStringToUIColor: "#33328DDA" , alpha: 1)
            secView.backgroundColor = UIColor(hexStringToUIColor: "#FFFFFF" , alpha: 0.8)
            lbl2.textColor = UIColor(hexStringToUIColor: "#328DDA")
            lblTitle.text = "Contribution"
            lbl2.text = "₹" + getString(anything: totalVal)
        } else {
            mainView.backgroundColor = UIColor(hexStringToUIColor: "#008000" , alpha: 1)
            secView.backgroundColor = UIColor(hexStringToUIColor: "#FFFFFF" , alpha: 0.8)
            lbl2.textColor = UIColor(hexStringToUIColor: "#008000")
            lblTitle.text = "Current Holding"
            // let formattedNumber = String(format: "%.2f", Double(data.value))
            lbl2.text = "₹" + getString(anything: contribution)
        }
    }

}
