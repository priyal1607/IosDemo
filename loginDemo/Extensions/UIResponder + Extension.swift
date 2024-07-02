//
//  UIResponder +. Extension.swift

//
//  Created by Gunjan on 12/04/21.
//

import UIKit

extension UIResponder {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
            parentResponder = parentResponder?.next
        }
        return nil
    }
    
    var parentNavigationController: UINavigationController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            if let navigationController = parentResponder as? UINavigationController {
                return navigationController
            }
            parentResponder = parentResponder?.next
        }
        return nil
    }
}

