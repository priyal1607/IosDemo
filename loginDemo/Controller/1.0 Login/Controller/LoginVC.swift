//
//  ViewController.swift
//  loginDemo
//
//  Created by Chelsi on 10/04/23.
//

import UIKit
import BRYXBanner

class LoginVC: UIViewController , UIScrollViewDelegate , UITextFieldDelegate {
    @IBOutlet var btnRemenber: UIButton!
    
    @IBOutlet var skipBtn: UIButton!
    
    @IBOutlet weak var loginview: UIView!
    @IBOutlet weak var clearview: UIView!
    @IBOutlet weak var loginbtn: UIButton!
    @IBOutlet weak var orview: UIView!
    @IBOutlet weak var clearbtn: UIButton!
    @IBOutlet weak var txtotp: UITextField!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var passshowhide: UIButton!
    @IBOutlet weak var txtpassword: UITextField!
    @IBOutlet weak var txtemail: UITextField!
    let defaults = UserDefaults.standard
    var arr : DashboardModel?
    var loginwebService = Loginwebservice()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollview.delegate = self
        txtpassword.delegate = self
        txtemail.delegate = self
        txtotp.delegate = self
        orview.setCustomCornerRadius(radius: 5 , borderColor: .lightGray , borderWidth: 1)
        clearview.setCustomCornerRadius(radius: 10)
        loginview.setCustomCornerRadius(radius: 10)
        skipBtn.setCustomCornerRadius(radius: 10)
        
        
        
