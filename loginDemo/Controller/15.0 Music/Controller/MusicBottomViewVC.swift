//
//  MusicBottomViewVC.swift
//  loginDemo
//
//  Created by Priyal on 17/08/23.
//

import UIKit

class MusicBottomViewVC: UIViewController {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblName: UILabel!
    var comp : (() -> ())!
    var iscomplete : Bool = false
    @IBOutlet weak var btnCancel: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainView.isUserInteractionEnabled = true
        mainView.setCustomCornerRadius(radius: 20)
        btnCancel.setCustomCornerRadius(radius: btnCancel.frame.width/2)
        
        // Do any additional setup after loading the view.
    }
  
    @IBAction func btnCancelAction(_ sender: UIButton) {
        self.comp()
    }
}
