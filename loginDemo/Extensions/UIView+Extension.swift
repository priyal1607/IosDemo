//
//  UIView+CustomizedView.swift
//  Tradesmen
//
//  Created by Jinal Patel on 7/26/16.
//  Copyright © 2016 minesh doshi. All rights reserved.
//

import UIKit

extension UIView
{
    
    //MARK:- Add Shadow to View
//    func addShadow(shadowColor: UIColor = .customShadow, shadowOpacity: Float = 0.4, shadowRadius: CGFloat? = nil, shadowOffset: CGSize = .zero)
//    {
//        self.layer.shadowColor = shadowColor.cgColor
//        self.layer.masksToBounds = false
//        self.layer.shadowOffset = shadowOffset
//        self.layer.shadowOpacity = shadowOpacity
//        if let getShadowRadius = shadowRadius {
//            self.layer.shadowRadius = getShadowRadius
//        }
//    }
    
    func shake(withDuration: CFTimeInterval = 0.6) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = withDuration
        animation.values = [-20, 20, -20, 20, -10, 10, -5, 5, 0]
        self.layer.add(animation, forKey: "shake")
    }
    
    //MARK:- Load Nib / Xib File
    public class func loadNib() -> Self {
        return Bundle.main.loadNibNamed(className, owner: nil, options: nil)![0] as! Self
    }
    
    //Hide Keyboard
    func hideKeyBoard() {
        UIApplication.shared.sendAction(#selector(resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    class func hideKeyBoard() {
        (UIApplication.shared.delegate as? AppDelegate)?.window?.hideKeyBoard()
    }
    
    class func makeNoRecordFoundViewWithPullToRefresh(frame: CGRect, msg: String) -> UIView
    {
        let viewRefresh = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        viewRefresh.translatesAutoresizingMaskIntoConstraints = true
        viewRefresh.backgroundColor = .clear
        
        let imgPullToRefresh = UIImageView(image: UIImage.ic_pull_to_refresh)
        imgPullToRefresh.translatesAutoresizingMaskIntoConstraints = true
        imgPullToRefresh.frame = CGRect(x: 0, y: 0, width: 37, height: 37)
        imgPullToRefresh.center = viewRefresh.center
        viewRefresh.addSubview(imgPullToRefresh)
        
        let lblNoRecord = UILabel()
        lblNoRecord.tag = 100
        lblNoRecord.translatesAutoresizingMaskIntoConstraints = true
        viewRefresh.addSubview(lblNoRecord)
        //Condition to check internet connection left.
        lblNoRecord.text = msg
        
        lblNoRecord.textColor = .black
        lblNoRecord.textAlignment = .center
        lblNoRecord.numberOfLines = 0
        lblNoRecord.font = .regularSystemFont(withSize: .value)
        lblNoRecord.frame = CGRect(x: 10, y: imgPullToRefresh.frame.origin.y - lblNoRecord.frame.size.height - 10, width: SCREEN_WIDTH - 20, height: lblNoRecord.frame.size.height)
        lblNoRecord.sizeToFit()
        lblNoRecord.frame = CGRect(x: 20, y: imgPullToRefresh.frame.origin.y - lblNoRecord.frame.size.height - 10, width: SCREEN_WIDTH - 40, height: lblNoRecord.frame.size.height)
        lblNoRecord.center = CGPoint(x: viewRefresh.center.x, y: lblNoRecord.center.y)
        
        let lblPullDown = UILabel()
        lblPullDown.translatesAutoresizingMaskIntoConstraints = true
        viewRefresh.addSubview(lblPullDown)
        
        lblPullDown.textColor = .customBlack
        lblPullDown.textAlignment = .center
        lblPullDown.numberOfLines = 0
        lblPullDown.font = .regularSystemFont(withSize: .value)
        lblPullDown.sizeToFit()
        lblPullDown.frame = CGRect(x: 10, y: imgPullToRefresh.frame.origin.y + imgPullToRefresh.frame.size.height + 10, width: SCREEN_WIDTH - 20, height: 30)
        
        lblPullDown.center = CGPoint(x: viewRefresh.center.x, y: lblPullDown.center.y)
        
        return viewRefresh
    }
    
    class func makeNoRecordFoundView(frame: CGRect, msg: String) -> UIView
    {
        let viewRefresh = UIView(frame: CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: frame.size.height))
        viewRefresh.translatesAutoresizingMaskIntoConstraints = true
        viewRefresh.backgroundColor = .clear
        
        let lblNoRecord = UILabel()
        lblNoRecord.tag = 100
        lblNoRecord.translatesAutoresizingMaskIntoConstraints = true
        viewRefresh.addSubview(lblNoRecord)
        //Condition to check internet connection left.
        lblNoRecord.text = msg
        
        lblNoRecord.textColor = .customBlack
        lblNoRecord.textAlignment = .center
        lblNoRecord.numberOfLines = 0
        lblNoRecord.font = .regularSystemFont(withSize: .value)
        lblNoRecord.frame = CGRect(x: 10, y: 10, width: SCREEN_WIDTH - 20, height: viewRefresh.frame.size.height - 20)
        lblNoRecord.sizeToFit()
        lblNoRecord.frame = CGRect(x: 20, y: 20, width: SCREEN_WIDTH - 40, height: viewRefresh.frame.size.height - 40)
        lblNoRecord.center = CGPoint(x: viewRefresh.center.x, y: lblNoRecord.center.y)
        
        return viewRefresh
    }
    
    func addVibrancyEffect(withEffect: UIBlurEffect.Style = .light, bringSubViewToFrontView view: UIView)
    {
        let viewBlurr = UIView(frame: self.frame)
        self.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: withEffect)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        self.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: self.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: self.widthAnchor),
            ])
        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyView.translatesAutoresizingMaskIntoConstraints = false
        vibrancyView.contentView.addSubview(viewBlurr)
        blurView.contentView.addSubview(vibrancyView)
        NSLayoutConstraint.activate([
            vibrancyView.heightAnchor.constraint(equalTo: blurView.contentView.heightAnchor),
            vibrancyView.widthAnchor.constraint(equalTo: blurView.contentView.widthAnchor),
            vibrancyView.centerXAnchor.constraint(equalTo: blurView.contentView.centerXAnchor),
            vibrancyView.centerYAnchor.constraint(equalTo: blurView.contentView.centerYAnchor)
            ])
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: vibrancyView.contentView.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: vibrancyView.contentView.centerYAnchor),
            ])
        self.addSubview(viewBlurr)
        
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: viewBlurr.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: viewBlurr.centerYAnchor)
            ])
        self.bringSubviewToFront(view)
    }
    
    public enum CornerRadiusType {
        case byHeight
        case byWidth
        case automatic
    }
    
    func setFullCornerRadius(type : CornerRadiusType = .automatic, borderColor : UIColor = .clear, borderWidth : CGFloat = 0) {
        self.layoutIfNeeded()
        self.layer.masksToBounds = true
        
        var getSize : CGFloat {
            switch type{
            case .byHeight: return self.frame.height
            case .byWidth: return self.frame.width
            case .automatic: return min(self.frame.height, self.frame.width)
            }
        }
        
        self.layer.cornerRadius = getSize / 2
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.clipsToBounds = true
    }
    
