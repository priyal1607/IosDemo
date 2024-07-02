//
//  con1vc.swift
//  loginDemo
//
//  Created by Priyal on 29/11/23.
//

import UIKit

class con1vc: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //  @IBOutlet weak var addImg: UIImageView!
    @IBOutlet weak var imgMaleSel: UIImageView!
    @IBOutlet weak var btnFemale: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var txtMoNumber: UITextField!
    @IBOutlet weak var txtUserCategory: UITextField!
    @IBOutlet weak var imgFeSel: UIImageView!
    @IBOutlet weak var txtSport: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var txtDob: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtMiddleName: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtSportsCat: UITextField!
    @IBOutlet weak var imgUserImg: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imgImgUser: UIImageView!
    @IBOutlet weak var imgPlus: UIImageView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var btnSelectSportsAction: UITextField!
    @IBOutlet weak var btnForward: UIButton!
    var imagePicker = UIImagePickerController()
    var arrTitle1 : PlayerRegistrationDropDownModel?
    var dropDownTitle : [DropDownResponseModel] = []
    var webService  = dropDownwebServicemodel()
    var comp : ((Bool) -> ())!
    var comparr : (([String]) -> ())!
    let datePicker = UIDatePicker()
    fileprivate var webServiceModel = PlayerPersonalInfoModel()
    weak var containerViewController : SAGVc?
    override func viewDidLoad() {
        super.viewDidLoad()
        getTitleData()
        btnForward.setFullCornerRadius()
        //backView.setCustomCornerRadius(radius: backView.frame.width/2)
        //backView.setFullCornerRadius()
        imgPlus.setFullCornerRadius()
        imgImgUser.setFullCornerRadius(type: .automatic, borderColor: UIColor.init(hexStringToUIColor: "#052160"), borderWidth: 5)
        mainView.setCustomCornerRadius(radius: 10)
        mainView.addShadow()
        // addImg.setFullCornerRadius()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnChoosePhotoAction(_ sender: UIButton) {
        
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
            imgUserImg.image = image
        }
    }
    @IBAction func btnSportsCatAction(_ sender: UIButton) {
        var list = containerViewController!.arrTitle!.atelic_category.map{ $0.title}
        
        //var list = ["sdds","sdss","asijjs"]
        list.insert("Select", at: 0)
        StringPickerViewController.show(pickerType: .single, initialSelection: self.txtSportsCat.text, arrSource: [list], doneAction: { (rows, value) in
            
            self.txtSportsCat.text = getString(anything: value)
            if let index = rows.first {
                if index == 0 {
                    self.webServiceModel.userCategory = ""
                } else {
                    self.txtSportsCat.text = getString(anything: value)
                    //                    self.webServiceModel.userCategory = self.containerViewController!.arrTitle!.ms_sports_id[index-1].id
                }
            }
        }, animated: true, origin: sender, onVC: self)
    }
    @IBAction func btnSelectSportsAction(_ sender: UIButton) {
        var list = containerViewController!.arrTitle!.ms_sports_id.map{ $0.title}
        
        //var list = ["sdds","sdss","asijjs"]
        list.insert("Select", at: 0)
        StringPickerViewController.show(pickerType: .single, initialSelection: self.txtSport.text, arrSource: [list], doneAction: { (rows, value) in
            
            self.txtSport.text = getString(anything: value)
            if let index = rows.first {
                if index == 0 {
                    self.webServiceModel.userCategory = ""
                } else {
                    self.txtSport.text = getString(anything: value)
                    //                    self.webServiceModel.userCategory = self.containerViewController!.arrTitle!.ms_sports_id[index-1].id
                }
            }
        }, animated: true, origin: sender, onVC: self)
    }
    
    @IBAction func btnUserCatAction(_ sender: UIButton) {
        var list = containerViewController!.arrTitle!.user_category.map{ $0.title}
        
        //var list = ["sdds","sdss","asijjs"]
        list.insert("Select", at: 0)
        StringPickerViewController.show(pickerType: .single, initialSelection: self.txtUserCategory.text, arrSource: [list], doneAction: { (rows, value) in
            
            self.txtUserCategory.text = getString(anything: value)
            if let index = rows.first {
                if index == 0 {
                    self.webServiceModel.userCategory = ""
                } else {
                    self.txtUserCategory.text = getString(anything: value)
                    //                    self.webServiceModel.userCategory = self.containerViewController!.arrTitle!.ms_sports_id[index-1].id
                }
            }
        }, animated: true, origin: sender, onVC: self)
    }
    @IBAction func btnSelectDateAction(_ sender: UIButton) {
        let date = Calendar.current.date(byAdding: .year, value: -10, to: Date())
        
        let datePickerVC = DatePickerViewController(initialSelection: DateConverter.getDateFromDateString(aDateString: getString(anything: txtDob.text), inputFormat: DateFormats.dd_MM_yyyy_dashed), maximumDate: date, minimumDate: nil, datePickerMode: .date, doneAction: { (selectedDate) in
            
            let dobString = DateConverter.getDateStringFromDate(aDate: selectedDate, outputFormat: DateFormats.dd_MM_yyyy_dashed)
            let today = Date()
            let birthDate = dobString.getDate(format: DateFormats.dd_MM_yyyy_dashed)
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day], from: birthDate, to: today)
            print("date : ",components)
            self.txtAge.text = getString(anything:components.year)
            self.txtDob.text = dobString
            
        }, animated: true, origin: sender)
        
        datePickerVC.lblTitleText = "Select"
        datePickerVC.lblTitleColor = .gray
        datePickerVC.btnCancelTitle = "Cancel"
        datePickerVC.btnCancelTitleColor = .gray
        datePickerVC.btnDoneTitle = "Done"
        datePickerVC.show(onVC: self)
    }
    @IBAction func btnSelectTitleAction(_ sender: UIButton) {
        var list = containerViewController!.arrTitle!.title.map{ $0.title}
        list.insert("Select", at: 0)
        StringPickerViewController.show(pickerType: .single, initialSelection: self.txtTitle.text, arrSource: [list], doneAction: { (rows, value) in
            
            self.txtTitle.text = getString(anything: value)
            if let index = rows.first {
                if index == 0 {
                    self.webServiceModel.userCategory = ""
                } else {
                    self.txtTitle.text = getString(anything: value)
                }
            }
        }, animated: true, origin: sender, onVC: self)
        
    }
    
    @IBAction func btnNextAction(_ sender: UIButton) {
        comp?(true)
        //fillModel()
    }
    @IBAction func btnMaleAction(_ sender: UIButton) {
        btnMale.isSelected = true
        imgMaleSel.image = UIImage(named: "sel_1")
        btnFemale.isSelected = true
        imgFeSel.image = UIImage(named: "radio_UnSelected")
    }
    
    @IBAction func btnFemaleAction(_ sender: UIButton) {
        btnFemale.isSelected = true
        imgFeSel.image = UIImage(named: "sel_1")
        btnMale.isSelected = true
        imgMaleSel.image = UIImage(named: "radio_UnSelected")
    }
}
extension con1vc {
    func getTitleData() {
        webService.form_type = "player-registration"
        webService.getList {arr in
            self.arrTitle1 = arr
        }
        
    }
    
