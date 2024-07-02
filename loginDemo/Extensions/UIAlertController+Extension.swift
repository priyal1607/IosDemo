//
//  UIAlertController+Extension.swift
//  DemoPickerView
//
//  Created by Vikram Jagad on 25/04/19.
//  Copyright © 2019 Vikram Jagad. All rights reserved.
//

import UIKit

extension UIAlertController
{
    func addAction(withTitle title: String, style: UIAlertAction.Style, textColor: UIColor? = nil, image: UIImage? = nil, handler: ((UIAlertAction) -> Void)?)
    {
        let action = UIAlertAction(title: title, style: style, handler: handler)
        if let image = image
        {
            action.setValue(image, forKey: "image")
        }
        if let textColor = textColor
        {
            action.setValue(textColor, forKey: "titleTextColor")
        }
        self.addAction(action)
    }
    
    func set(vc: UIViewController?, width: CGFloat? = nil, height: CGFloat? = nil)
    {
        guard let vc = vc else {
            return
        }
        self.setValue(vc, forKey: "contentViewController")
        if let height = height
        {
            vc.preferredContentSize.height = height
            self.preferredContentSize.height = height
        }
    }
    
    @discardableResult
    class func showWith(title: String? = nil, msg: String? = nil, style: UIAlertController.Style = .alert, sender: UIView? = nil, actionTitles: [String]?, actionImages: [UIImage]? = nil, actionStyles: [UIAlertAction.Style], actionHandlers: [((UIAlertAction?) -> Swift.Void)?] = []) -> UIAlertController {
        
        let alertVC = UIAlertController(title: title, message: msg, preferredStyle: style)
        
        if let actionTitles = actionTitles {
            for i in 0..<actionTitles.count {
                let setStyle : UIAlertAction.Style = actionStyles.indices.contains(i) ? actionStyles[i] : .default
                let setImage = (actionImages?.indices.contains(i) ?? false) ? actionImages![i] : nil
                alertVC.addAction(withTitle: actionTitles[i], style: setStyle, textColor: UIColor.customBlack, image: setImage, handler: actionHandlers.indices.contains(i) ? actionHandlers[i] : nil)
            }
        }
        if let senderView = sender {
            if IS_IPAD {
                alertVC.popoverPresentationController?.sourceView = senderView
                alertVC.popoverPresentationController?.sourceRect = senderView.bounds
            }
            senderView.parentViewController?.present(alertVC, animated: true, completion: nil)
        } else {
            if IS_IPAD {
                alertVC.popoverPresentationController?.sourceView = appDelegate?.window?.rootViewController?.view
                alertVC.popoverPresentationController?.sourceRect = CGRect(x: (appDelegate?.window?.rootViewController?.view.bounds.midX)!, y: (appDelegate?.window?.rootViewController?.view.bounds.midY)!, width: 0, height: 0)
            }
            appDelegate?.window?.rootViewController?.present(alertVC, animated: true, completion: nil)
        }
        
        return alertVC
    }
    
}