//    func setCustomCornerRadius(radius : CGFloat, borderColor : UIColor = .clear, borderWidth : CGFloat = 0) {
//        self.layer.masksToBounds = true
//        self.layer.cornerRadius = radius
//        self.layer.borderWidth = borderWidth
//        self.layer.borderColor = borderColor.cgColor
//        self.clipsToBounds = true
//    }
//    
    //MARK:- Round Corners Specified
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func removeBorder() {
        if let _sublayers = self.layer.sublayers {
            for _layer in _sublayers {
                if _layer.name == "UIView_custom_addBorder" {
                     _layer.removeFromSuperlayer()
                }
            }
        }
    }
    
    func addBorder(withColor: UIColor, borderWidth: CGFloat = 1, borderTypes: UIRectEdge) {
        self.removeBorder()
        self.layoutIfNeeded()
        self.layer.masksToBounds = true
        
        if borderTypes.contains(.all) {
            self.layer.borderColor = withColor.cgColor
            self.layer.borderWidth = borderWidth
        } else {
            if borderTypes.contains(.top) {
                let border = CALayer()
                border.name = "UIView_custom_addBorder"
                border.borderColor = withColor.cgColor
                border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: borderWidth)
                border.borderWidth = borderWidth
                self.layer.addSublayer(border)
            }
            if borderTypes.contains(.left) {
                let border = CALayer()
                border.name = "UIView_custom_addBorder"
                border.borderColor = withColor.cgColor
                border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: self.frame.height)
                border.borderWidth = borderWidth
                self.layer.addSublayer(border)
            }
            if borderTypes.contains(.right) {
                let border = CALayer()
                border.name = "UIView_custom_addBorder"
                border.borderColor = withColor.cgColor
                border.frame = CGRect(x: 0, y: 0, width: self.frame.width - borderWidth, height: self.frame.height)
                border.borderWidth = borderWidth
                self.layer.addSublayer(border)
            }
            if borderTypes.contains(.bottom) {
                let border = CALayer()
                border.name = "UIView_custom_addBorder"
                border.borderColor = withColor.cgColor
                border.frame = CGRect(x: 0, y: self.frame.height - borderWidth, width: self.frame.width, height: self.frame.height)
                border.borderWidth = borderWidth
                self.layer.addSublayer(border)
            }
        }
    }
    
    
    func removeDashedBorder() {
        if let _sublayers = self.layer.sublayers {
            for _layer in _sublayers {
                if _layer.name == "DashedBorderLine" {
                     _layer.removeFromSuperlayer()
                }
            }
        }
    }
    
    func addDashedBorder(withColor: UIColor = .gray, lineWidth: CGFloat = 1, dashPattern: [NSNumber]? = [3, 2], cornerRadius: CGFloat? = nil) {
        
        removeDashedBorder()
        
        let color = withColor.cgColor
        let shapeLayer: CAShapeLayer = CAShapeLayer()
        shapeLayer.name = "DashedBorderLine"
        let frameSize = bounds.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)

        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = dashPattern
        
        if let radius = cornerRadius {
            shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: radius).cgPath
        }

        self.layer.addSublayer(shapeLayer)
    }
    
    func addDashedBorderMutablePath(withColor: UIColor = .gray, lineWidth: CGFloat = 1, dashPattern: [NSNumber]? = [3, 2]) {
        
        self.layoutIfNeeded()
        
        removeDashedBorder()
        let lineLayer = CAShapeLayer()
        lineLayer.name = "DashedBorderLine"
        lineLayer.strokeColor = withColor.cgColor
        lineLayer.lineWidth = lineWidth
        lineLayer.lineDashPattern = dashPattern
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 0, y: 0),
                                CGPoint(x: self.frame.width, y: 0)])
        lineLayer.path = path
        self.layer.addSublayer(lineLayer)
    }
    
    func createDottedLine(width: CGFloat, color: UIColor) {
        self.layoutIfNeeded()
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        // passing an array with the values [2,3] sets a dash pattern that alternates between a 2-user-space-unit-long painted segment and a 3-user-space-unit-long unpainted segment
        shapeLayer.lineDashPattern = [5,5]
        
        let path = CGMutablePath()
        
        path.addLines(between: [CGPoint(x: 0, y: self.frame.height / 2),
                                CGPoint(x: self.frame.width, y: self.frame.height / 2)])
        shapeLayer.path = path
        
        layer.addSublayer(shapeLayer)

    }
    
    
    @discardableResult
    func addConstraint(topAnchr: NSLayoutYAxisAnchor?, leftAnchr: NSLayoutXAxisAnchor?, rightAnchr: NSLayoutXAxisAnchor?, bottomAnchr: NSLayoutYAxisAnchor?, padding: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        var anchors : [NSLayoutConstraint] = []
        
        if let getAnchor = topAnchr {
            anchors.append(self.topAnchor.constraint(equalTo: getAnchor, constant: padding.top))
        }
        if let getAnchor = leftAnchr {
            anchors.append(self.leftAnchor.constraint(equalTo: getAnchor, constant: padding.left))
        }
        if let getAnchor = rightAnchr {
            anchors.append(self.rightAnchor.constraint(equalTo: getAnchor, constant: padding.right))
        }
        if let getAnchor = bottomAnchr {
            anchors.append(self.bottomAnchor.constraint(equalTo: getAnchor, constant: padding.bottom))
        }
        
        anchors.forEach({ $0.isActive = true })
        
        return anchors
    }
    
    @discardableResult
    func setHeightWidth(setHeight: CGFloat?, setWidth: CGFloat?) -> [NSLayoutConstraint] {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        var anchors : [NSLayoutConstraint] = []
        
        if let getValue = setHeight {
            anchors.append(self.heightAnchor.constraint(equalToConstant: getValue))
        }
        
        if let getValue = setWidth {
            anchors.append(self.widthAnchor.constraint(equalToConstant: getValue))
        }
        
        anchors.forEach({ $0.isActive = true })
        
        return anchors
    }
}

