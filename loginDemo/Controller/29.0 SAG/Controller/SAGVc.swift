//
//  SAGVc.swift
//  loginDemo
//
//  Created by Priyal on 29/11/23.
//

import UIKit

class SAGVc: UIViewController {
    @IBOutlet weak var con3: UIView!
    @IBOutlet weak var con2: UIView!
    @IBOutlet weak var cont1: UIView!
    @IBOutlet weak var img3_tick: UIImageView!
    @IBOutlet weak var img2_tick: UIImageView!
    @IBOutlet weak var img1_tick: UIImageView!
    var webService = dropDownwebServicemodel()
    var webServiceRegister = PlayerRegWebService()
    var arrTitle : PlayerRegistrationDropDownModel?
    var count : Int = 0
    var comarr : ((Array<Any>) -> ())!
    override func viewDidLoad() {
        super.viewDidLoad()
        getListData()
        img1_tick.setFullCornerRadius()
        img2_tick.setFullCornerRadius()
        img3_tick.setFullCornerRadius()
        //img1_tick.backgroundColor = .white
        img2_tick.backgroundColor = .blue
        img3_tick.backgroundColor = .blue
        
        
       
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? con1vc {
            vc.containerViewController = self
            vc.comp = { flag  in
                if flag {
                    // self.count = count + 1
                    self.con2.isHidden = false
                    self.con3.isHidden = true
                    self.cont1.isHidden = true
                   //self.img1_tick.backgroundColor = .white
                    self.img2_tick.backgroundColor = .white
                    self.img2_tick.backgroundColor = .blue
                    self.img2_tick.image = .ic_radio_selected
                    self.img1_tick.image = .ic_radio_selected
                    self.img3_tick.image = .ic_radio_unselected
                    //self.count = self.count + 1
                }}
        }
        
        if let vc = segue.destination as? con2vc {
            vc.comp = { flag1  in
                vc.containerViewController = self
                if flag1 {
                    self.con2.isHidden = true
                    self.con3.isHidden = true
                    self.cont1.isHidden = false
                    self.img2_tick.backgroundColor = .blue
                    self.img3_tick.backgroundColor = .blue
                    self.img2_tick.image = .ic_radio_unselected
                    self.img1_tick.image = .ic_radio_selected
                    self.img3_tick.image = .ic_radio_unselected
                } else {
                    self.con2.isHidden = true
                    self.con3.isHidden = false
                    self.cont1.isHidden = true
                    self.img2_tick.image = .ic_radio_selected
                    self.img1_tick.image = .ic_radio_selected
                    self.img3_tick.image = .ic_radio_selected
                }
            }
        }
        
        if let vc = segue.destination as? con3vc {
            //vc.containerViewController = self
            vc.comp = { flag in
                if flag {
                    self.con2.isHidden = false
                    self.con3.isHidden = true
                    self.cont1.isHidden = true
                    self.img3_tick.backgroundColor = .blue
                    self.img2_tick.image = .ic_radio_selected
                    self.img1_tick.image = .ic_radio_selected
                    self.img3_tick.image = .ic_radio_unselected
                }}
        }
        
    }
}

extension SAGVc {
    func getListData(){
        webService.form_type = "player-registration"
        webService.getList {arr in
            self.arrTitle = arr
        }
    }
    
    func getRegisterData(){
        webServiceRegister.registerPlayer{response, strMsg, isSuccess in
            CustomActivityIndicator.sharedInstance.hideIndicator(view: self.view)
            if getString(anything:response[CommonAPIConstant.key_resultFlag]) == "1" {
//                UIAlertController.showWith(title: "", msg: strMsg, style: .alert, onVC: self, actionTitles: ["Ok"], actionStyles: [.default], actionHandlers: [{ (yesAction) in
//                    //self.getDataFromWebServices()
//                }])
            }
        }
    }
    
}

