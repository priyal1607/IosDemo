//
//  con2vc.swift
//  loginDemo
//
//  Created by Priyal on 29/11/23.
//

import UIKit

class con2vc: UIViewController {
    @IBOutlet weak var txtVillage: UITextField!
    @IBOutlet weak var txtTaluka: UITextField!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var txtDistrict: UITextField!
    fileprivate var districtListModel : [DistrictsListModel] = []
    @IBOutlet weak var btnForward: UIButton!
    var webserviceModelPlayer = PlayerAddressInfoModel()
    @IBOutlet weak var txtAddress: UITextField!
    var comp : ((Bool) -> ())!
    var arrDistrict : [DistrictsListModel] = []
    var arrTaluka : [DistrictsListModel] = []
    var arrVillage : [DistrictsListModel] = []
    weak var containerViewController : SAGVc?
    @IBOutlet weak var txtPin: UITextField!
    fileprivate var webServiceModel = dropDownWebService()
    fileprivate var webSerVice = PersonalInformationModel()
    var dist_id : String = ""
    var taluka_id : String = ""
    var village_id : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        getDistrict()
        btnBack.setFullCornerRadius()
        btnForward.setFullCornerRadius()
        mainView.setCustomCornerRadius(radius: 10)
        mainView.addShadow()

        // Do any additional setup after loading the view.
    }
    @IBAction func btnForwardAction(_ sender: UIButton) {
        fillModel()
        if sender.tag == 0 {
            comp?(true)
        } else if sender.tag == 1 {
            comp?(false)
        }
    }
    
    @IBAction func btnSelectDistrictAction(_ sender: UIButton) {
        var list = self.arrDistrict.map({ $0.title })
        list.insert("Select", at: 0)
        StringPickerViewController.show(pickerType: .single, initialSelection: self.txtDistrict.text, arrSource: [list], doneAction: { (rows, value) in
            
            self.txtDistrict.text = getString(anything: value)
            self.txtTaluka.text = "Select"
            self.txtVillage.text = "Select"
            if rows.first == 0 {
                self.webSerVice.districtId = ""
                self.dist_id = ""
            } else {
                self.webSerVice.districtId = getString(anything: value)
                self.dist_id = getString(anything:  self.arrDistrict.filter{$0.title == getString(anything: value)}[0].id)
            }
        }, animated: true, origin: sender, onVC: self)

    }
    
    @IBAction func btnSelectTalukaAction(_ sender: UIButton) {
        self.webServiceModel.id = getInteger(anything:   self.dist_id)
        CustomActivityIndicator.sharedInstance.showIndicator(view: self.view)
        self.webServiceModel.getListTaluka{ json in
            self.arrTaluka = json.data
            CustomActivityIndicator.sharedInstance.hideIndicator(view: self.view)
            var list = self.arrTaluka.map({ $0.title })
            list.insert("Select", at: 0)
            StringPickerViewController.show(pickerType: .single, initialSelection: self.txtTaluka.text, arrSource: [list], doneAction: { (rows, value) in
                
                self.txtTaluka.text = getString(anything: value)
                self.txtVillage.text = "Select"
                if rows.first == 0 {
                    self.webSerVice.taluka_ZoneId = ""
                    self.taluka_id = ""
                } else {
                    self.webSerVice.taluka_ZoneId = getString(anything: value)
                    self.dist_id = self.txtDistrict.text == "Select" ? "" :
                    getString(anything:  self.arrDistrict.filter{$0.title == getString(anything: self.txtDistrict.text)}[0].id)
                    
                    self.taluka_id = self.txtTaluka.text == "Select" ? "" : getString(anything:  self.arrTaluka.filter{$0.title == getString(anything: value)}[0].id)
                }
                
            }, animated: true, origin: sender, onVC: self)
        }
    }
    
    @IBAction func btnSelectVillageAction(_ sender: UIButton) {
        self.webServiceModel.id = getInteger(anything:  self.dist_id)
        self.webServiceModel.tId = getInteger(anything: self.taluka_id)
        CustomActivityIndicator.sharedInstance.showIndicator(view: self.view)
        self.webServiceModel.getListVillage{ json in
            self.arrVillage = json.data
            CustomActivityIndicator.sharedInstance.hideIndicator(view: self.view)
            var list = self.arrVillage.map({ $0.title })
            list.insert("Select", at: 0)
            StringPickerViewController.show(pickerType: .single, initialSelection: self.txtVillage.text, arrSource: [list], doneAction: { (rows, value) in
                self.txtVillage.text = getString(anything: value)
                if rows.first == 0 {
                    self.webSerVice.villageWardId = ""
                    self.village_id = ""
                } else {
                    self.webSerVice.villageWardId = getString(anything: self.txtVillage.text == "Select" ? 0 : self.arrVillage.filter{$0.title == getString(anything: value)}[0].id)
                    self.village_id = self.txtVillage.text == "Select" ? "" : getString(anything:  self.arrVillage.filter{$0.title == getString(anything: value)}[0].id)
                }
                
            }, animated: true, origin: sender, onVC: self)
        }
    }
}
extension con2vc {
    func getDistrict(){
        webServiceModel.getListDistrict {arr  in
            self.arrDistrict = arr.data
        }
    }
    func getTaluka(){
        webServiceModel.getListTaluka {arr in
            self.arrTaluka = arr.data
            }
    }
    func getVillage(){
        webServiceModel.getListVillage {arr in
            self.arrVillage = arr.data
            }
    }
    
    func fillModel() {
        self.webserviceModelPlayer.district = getString(anything: dist_id)
        self.webserviceModelPlayer.taluka = getString(anything: taluka_id)
        self.webserviceModelPlayer.village = getString(anything: village_id)
        self.webserviceModelPlayer.pin = getString(anything: txtPin.text)
        self.webserviceModelPlayer.address = getString(anything: txtAddress.text)
        }
    }