extension UIView {
    
    func fullFillOnSuperView(padding: UIEdgeInsets = .zero) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let getSuperView = self.superview {
            [self.topAnchor.constraint(equalTo: getSuperView.topAnchor, constant: padding.top),
             self.leftAnchor.constraint(equalTo: getSuperView.leftAnchor, constant: padding.left),
             self.rightAnchor.constraint(equalTo: getSuperView.rightAnchor, constant: padding.right),
             self.bottomAnchor.constraint(equalTo: getSuperView.bottomAnchor, constant: padding.bottom)].forEach({ $0.isActive = true })
        }
    }
    
}

extension UIView {
    
    // This is the function to get subViews of a view of a particular type
    func subViews<T : UIView>(type : T.Type) -> [T] {
        var all = [T]()
        for view in self.subviews {
            if let aView = view as? T {
                all.append(aView)
            }
        }
        return all
    }
    
    
    /// This is a function to get subViews of a particular type from view recursively. It would look recursively in all subviews and return back the subviews of the type T
    func allSubViewsOf<T : UIView>(type : T.Type) -> [T]{
        var all = [T]()
        func getSubview(view: UIView) {
            if let aView = view as? T {
                all.append(aView)
            }
            guard view.subviews.count > 0 else { return }
            view.subviews.forEach{ getSubview(view: $0) }
        }
        getSubview(view: self)
        return all
    }
}