    func fillModel() {
        self.webServiceModel.title = getString(anything: self.containerViewController!.arrTitle!.title.filter{$0.title == getString(anything: txtTitle.text ?? "")}[0].id)
        self.webServiceModel.firstName = getString(anything: txtFirstName.text)
        self.webServiceModel.middleName = getString(anything: txtMiddleName.text)
        self.webServiceModel.lastName = getString(anything: txtLastName.text)
        self.webServiceModel.mobileNumber = getString(anything: txtMoNumber.text)
        self.webServiceModel.email = getString(anything: txtEmail.text)
        self.webServiceModel.dob = getString(anything: txtDob.text)
        self.webServiceModel.age = getString(anything: txtAge.text)
       // self.webServiceModel.other_sports = getString(anything: txtOtherSports.text)

        if btnMale.isSelected == true{
        self.webServiceModel.gender = getString(anything: "1")
        }else{
            self.webServiceModel.gender = getString(anything: "2")
        }
        
        self.webServiceModel.userCategory = getString(anything: self.containerViewController!.arrTitle!.user_category.filter{$0.title == getString(anything: txtUserCategory.text ?? "")}[0].id)
        
        self.webServiceModel.sport = (getString(anything: txtSport.text ?? "") != "other") ? getString(anything: self.containerViewController!.arrTitle!.ms_sports_id.filter{$0.title == getString(anything: txtSport.text ?? "")}[0].id) : "other"
        
        self.webServiceModel.sportCategory = getString(anything: self.containerViewController!.arrTitle!.atelic_category.filter{$0.title == getString(anything: txtSportsCat.text ?? "")}[0].id)

        }
    }


