//
//  SlideInPresentationController.swift
//  CIC1
//
//  Created by STTL on 03/07/18.
//  Copyright © 2018 Vikram Jagad. All rights reserved.
//

import UIKit

class SlideInPresentationController: UIPresentationController {
    
    private var direction: PresentationDirection
    fileprivate var dimmingView: UIView!
    
    var ratio: CGFloat
    
    override var frameOfPresentedViewInContainerView: CGRect {
        var frame: CGRect = .zero
        frame.size = size(forChildContentContainer: presentedViewController, withParentContainerSize: (containerView?.bounds.size)!)
        switch direction {
        case .right:
            frame.origin.x = (containerView?.frame.width)! * (1 - ratio)
        case .bottom:
            frame.origin.y = (containerView?.frame.height)! * (1 - ratio)
        default:
            frame.origin = .zero
        }
        return frame
    }
    
    init(presentedVC: UIViewController, presenting presentingVC: UIViewController?, direction: PresentationDirection, ratio: CGFloat)
    {
        self.direction = direction
        self.ratio = ratio
        super.init(presentedViewController: presentedVC, presenting: presentingVC)
        setUpDimmingView()
    }
    
    override func presentationTransitionWillBegin() {
        containerView?.insertSubview(dimmingView, at: 0)
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[dimmingView]|", options: [], metrics: nil, views: ["dimmingView" : dimmingView as Any]))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[dimmingView]|", options: [], metrics: nil, views: ["dimmingView" : dimmingView as Any]))
        
        guard let coordinator = presentedViewController.transitionCoordinator else{
            dimmingView.alpha = 1.0
            return
        }
        
        coordinator.animate(alongsideTransition: { (_) in
            self.dimmingView.alpha = 1.0
        }, completion: nil)
    }
    
    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else{
            dimmingView.alpha = 0.0
            return
        }
        
        coordinator.animate(alongsideTransition: { (_) in
            self.dimmingView.alpha = 0.0
        }, completion: nil)
    }
    
    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        switch direction {
        case .left,.right:
            return CGSize(width: parentSize.width * ratio, height: parentSize.height)
        case .top,.bottom:
            return CGSize(width: parentSize.width, height: parentSize.height * ratio)
        }
    }
}

private extension SlideInPresentationController{
    func setUpDimmingView(){
        dimmingView = UIView()
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.backgroundColor = self.dimmingViewBackGroundColor
        dimmingView.alpha = 0.0
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        dimmingView.addGestureRecognizer(recognizer)
    }
    
    @objc dynamic func handleTap(recognizer: UITapGestureRecognizer){
        presentingViewController.dismiss(animated: true, completion: nil)
    }
    
    var dimmingViewBackGroundColor: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.init { traitCollection in
                if traitCollection.userInterfaceStyle == .dark {
                    return UIColor.init(white: 0.0, alpha: 0.3)
                }
                return UIColor.init(white: 0.0, alpha: 0.7)
            }
        }
        return UIColor.init(white: 0.0, alpha: 0.7)
    }
}
