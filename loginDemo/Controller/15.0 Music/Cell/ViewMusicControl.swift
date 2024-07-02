//
//  musicView.swift
//  loginDemo
//
//  Created by Priyal on 18/08/23.
//

import UIKit
import Foundation

class ViewMusicControl: UIView {
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var view2: GradientView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBOutlet weak var btnFullView: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnForward: UIButton!
    @IBOutlet weak var imgForward: UIImageView!
    @IBOutlet weak var imgBack: UIImageView!
    
    @IBOutlet weak var btnPause: UIButton!
    @IBOutlet weak var imgPause: UIImageView!
    
    @IBOutlet weak var lblTit: MarqueeLabel!
    @IBOutlet weak var lblName: MarqueeLabel!
    
    @IBOutlet weak var btnCancel: UIButton!
    var cancleCom: (() -> ())!
    var dataCom :(() -> ())!
    var forwardcom :(() -> ())!
    var backWardCom : (() -> ())!
    var pauseCom : (() -> ())!
    var isplay : Bool = false
    var issender = true
    //let viewMusic = Bundle.main.loadNibNamed("ViewMusicControl", owner: nil, options: nil)![0] as! ViewMusicControl
    override init(frame: CGRect) {
        super.init(frame: frame)

            
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        indicator.color = .white
//        indicator.style = .large
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.view2.backgroundColor = .systemOrange
            self.view2.gradientLayer.colors = [UIColor.rgb(248,97,6).cgColor , UIColor.rgb(250,120,15).cgColor ]
            self.view2.gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
            self.view2.gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
            self.view2.setCustomCornerRadius(radius: 20)
            //self.commonInit()
            //self.setupView()
            //self.mainView.superview?.setCustomCornerRadius(radius: 20)
            self.btnCancel.setCustomCornerRadius(radius: self.btnCancel.frame.width/2)
            self.imgPause.setCustomCornerRadius(radius: self.imgPause.frame.width/2)
//            self.data()
        }
        [self.lblTit, self.lblName].forEach({
            $0?.type = .continuous
            $0?.speed = .duration(7.0)
            $0?.fadeLength = 10.0
            $0?.trailingBuffer = 30.0
        })
       
    }
    
    private func commonInit() {
        
        // Customize your view here
        backgroundColor = UIColor.customOrange // Set your desired background color
        translatesAutoresizingMaskIntoConstraints = false
    }
    private func setupView() {
            // Create the width constraint
            let widthConstraint = NSLayoutConstraint(
                item: self,
                attribute: .width,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1.0,
                constant: UIScreen.main.bounds.width// Set width to screen width
            )
            // Activate the width constraint
            widthConstraint.isActive = true
            
            // Other setup code for your custom view
        }
   
  
}


