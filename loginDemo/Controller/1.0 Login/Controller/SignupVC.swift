//
//  ViewController2.swift
//  loginDemo
//
//  Created by Chelsi on 13/04/23.
//

import UIKit

class SignupVC: UIViewController, UINavigationControllerDelegate , UIImagePickerControllerDelegate{

    @IBOutlet weak var txtDob: UITextField!
    @IBOutlet weak var txttitle: UITextField!
    @IBOutlet weak var Signupbtn: UIButton!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var agreebtn: UIButton!
    @IBOutlet weak var txtcpassword: UITextField!
    @IBOutlet weak var txtpassword: UITextField!
    @IBOutlet weak var txtemail: UITextField!
    @IBOutlet weak var txtlname: UITextField!
    @IBOutlet weak var txtfname: UITextField!
    @IBOutlet weak var imagebtn: UIButton!
    var imagePicker = UIImagePickerController()
    let datePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline:.now()+0.1)  {
            self.imageview.setCustomCornerRadius(radius: self.imageview.frame.width/2)
            self.imagebtn.setCustomCornerRadius(radius: self.imagebtn.frame.width/2)
            self.Signupbtn.setCustomCornerRadius(radius: 10)

        }
        setupToolTip()
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
     
        // Do any additional setup after loading the view.
    }
    func setupToolTip() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let donebtn = UIBarButtonItem(title: "done", style: .plain, target: self, action: #selector(donedatePicker))
        let spacebtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelbtn = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(CanceldatePicker))
        
        toolbar.setItems([donebtn , spacebtn , cancelbtn], animated: true)
        txtDob.inputAccessoryView = toolbar
        txtDob.inputView = datePicker
    }
    
    @objc func donedatePicker(){
       let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        txtDob.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    @objc func CanceldatePicker(){
        self.view.endEditing(true)
    }
    
    
    
    func alert(message:String){
        let alert = UIAlertController(title: "Signup", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func BtnBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnagreeAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    
    @IBAction func titlePickerAction(_ sender: UIButton) {
        let story = UIStoryboard(name: "Pickerview", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "PickerViewController")
        as! PickerViewController
        vc.cityarray = ["Mr.","Mrs.","Miss"]
        
        vc.completion = { [weak self] cityarray in
            guard let self = self else {
                return
            }
            self.txttitle.text = cityarray
        
        }
        self.present(vc, animated: true)
    }
    @IBAction func citypickerAction(_ sender: UIButton) {
        
        let story = UIStoryboard(name: "Pickerview", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "PickerViewController")
        as! PickerViewController
        vc.cityarray = ["Surat","Junagadh" , "Ahmedabad" , "Rajkot"]

        
        vc.completion = { [weak self] cityarray in
            guard let self = self else {
                return
            }
            self.txtCity.text = cityarray
        
        }
        self.present(vc, animated: true)
    }
    
    @IBAction func termsconBtnAction(_ sender: Any) {
        guard let url = URL(string: "https://www.silvertouch.com/terms-of-use/") else {
          return
        }

        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    
    @IBAction func ImageShowBtnAction(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                   imagePicker.delegate = self
                   imagePicker.sourceType = .savedPhotosAlbum
                   imagePicker.allowsEditing = true

                   present(imagePicker, animated: true, completion: nil)
               }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true , completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                    imageview.image = image
                }
    }
    
    @IBAction func btnsignupAction(_ sender: Any) {
        guard let txttitle = txttitle.text, txttitle != "" else{
            self.view.showBanner(message: "Please enter Title name")
            return
            
        }
        
        guard let txtfname = txtfname.text, txtfname != "" else{
            self.view.showBanner(message: "Please enter First name")
            return
            
        }
        guard let txtlname = txtlname.text, txtlname != "" else{
            self.view.showBanner(message: "Please enter Last name")
            return
            
        }
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
            
        guard let city = txtCity.text , city != "" else{
            self.view.showBanner(message: "Please enter City")
            return
            
        }
        guard let dob = txtDob.text , dob != "" else{
            self.view.showBanner(message: "Please enter Dob")
            return
            
        }
            
        guard let txtpassword = txtpassword.text, txtpassword != "" else{
            self.view.showBanner(message: "Please enter Password")
            return
            
        }
        guard let txtcpassword = txtcpassword.text, txtcpassword != "" else{
            self.view.showBanner(message: "Please enter confirm Password")
            return
            
        }
        if (txtpassword != txtcpassword){
            self.view.showBanner(message: "Password and confirm password should be same")
            return
        }
        
        if !agreebtn.isSelected {
            self.view.showBanner(message: "please agree terms and conditions")
            return
        }
        
        let story = UIStoryboard(name: "Dashboard", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func btnpassAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.tag == 0 {
        txtpassword.isSecureTextEntry = !sender.isSelected
    }
        else if sender.tag == 1 {
            txtcpassword.isSecureTextEntry = !sender.isSelected
        }
    
  
    
    }
    
}
