//
//  ForgotpasswordVC.swift
//  loginDemo
//
//  Created by Chelsi on 09/05/23.
//

import UIKit

class ForgotpasswordVC: UIViewController {
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var crossView: UIView!
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var crossBtnAction: UIButton!
    @IBOutlet var submitBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline:.now()+0.1)  {
            self.crossView.setCustomCornerRadius(radius: self.crossView.frame.height/2)
            self.mainView.setCustomCornerRadius(radius:10)
            self.submitBtn.setCustomCornerRadius(radius:10,borderColor: .blue , borderWidth: 1)

        }

        // Do any additional setup after loading the view.
    }
    
    func alert(message:String){
        let alert = UIAlertController(title: "Forgot Password", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func submitBtnAction(_ sender: UIButton) {
        guard let email = txtEmail.text,  email != ""  else {
            self.view.showBanner(message: "Please enter email")
            return
        }
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        if(!emailTest.evaluate(with: email)) {
            self.view.showBanner(message: "please enter valid email")
            return
        }
        
        self.dismiss(animated: true)
    }
    
    @IBAction func crossBtnAction(_ sender: UIButton) {
        self.dismiss(animated: false)
    }
}
