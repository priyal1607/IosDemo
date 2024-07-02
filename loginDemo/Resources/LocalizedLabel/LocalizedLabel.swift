//
//  LocalizedLabel.swift
//  Vidyanjali
//
//  Created by Vikram Jagad on 06/11/20.
//  Copyright © 2020 Vikram Jagad. All rights reserved.
//

import UIKit

class LocalizedLabel: UILabel {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        text = LocalizationParam.getLocalizedStringFor(key: getString(anything: text))
    }
    
}
