//
//  UITableViewCell+Extension.swift
//  SharkID
//
//  Created by Vikram Jagad on 25/02/19.
//  Copyright © 2019 sttl. All rights reserved.
//

import UIKit

extension UITableViewCell
{
    //MARK:- Add Full Screen Width Seprater
    func addFullScreenWidthSeprater()
    {
        let sepraterView = UIView()
        sepraterView.translatesAutoresizingMaskIntoConstraints = false
        sepraterView.backgroundColor = UIColor(hexStringToUIColor:"#E8E9EB")
        self.contentView.addSubview(sepraterView)
        self.contentView.addConstraint(NSLayoutConstraint(item: sepraterView, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 1, constant: 0))
        self.contentView.addConstraint(NSLayoutConstraint(item: sepraterView, attribute: .left, relatedBy: .equal, toItem: self.contentView, attribute: .left, multiplier: 1, constant: 0))
        self.contentView.addConstraint(NSLayoutConstraint(item: sepraterView, attribute: .right, relatedBy: .equal, toItem: self.contentView, attribute: .right, multiplier: 1, constant: 0))
        self.contentView.addConstraint(NSLayoutConstraint(item: sepraterView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 1.0))
    }
}
