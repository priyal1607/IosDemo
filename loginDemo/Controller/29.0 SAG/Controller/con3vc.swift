//
//  con3vc.swift
//  loginDemo
//
//  Created by Priyal on 29/11/23.
//

import UIKit

class con3vc: UIViewController {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var txtCpassword: UITextField!
    @IBOutlet weak var txtBenifit: UITextField!
    var webService = PlayerLoginInfoModel()
    var comp : ((Bool) -> ())!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn.setFullCornerRadius()
        btnRegister.setCustomCornerRadius(radius: 7)
        mainView.setCustomCornerRadius(radius: 10)
        mainView.addShadow()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        comp?(true)
        fillModel()
    }
    
    @IBAction func btnSelectBenefitAction(_ sender: UIButton) {
        let story = UIStoryboard(name: "Pickerview", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "PickerViewController")
        as! PickerViewController
        vc.cityarray = ["Select","Yes","No"]
        vc.completion = { [weak self] cityarray in
            guard let self = self else {
                return
            }
            self.txtBenifit.text = cityarray
        
        }
        self.present(vc, animated: false)
    }
    
    @IBAction func btnRegisterAction(_ sender: UIButton) {
        fillModel()
    }
    @IBAction func btnPaasShowHideAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.tag == 0 {
        txtPassword.isSecureTextEntry = !sender.isSelected
    }
        else if sender.tag == 1 {
            txtCpassword.isSecureTextEntry = !sender.isSelected
        }
    }
    @IBAction func btnAgreeAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
}
extension con3vc{
    func fillModel() {
        self.webService.username = getString(anything: txtUserName.text)
        self.webService.password = getString(anything: txtPassword.text)
        self.webService.benefit_sag = getString(anything:txtBenifit.text)
        }
}
