//
//  DetailsViewController.swift
//  loginDemo
//
//  Created by Chelsi on 21/04/23.
//

import UIKit

class DetailsViewController: UIViewController {
    
   
    @IBOutlet var droupDownImg: UIImageView!
    @IBOutlet var view1: UIView!
    @IBOutlet var headerView: UIView!
    @IBOutlet var view3: UIView!
    @IBOutlet var view6: UIView!
    @IBOutlet var view5: UIView!
    @IBOutlet var view4: UIView!
    @IBOutlet var view2: UIView!
    @IBOutlet var resultBtn: UIButton!
    @IBOutlet var detailsCollView: UICollectionView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var GreView: UIView!
    @IBOutlet weak var lblphone: UILabel!
    @IBOutlet weak var lblage: UILabel!
    @IBOutlet weak var lbladd: UILabel!
    @IBOutlet weak var lbl6: UILabel!
    @IBOutlet weak var lbl5: UILabel!
    @IBOutlet weak var lbl4: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lblgender: UILabel!
    @IBOutlet weak var lblstudentid: UILabel!
    @IBOutlet weak var secview: UIView!
    @IBOutlet weak var lbldept: UILabel!
    @IBOutlet weak var lbldob: UILabel!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var charview: UIView!
    @IBOutlet weak var chview: UIView!
    @IBOutlet weak var lblchar: UILabel!
    @IBOutlet weak var lblsportName: UILabel!
    @IBOutlet weak var lblrefid: UILabel!
    @IBOutlet weak var refview: UIView!
    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var stackview: UIStackView!
    fileprivate var colViewDataSourceDelegate: DetailsCollViewDatasourcedelegate?
    var flag = 0
    var model : DashboardModel?
    var model2 : [DetailsDoc] = []

    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            UIColor(red: 0/255, green: 48/255, blue: 134/255, alpha: 1).cgColor,
            UIColor(red: 0/255, green: 86/255, blue: 163/255, alpha: 1).cgColor,
        ]
        gradient.locations = [0, 1]
        
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        return gradient
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        DispatchQueue.main.asyncAfter(deadline:.now()+0.1)  {
            
            self.chview.setCustomCornerRadius(radius: self.chview.frame.height/2 , borderColor: .systemPink , borderWidth: 2)
            self.secview.setCustomCornerRadius(radius: self.secview.frame.height/2 ,borderColor: .blue, borderWidth: 10 )
            self.refview.setCustomCornerRadius(radius: 10)
            self.viewCard.setCustomCornerRadius(radius: 10)
            self.viewCard.addShadow()
            self.gradient.frame = self.GreView.bounds
            self.GreView.layer.addSublayer(self.gradient)
            
        }
        setupData()
    }
  
    
    func setupData(){
        if let model = model {
            lblname.text = model.name
            lbldob.text = model.dob
            lblphone.text = model.phone
            lblstudentid.text = model.student_id
            lbl1.text = model.sem1
            lbl2.text = model.sem2
            lbl3.text = model.sem3
            lbl4.text = model.sem4
            lbl5.text = model.sem5
            lbl6.text = model.sem6
            lblage.text = model.age
            lbldept.text = model.dept
            let c:String = lblname.text!
            let prefix = c.index(c.startIndex, offsetBy: 1)
            let i = c[..<prefix]
            lblchar.text = String(i)
            lbladd.text = model.address
            lblgender.text = model.gender
            lblsportName.text = model.sports_name
            lblrefid.text = model.student_id
            imageView.image = UIImage(named: model.image)
            model2 = model.docs
            setUpColView()
        }
    }
    func setUpColView (){
        if colViewDataSourceDelegate == nil {
            colViewDataSourceDelegate = .init(arrSrc: model2, colView: detailsCollView, del: self)
        }
    }
    
    @IBAction func ResultBtnAction(_ sender: UIButton) {
        if flag==0 {
            view1.isHidden = false
            view2.isHidden = false
            view3.isHidden = false
            view4.isHidden = false
            view5.isHidden = false
            view6.isHidden = false
            headerView.isHidden = false
            droupDownImg.image = UIImage(named: "up")
            flag = 1
        }
        else{
            view1.isHidden = true
            view2.isHidden = true
            view3.isHidden = true
            view4.isHidden = true
            view5.isHidden = true
            view6.isHidden = true
            headerView.isHidden = true
            droupDownImg.image = UIImage(named: "dropdown")
            flag = 0
        }
    }

     @IBAction func backbtnAction(_ sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
 
     }

}
extension DetailsViewController : ColViewDelegate {
//    func didSelect(colView: UICollectionView, indexPath: IndexPath) {
//        let storyboard = UIStoryboard(name: "ShowImageStoryboard", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "ShowImageViewController")as! ShowImageViewController
//        vc.showImageView.image = UIImage(named:)
//        self.present(vc, animated: true)
//    }
    
}