        //       loginbtn.addTarget(self, action : #selector(btnclick), for: .touchUpInside)
        //        loginbtn.addTarget(self, action : #selector(btnclick1), for: .touchUpOutside)
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        
        //        let defaults = UserDefaults.standard
        txtemail.text = defaults.string(forKey: "email" ) ?? ""
        txtpassword.text = defaults.string(forKey: "password" ) ?? ""
        btnRemenber.isSelected = false
        
        
    }
    
    
    @objc func  btnclick(_ sender : UIButton){
        loginbtn.layer.backgroundColor = UIColor.red.cgColor
    }
    @objc func  btnclick1(_ sender : UIButton){
        loginbtn.layer.backgroundColor = UIColor.brown.cgColor
    }
    
    
    
    @IBAction func passshowhide(_ sender: Any) {
        passshowhide.isSelected = !passshowhide.isSelected
        txtpassword.isSecureTextEntry = !passshowhide.isSelected
    }
    
    
    @IBAction func loginbtn(_ sender: UIButton) {
        guard let email = txtemail.text, email != "" else{
            self.view.showBanner(message: "Please enter email")
            return
            
        }
        
        
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        if(!emailTest.evaluate(with: email)) {
            self.view.showBanner(message: "please enter valid email")
            return
        }
        guard let pwd = txtpassword.text, pwd != "" else{
            self.view.showBanner(message: "Please Enter Password")
            return
        }
        guard let otp = txtotp.text, otp != "" else{
            self.view.showBanner(message: "Please Enter  Otp")
            return
        }
        let otpRegEx = "[0-9]{4}"
        let otpTest = NSPredicate(format: "SELF MATCHES %@", otpRegEx)
        if(!otpTest.evaluate(with: txtotp.text))
        {
            self.view.showBanner(message: "Please Enter Valid  Otp")
            return
        }
        if btnRemenber.isSelected {
            
            defaults.set (txtemail.text , forKey : "email")
            defaults.set(txtpassword.text , forKey : "password")
            
            
        }
        else{
            defaults.removeObject(forKey: "email")
            defaults.removeObject(forKey: "password")
        }
        defaults.set(true , forKey : "loggedin")
        view.endEditing(true)
//        let story = UIStoryboard(name: "Dashboard", bundle: nil)
//        let vc = story.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
//        self.navigationController?.pushViewController(vc, animated: true)
        let storyboard = UIStoryboard(name: "HomePage", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomePageVC")as! HomePageVC
        let navCon = UICustomNavigationController(rootViewController: vc)
        navCon.isNavigationBarHidden = true
        self.getwindow().rootViewController = navCon
        self.getwindow().makeKeyAndVisible()
        getPaymentDetails()
        txtemail.text = ""
        txtpassword.text = ""
        txtotp.text = ""
        
    }
    @IBAction func forgotPwdBtnActon(_ sender: UIButton) {
        
        let story = UIStoryboard(name: "Forgotpassword", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "ForgotpasswordVC") as! ForgotpasswordVC
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false, completion: nil)
        
        
    }
    @IBAction func clearbtn(_ sender: UIButton) {
        txtemail.text = ""
        txtpassword.text = ""
        txtotp.text = ""
        
    }
    
    
    @IBAction func LinkbtnAction(_ sender: UIButton) {
        if sender.tag == 0{
            guard let url = URL(string: "https://www.google.com/") else {
                return
            }
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        else if sender.tag == 1{
            guard let url = URL(string: "https://www.facebook.com/SilverTouchTechnologies/") else {
                return
            }
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        else if sender.tag == 2 {
            guard let url = URL(string: "https://www.linkedin.com/company/silver-touch-technologies-ltd") else {
                return
            }
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
            
        }
    }
    
    @IBAction func btnrememberaction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
    }
    @IBAction func skipBtnAction(_ sender: Any) {
//        let story = UIStoryboard(name: "Dashboard", bundle: nil)
//        let vc = story.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
//        self.navigationController?.pushViewController(vc, animated: true)
        
        let storyboard = UIStoryboard(name: "BottomBarController", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "BottomBarViewController")as! BottomBarViewController
        let navCon = UICustomNavigationController(rootViewController: vc)
        navCon.isNavigationBarHidden = true
        self.getwindow().rootViewController = navCon
        self.getwindow().makeKeyAndVisible()
        
    }
    
    
    
    @IBAction func btnSignupAction(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignupVC") as! SignupVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
extension UIView {
    func setCustomCornerRadius(radius : CGFloat, borderColor : UIColor = .clear, borderWidth : CGFloat = 0) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.clipsToBounds = true
    }
    func addShadow(shadowColor: UIColor = .black, shadowOpacity: Float = 0.5, shadowRadius: CGFloat? = nil, shadowOffset: CGSize = .zero)
    {
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = shadowOpacity
        if let getShadowRadius = shadowRadius {
            self.layer.shadowRadius = getShadowRadius
        }
    }
    
    func showBanner(title: String? = nil, message: String, img: UIImage? = nil, bgColor: UIColor = .white) {
        let banner = Banner(title: title, subtitle: message, image: img, backgroundColor: bgColor, didTapBlock: nil)
        banner.titleLabel.textColor = .red
        banner.titleLabel.font = .boldSystemFont(ofSize: 16)
        banner.detailLabel.textColor = .red
        banner.detailLabel.font = .systemFont(ofSize: 16)
        banner.dismissesOnTap = true
        banner.dismissesOnSwipe = true
        banner.show(nil, duration: 1.5)
    }
    func createDottedLine(width: CGFloat, color: CGColor) {
         let caShapeLayer = CAShapeLayer()
         caShapeLayer.strokeColor = color
         caShapeLayer.lineWidth = width
         caShapeLayer.lineDashPattern = [5,5]
         let cgPath = CGMutablePath()
         let cgPoint = [CGPoint(x: 0, y: 0), CGPoint(x: self.frame.width, y: 0)]
         cgPath.addLines(between: cgPoint)
         caShapeLayer.path = cgPath
         layer.addSublayer(caShapeLayer)
      }
}


extension LoginVC {
    func getPaymentDetails() {
        loginwebService.getUserData { arr in
            self.arr = arr
        }
    }
}

extension NSObject {
    func readJsonFile(ofName: String) -> [String : Any] {
        guard let strPath = Bundle.main.path(forResource: ofName, ofType: ".json") else {
            return [:]
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: strPath), options: .alwaysMapped)
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            if let dictJson = jsonResult as? [String : Any] {
                return dictJson
            }
        } catch {
            print("Error!! Unable to parse ")
        }
        return [:]
    }
    func getwindow() -> UIWindow{
        var window:UIWindow!
        if window == nil
        {
            window = (UIApplication.shared.delegate as? AppDelegate)?.window
        }
        return window
    }
    
}
