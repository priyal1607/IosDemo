//
//  GradientColor.swift
//  MySurat
//
//  Created by Jignesh Ashara on 04/01/18.
//  Copyright © 2018 Jignesh Ashara. All rights reserved.
//

import UIKit

typealias GradientType = (x: CGPoint, y: CGPoint)

enum GradientPoint
{
    case leftRight
    case rightLeft
    case topBottom
    case bottomTop
    case topLeftBottomRight
    case bottomRightTopLeft
    case topRightBottomLeft
    case bottomLeftTopRight
    
    func draw() -> GradientType
    {
        switch self {
        case .leftRight:
            return (x: CGPoint(x: 0, y: 0.5), y: CGPoint(x: 1, y: 0.5))
        case .rightLeft:
            return (x: CGPoint(x: 1, y: 0.5), y: CGPoint(x: 0, y: 0.5))
        case .topBottom:
            return (x: CGPoint(x: 0.5, y: 0), y: CGPoint(x: 0.5, y: 1))
        case .bottomTop:
            return (x: CGPoint(x: 0.5, y: 1), y: CGPoint(x: 0.5, y: 0))
        case .topLeftBottomRight:
            return (x: CGPoint(x: 0, y: 0), y: CGPoint(x: 1, y: 1))
        case .bottomRightTopLeft:
            return (x: CGPoint(x: 1, y: 1), y: CGPoint(x: 0, y: 0))
        case .topRightBottomLeft:
            return (x: CGPoint(x: 1, y: 0), y: CGPoint(x: 0, y: 1))
        case .bottomLeftTopRight:
            return (x: CGPoint(x: 0, y: 1), y: CGPoint(x: 1, y: 0))
        }
    }
}


public class GradientView: UIView {
    
    private var startColor: UIColor = .black
    private var endColor: UIColor = .white
    
    private var startPoint: CGPoint = .zero
    private var endPoint: CGPoint = .zero
    
    private var colors: [UIColor] = []
    private var locations: [NSNumber] = []

    override public class var layerClass: AnyClass { CAGradientLayer.self }

    var gradientLayer: CAGradientLayer { self.layer as! CAGradientLayer }

    func setGradientViewStartEndPoint(gradientPoint: GradientPoint) {
        let drawPoint = gradientPoint.draw()
        
        self.startPoint = drawPoint.x
        self.endPoint = drawPoint.y
        
        self.gradientLayer.startPoint = self.startPoint
        self.gradientLayer.endPoint = self.endPoint
    }
    
    func setStartEndPoint(startPoint: CGPoint, endPoint: CGPoint) {
        self.gradientLayer.startPoint = startPoint
        self.gradientLayer.endPoint = endPoint
    }
    
    func setGradientViewColors(colors: [UIColor]) {
        self.colors = colors
        self.gradientLayer.colors = colors.map({ $0.cgColor })
    }
    
    func updateLocations(locations: [NSNumber]) {
        self.gradientLayer.locations = locations
    }
    
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        self.gradientLayer.startPoint = self.startPoint
        self.gradientLayer.endPoint = self.endPoint
        self.gradientLayer.colors = self.colors.map({ $0.cgColor })
        if self.locations.count > 0 { self.gradientLayer.locations = self.locations }
        
    }

}
