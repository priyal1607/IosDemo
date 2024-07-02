//
//  LogoutVC.swift
//  loginDemo
//
//  Created by Chelsi on 10/05/23.
//

import UIKit

class LogoutVC: UIViewController {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var btnCancel: UIButton!
    @IBOutlet var btnOk: UIButton!
    var com : (() -> ())!
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline:.now()+0.1)  {
            self.mainView.setCustomCornerRadius(radius: 10)
            self.btnCancel.setCustomCornerRadius(radius: 10)
            self.btnOk.setCustomCornerRadius(radius: 10)
        }
        
    }
    @IBAction func okBtnAction(_ sender: Any) {
        self.dismiss(animated: false , completion: {
            self.com()
        })
    }
    @IBAction func cancelBtnAction(_ sender: Any) {
        self.dismiss(animated: false)
    }
}