extension UIView {
    @discardableResult
    func addLineDashedStroke(pattern: [NSNumber]?, radius: CGFloat, color: UIColor) -> CALayer {
        let borderLayer = CAShapeLayer()

        borderLayer.strokeColor = color.cgColor
        borderLayer.lineDashPattern = pattern
        borderLayer.frame = bounds
        borderLayer.fillColor = nil
        borderLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius)).cgPath

        layer.addSublayer(borderLayer)
        return borderLayer
    }
}

extension UIView {

    func takeScreenshot() -> UIImage {        
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

extension UIView {
    
    @discardableResult
    func addRemoveTapGesture(target: Any?, action: Selector?) -> UITapGestureRecognizer {
        
        let unique_key = "UIView_addRemoveTapGesture_cutom"
        
        self.isUserInteractionEnabled = true
        
        let gst = self.gestureRecognizers
        gst?.forEach({
            if $0.accessibilityHint == unique_key {
                self.removeGestureRecognizer($0)
            }
        })
        
        let tapGst = UITapGestureRecognizer(target: target, action: action)
        tapGst.accessibilityHint = unique_key
        self.addGestureRecognizer(tapGst)
        return tapGst
    }
    
}


//class RoundedGradientView: GradientView {
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        self.layer.masksToBounds = true
//        
//        let getSize : CGFloat = min(self.frame.height, self.frame.width)
//        self.layer.cornerRadius = getSize / 2
//    }
//    
//}

class RoundedView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.masksToBounds = true
        
        let getSize : CGFloat = min(self.frame.height, self.frame.width)
        self.layer.cornerRadius = getSize / 2
    }
    
}
