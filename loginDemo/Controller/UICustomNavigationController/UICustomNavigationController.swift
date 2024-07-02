//
//  UICustomNavigationController.swift
//  ASI
//
//  Created by Vikram Jagad on 07/08/20.
//  Copyright © 2020 Silvertouch. All rights reserved.
//

import UIKit

class UICustomNavigationController : UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        configNavigationBar()
        updateGraedint()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        updateGraedint()
    }
    
    private let gradientColors : [UIColor] = [.init(hexStringToUIColor: "#1F1D4D"), .init(hexStringToUIColor: "#1F1D4D")]

    private let gradientLocation: [NSNumber] = [0.0, 1.0]
    
    private func updateGraedint() {
        navigationBar.setGradientBackground(colors: gradientColors, startPoint: .custom(point: .init(x: 0.07, y: 0.75)), endPoint: .custom(point: .init(x: 0.94, y: 0.25)), locations: gradientLocation)
    }
    
    private func configNavigationBar() {
        navigationBar.barStyle = .default
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
        
        navigationBar.tintColor = UIColor.white
        navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.semibold)]
    }
}


class UINavigationBarGradientView: UIView {

    enum Point {
        case topRight, topLeft
        case bottomRight, bottomLeft
        case custom(point: CGPoint)

        var point: CGPoint {
            switch self {
            case .topRight: return CGPoint(x: 1.0, y: 0.0)
            case .topLeft: return CGPoint(x: 0.0, y: 0.0)
            case .bottomRight: return CGPoint(x: 1.0, y: 1.0)
            case .bottomLeft: return CGPoint(x: 0.0, y: 1.0)
            case .custom(let point): return point
            }
        }
    }

    private weak var navBarGradientLayer: CAGradientLayer!

    convenience init(colors: [UIColor], startPoint: Point = .topLeft,
                     endPoint: Point = .bottomLeft, locations: [NSNumber] = [0, 1]) {
        self.init(frame: .zero)
        let navBarGradientLayer = CAGradientLayer()
        navBarGradientLayer.frame = frame
        layer.addSublayer(navBarGradientLayer)
        self.navBarGradientLayer = navBarGradientLayer
        set(colors: colors, startPoint: startPoint, endPoint: endPoint, locations: locations)
        backgroundColor = .clear
    }

    func set(colors: [UIColor], startPoint: Point = .topLeft,
             endPoint: Point = .bottomLeft, locations: [NSNumber] = [0, 1]) {
        navBarGradientLayer.colors = colors.map { $0.cgColor }
        navBarGradientLayer.startPoint = startPoint.point
        navBarGradientLayer.endPoint = endPoint.point
        navBarGradientLayer.locations = locations
    }

    func setupConstraints() {
        guard let parentView = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: parentView.topAnchor).isActive = true
        leftAnchor.constraint(equalTo: parentView.leftAnchor).isActive = true
        parentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        parentView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        guard let navBarGradientLayer = navBarGradientLayer else { return }
        navBarGradientLayer.frame = frame
        superview?.addSubview(self)
    }
}

extension UINavigationBar {
    func setGradientBackground(colors: [UIColor],
                               startPoint: UINavigationBarGradientView.Point = .topLeft,
                               endPoint: UINavigationBarGradientView.Point = .bottomLeft,
                               locations: [NSNumber] = [0, 1]) {
        guard let backgroundView = value(forKey: "backgroundView") as? UIView else { return }
        guard let gradientView = backgroundView.subviews.first(where: { $0 is UINavigationBarGradientView }) as? UINavigationBarGradientView else {
            let gradientView = UINavigationBarGradientView(colors: colors, startPoint: startPoint,
                                                           endPoint: endPoint, locations: locations)
            backgroundView.addSubview(gradientView)
            gradientView.setupConstraints()
            return
        }
        gradientView.set(colors: colors, startPoint: startPoint, endPoint: endPoint, locations: locations)
    }
}
