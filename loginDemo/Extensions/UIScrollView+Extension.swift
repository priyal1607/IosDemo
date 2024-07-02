//
//  UIScrollView+Extension.swift
//  WarRoom
//
//  Created by Vikram Jagad on 21/08/19.
//  Copyright © 2019 Gunjan Patel. All rights reserved.
//

import UIKit

extension UIScrollView {
    // Exposes a _refreshControl property to iOS versions anterior to iOS 10
    // Use _refreshControl and refreshControl intercheangeably in a UIScrollView (get + set)
    //
    // All iOS versions: `bounces` is always required if `contentSize` is smaller than `frame`
    // Pre iOS 10 versions: `alwaysBounceVertical` is also required for small content
    // Only iOS 10 allows the refreshControl to work without drifting when pulled to refresh
    var _refreshControl : UIRefreshControl? {
        get {
            return self.refreshControl
        } set {
            self.refreshControl = newValue
        }
    }
    
    // Creates and adds a UIRefreshControl to this UIScrollView
    func addRefreshControl(target: Any?, action: Selector) -> UIRefreshControl {
        let control = UIRefreshControl()
        return control
    }
        
}

class UIBottomToTopScrollView : UIScrollView {
    
    var maxHeight: CGFloat = UIScreen.main.bounds.height
    
    override var contentSize:CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        let setHeight = min(contentSize.height, maxHeight)
        return CGSize(width: UIView.noIntrinsicMetric, height: setHeight)
    }
    
}
