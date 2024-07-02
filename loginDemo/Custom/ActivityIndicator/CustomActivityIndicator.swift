//
//  CustomAcitivityIndicator.swift
//  TopSliderBar
//
//  Created by STTL on 17/05/18.
//  Copyright © 2018 STTL. All rights reserved.
//

import UIKit

class CustomActivityIndicator
{

    let kIndicatorHeight = CGFloat(50.0)
    let kIndicatorTag = 9999
    
    static var sharedInstance : CustomActivityIndicator =
    {
        return CustomActivityIndicator()
    }()
    
    private init()
    {
        self.initActivityIndicatorView()
    }
    
    var activityIndicatorView : CustomActivityIndicatorView!
    
    func initActivityIndicatorView()
    {
        self.activityIndicatorView = CustomActivityIndicatorView.init(frame: CGRect.zero)
        //self.activityIndicatorView.backgroundColor = UIColor.init(white: 1.0, alpha: 0.2)
        self.activityIndicatorView.layer.cornerRadius = kIndicatorHeight/2
        self.activityIndicatorView.clipsToBounds = true
        self.activityIndicatorView.hidesWhenStopped = true
        self.activityIndicatorView.clockWise = true
        self.activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func showIndicator(view : UIView)
    {
        if(self.activityIndicatorView.isDescendant(of: view))
        {
            
        }
        else if(self.activityIndicatorView.superview == nil)
        {
            view.addSubview(self.activityIndicatorView)
        }
        else
        {
            self.initActivityIndicatorView()
            view.addSubview(self.activityIndicatorView)
        }
        
        view.addConstraint(NSLayoutConstraint.init(item: self.activityIndicatorView as Any, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1.0, constant: 0.0))
        view.addConstraint(NSLayoutConstraint.init(item: self.activityIndicatorView as Any, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1.0, constant: 0.0))
        
        self.activityIndicatorView.tag = kIndicatorTag
        self.activityIndicatorView.addConstraint(NSLayoutConstraint.init(item: self.activityIndicatorView as Any, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: kIndicatorHeight))
        self.activityIndicatorView.addConstraint(NSLayoutConstraint.init(item: self.activityIndicatorView as Any, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: kIndicatorHeight))
        view.isUserInteractionEnabled = false
        self.activityIndicatorView.startAnimating()
    }

    func hideIndicator(view : UIView)
    {
        if let view1 = view.viewWithTag(kIndicatorTag) as? CustomActivityIndicatorView
        {
            view1.stopAnimating()
            view1.removeFromSuperview()
            view.isUserInteractionEnabled = true
        }
    }
}
