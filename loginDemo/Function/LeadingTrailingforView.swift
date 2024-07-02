//
//  LeadingTrailingforView.swift
//  MyGovMaharashtra
//
//  Created by Gunjan Patel on 14/06/19.
//  Copyright © 2019 Vikram Jagad. All rights reserved.
//

import UIKit

func changeLeadingTrailingForiPad(view: UIView?) {
    if (IS_IPAD) {
        view?.constraints.forEach({ (constraint) in
            if (constraint.identifier == "changeConstraint") {
                constraint.constant += IPAD_MARGIN
            }
        })
    }
}

func changeHeightForiPad(view: UIView?, constant: CGFloat = 20) {
    if (IS_IPAD) {
        view?.constraints.forEach({ (constraint) in
            if (constraint.firstAttribute == .height) {
                constraint.constant += constant
            }
        })
    }
}
