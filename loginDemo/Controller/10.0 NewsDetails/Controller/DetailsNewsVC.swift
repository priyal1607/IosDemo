//
//  DetailsNewsVC.swift
//  loginDemo
//
//  Created by Chelsi on 26/05/23.
//
import UIKit
class DetailsNewsVC: HeaderViewController {
    @IBOutlet var dashView: UIView!
    @IBOutlet var lblDetails: UILabel!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var imgView: UIImageView!
    var model : NewsModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.dashView.createDottedLine(width: 2.0, color: UIColor.gray.cgColor)
        setupdata()
        setUpHeader()
    }
    
    func setUpHeader() {
        self.setUpHeaderTitle(strHeaderTitle: "News")
        self.viewHeader.lblHeaderTitle.textColor = .white
        self.setHeaderView_BackImage()
        self.hideShare()
    
    }
    override func btnShareTapped(_ sender: UIButton) {
            let activityViewController = UIActivityViewController(activityItems: [lblTitle.text!], applicationActivities: nil)
            UIApplication.shared.keyWindow?.rootViewController?.present(activityViewController, animated: true, completion: nil)
    }

    override func btnBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupdata(){
        if let model = model {
            lblDetails.text = model.details
            lblTitle.text = model.title
            lblDate.text = model.time2
            let url = URL(string: (model.image)! )
            imgView?.sd_setImage(with: url)
        }
    }
    @IBAction func btnShareAction(_ sender: Any) {
        let activityViewController = UIActivityViewController(activityItems: [lblTitle.text!], applicationActivities: nil)
        UIApplication.shared.keyWindow?.rootViewController?.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
