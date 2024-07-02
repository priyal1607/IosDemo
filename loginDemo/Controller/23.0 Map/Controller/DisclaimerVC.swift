//
//  DisclaimerVC.swift
//  loginDemo
//
//  Created by Priyal on 02/10/23.
//

import UIKit

class DisclaimerVC: UIViewController {

    @IBOutlet weak var lbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        lbl.text = "Maps displayed are from Google Inc. They vary based on user location and do not necessarily reflect boundaries correctly."
        // Do any additional setup after loading the view.
    }
     

    @IBAction func btnCrossAction(_ sender: UIButton) {
        self.dismiss(animated: false)
    }
    
}
