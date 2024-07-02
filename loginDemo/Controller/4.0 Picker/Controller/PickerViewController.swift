//
//  pickerViewController.swift
//  loginDemo
//
//  Created by Chelsi on 25/04/23.
//

import UIKit

class PickerViewController: UIViewController {
    @IBOutlet weak var CityPickerView: UIPickerView!
    var cityarray:[String] = []
    var selectedcity : String?
    var completion:((String) -> ())!
    override func viewDidLoad() {
        super.viewDidLoad()
        CityPickerView.delegate = self
        CityPickerView.dataSource = self
        pickerView(CityPickerView, didSelectRow: 0, inComponent: 0)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func DoneBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true)
        self.completion(self.selectedcity ?? "")
    }
    
    @IBAction func cancelbtnAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
extension PickerViewController : UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cityarray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cityarray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedcity = cityarray[row]
    }
    
    
}
