//
//  NPSTblViewCell2.swift
//  loginDemo
//
//  Created by Priyal on 15/09/23.
//

import UIKit

class NPSTblViewCell2: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lbl4: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl1: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func confifcell1(){
            lbl1.text = "Scheme \nName"
            lbl2.text = "NAV(Previous Day) \nin (₹)"
            lbl3.text = "Total \nUnits"
            lbl4.text = "Total Value of \nHolding (₹)"
        mainView.backgroundColor = UIColor(hexStringToUIColor: "#D6DAFF")
    }
    func confifcell2(total : Double){
        lbl1.text = "Total Holdings"
        lbl2.text = " "
        lbl3.text = " "
        lbl4.text = getString(anything: total)
        mainView.backgroundColor = UIColor(hexStringToUIColor: "#D6DAFF")
    }
    func configureCell(data : NpsScheme , index : Int){
       
        if index % 2 == 0 {
            mainView.backgroundColor = UIColor(hexStringToUIColor: "#F3F4FF")
        }
        if index % 2 != 0 {
            mainView.backgroundColor = .white
        }
        lbl1.text = data.schemeName
        lbl2.text = getString(anything: getFloat(anything: data.nav))
        print(getFloat(anything: data.nav))
        lbl3.text = getString(anything: data.units)
        let formattedNumber = String(format: "%.2f", Double(data.value))
        lbl4.text = getString(anything : formattedNumber)
    }
}
