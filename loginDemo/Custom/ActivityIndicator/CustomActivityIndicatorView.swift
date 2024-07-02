//
//  CustomActivityIndicatorView.swift
//  TopSliderBar
//
//  Created by STTL on 17/05/18.
//  Copyright © 2018 STTL. All rights reserved.
//

import UIKit

class CustomActivityIndicatorView: UIView
{
    
    var animating : Bool = false
    var fullRotationDuration : CGFloat = 0.0
    var minProgressUnit : CGFloat = 0.0
    var clockWise : Bool = true
    var hidesWhenStopped : Bool = true
    
    //imageviews
    lazy var backgroundImageView : UIImageView =
    {
        let backgroundImageView = UIImageView.init(frame: self.bounds)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImageView
    }()
    lazy var spinnerImageView : UIImageView =
    {
        let spinnerImageView = UIImageView.init(frame: self.bounds)
        spinnerImageView.translatesAutoresizingMaskIntoConstraints = false
        return spinnerImageView
    }()
    
    //override variables
    override open var intrinsicContentSize: CGSize
    {
        get
        {
            return self.sizeThatFits(size: CGSize.zero)
        }
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialize()
    {
        self.fullRotationDuration = 1.0
        self.minProgressUnit = 0.01
        
        let image = UIImage(named: "background-large", in: Bundle.main, compatibleWith: nil)//UIImage(named : "background-large")
        self.setBackgroundImage(img: image!)
        let image1 = UIImage(named: "spinner-large", in: Bundle.main, compatibleWith: nil)//UIImage(named : "spinner-large")
        self.setSpinnerImage(img: image1!)
        
        self.isUserInteractionEnabled = false
        self.addSubview(self.backgroundImageView)
        self.addSubview(self.spinnerImageView)
        self.setupViewConstraints()
    }
    
    func setupViewConstraints()
    {
        
        let views = ["backgroundImageView" : self.backgroundImageView,
                     "spinnerImageView" : self.spinnerImageView]
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[backgroundImageView]|", options: NSLayoutConstraint.FormatOptions.init(rawValue: 0), metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[backgroundImageView]|", options: NSLayoutConstraint.FormatOptions.init(rawValue: 0), metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[spinnerImageView]|", options: NSLayoutConstraint.FormatOptions.init(rawValue: 0), metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[spinnerImageView]|", options: NSLayoutConstraint.FormatOptions.init(rawValue: 0), metrics: nil, views: views))
    }
    
    func setBackgroundImage(img : UIImage) {
        if #available(iOS 13.0, *) {
            self.backgroundImageView.image = img.withRenderingMode(.alwaysTemplate)
            self.backgroundImageView.tintColor = UIColor(dynamicProvider: { traitCollection in
                if traitCollection.userInterfaceStyle == .dark {
                    return UIColor.init(red: 10.0/255.0, green: 132.0/255.0, blue: 255.0/255.0, alpha: 1.0)
                }
                return UIColor.init(red: 17.0/255.0, green: 18.0/255.0, blue: 85.0/255.0, alpha: 1.0)
            })
        } else {
            self.backgroundImageView.image = img
        }
    }

    func setSpinnerImage(img : UIImage)
    {
        self.spinnerImageView.image = img
    }
    
    func sizeThatFits(size : CGSize) -> CGSize
    {
        let backgroundImageSize = self.backgroundImageView.image?.size
        let indicatorImageSize = self.spinnerImageView.image?.size
        
        return CGSize(width : fmax((backgroundImageSize?.width)!, (indicatorImageSize?.width)!), height : fmax((backgroundImageSize?.height)!, (indicatorImageSize?.height)!))
    }

}

extension CustomActivityIndicatorView
{
    func startAnimating()
    {
        if self.animating
        {
            return
        }
        
        self.animating = true
        self.isHidden = false
        let toValue = self.clockWise ? .pi * 2 : -(Double.pi * 2)
        
        self.rotateView(view1:self.spinnerImageView , fromValue: 0.0, toValue: CGFloat(toValue), duration: self.fullRotationDuration, repeatCount: HUGE, key: "rotation", removeOnCompletion: false)
    }
    
    func stopAnimating()
    {
        if !self.animating
        {
            return
        }
        
        self.animating = false
        self.spinnerImageView.layer.removeAnimation(forKey: "rotation")
        if self.hidesWhenStopped
        {
            self.isHidden = true
        }
    }
    
    func rotateView(view1 : UIView, fromValue : CGFloat, toValue : CGFloat, duration : CGFloat, repeatCount : Float, key : String, removeOnCompletion : Bool)
    {
        
        let rotationAnimation = CABasicAnimation()
        rotationAnimation.keyPath = "transform.rotation.z"
        rotationAnimation.fromValue = fromValue
        rotationAnimation.toValue = toValue
        rotationAnimation.duration = CFTimeInterval(duration)
        rotationAnimation.repeatCount = repeatCount
        rotationAnimation.isRemovedOnCompletion = removeOnCompletion
        rotationAnimation.fillMode = CAMediaTimingFillMode.forwards
        view1.layer.add(rotationAnimation, forKey: key)
    }
}
