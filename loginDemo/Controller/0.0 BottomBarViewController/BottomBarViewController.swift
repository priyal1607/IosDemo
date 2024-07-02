//
//  BottomBarViewController.swift
//  MEAIndia
//
//  Created by MacOS on 13/07/22.
//

import UIKit

extension UIViewController {
    var bottomBarViewController: BottomBarViewController? {
        var parentResponder: UIViewController? = self
        while parentResponder != nil {
            if let viewController = parentResponder as? BottomBarViewController {
                return viewController
            }
            parentResponder = parentResponder?.parent
        }
        return nil
    }
}

extension UIView {
    var bottomBarViewController: BottomBarViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            if let viewController = parentResponder as? UIViewController {
                return viewController.bottomBarViewController
            }
            parentResponder = parentResponder?.next
        }
        return nil
    }
}

final class BottomBarViewController : UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bottomStackView: UIStackView!
    @IBOutlet weak var anchorBottomStackViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var viewMusic: UIView!
    //MARK: - Variables
    
    public private(set) var bottomBarHeight: CGFloat = IS_IPAD ? 75 : 65
    public private(set) var viewControllers: [UIViewController] = []
    public private(set) var viewControllerTitles: [String] = []
    public private(set) var selectedViewController: UIViewController?
    public private(set) var selectedIndex: Int = -1

    public var bottomBarIsHidded: Bool {
        return self.bottomView.isHidden
    }
    
    public var selectedImageTintColor: UIColor = .bottomBarSelectedTintColor
    public var unSelectedImageTintColor: UIColor = .bottomBarUnSelectedTintColor
    
    private let shaodowLayer = CALayer()

    //MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        self.setupController()
        NotificationCenter.default.addObserver(self, selector: #selector(languageChangedCallBack), name: Notification.Name("languageChanged"), object: nil)
        
        if let appdele = appDelegate {
            self.viewMusic.addSubview(appdele.viewMusic)
            appdele.viewMusic.fullFillOnSuperView()
            appdele.viewMusic.btnCancel.addTarget(self, action: #selector(self.hideBottomMusicController), for: .touchUpInside)
            appdele.viewMusic.btnFullView.addTarget(self, action: #selector(self.showList), for: .touchUpInside)
            self.viewMusic.hero.id = MusicVC.fullScreenIdentifier
        }
//        viewMusic.translatesAutoresizingMaskIntoConstraints = false
//               NSLayoutConstraint.activate([
//                   viewMusic.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//                   viewMusic.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
//               ])
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if isDarkModeAppearance {
            self.bottomView.addShadow(shadowColor: .clear, shadowOpacity: 0.3, shadowRadius: 0, shadowOffset: .zero)
            self.shaodowLayer.shadowColor = UIColor.white.cgColor
        } else {
            self.shaodowLayer.shadowColor = UIColor.clear.cgColor
            self.bottomView.addShadow(shadowColor: .black, shadowOpacity: 0.3, shadowRadius: 10, shadowOffset: .init(width: 0, height: -5))
        }
    }
    
    
    //MARK: - Public Methods
    
    public func setBottomBarView(isHidden: Bool, animated: Bool = false) {
        guard isHidden != self.bottomView.isHidden else { return }
        
        if animated {
            if !isHidden {
                self.bottomStackView.subviews.forEach({ $0.alpha = 0 })
            }
            
            UIView.transition(with: self.bottomView, duration: 0.3, options: .curveEaseInOut) { [weak self] in
                self?.bottomView?.isHidden = isHidden
            } completion: { [weak self] _ in
                guard let `self` = self else { return }
                
                UIView.animate(withDuration: 0.25, delay: 0, animations: { [weak self] in
                    self?.bottomStackView?.subviews.forEach({ $0.alpha = 0.5 })
                }, completion: { [weak self] _ in
                    self?.bottomStackView?.subviews.forEach({ $0.alpha = 1 })
                })
                
            }
        } else {
            self.bottomView.isHidden = isHidden
            self.view.layoutIfNeeded()
        }
        
    }
    @objc func hideBottomMusicController() {
        self.viewMusic.tag = 1
        self.viewMusic.isHidden = true
    }
    public func setSelectedIndex(_ sIndex: Int) {
        self.changeViewControllerIndex(index: sIndex)
    }
    @objc func showList() {
        let dVC = getMusicPlayerdVC()
        dVC.isFromPresentMenu = true
        dVC.modalPresentationStyle = .fullScreen
        self.present(dVC, animated: true)
    }
    
    //MARK: - Private Methods
    
    private func setupView() {
        self.mainView.backgroundColor = .darkMode_bottomBarWhiteBackground
        self.anchorBottomStackViewHeight.constant = self.bottomBarHeight
        self.view.layoutIfNeeded()
        self.bottomView.backgroundColor = .darkMode_bottomBarWhiteBackground
        
//        let shadowWidth = SCREEN_WIDTH * 0.776
//        shaodowLayer.shadowRadius = 0
//        shaodowLayer.shadowOpacity = 0.67
//        shaodowLayer.shadowOffset = .zero
//        shaodowLayer.shadowPath = UIBezierPath(ovalIn: CGRect(x: (SCREEN_WIDTH - shadowWidth) / 2.0, y: 0, width: shadowWidth, height: 1)).cgPath
//        self.bottomView.layer.addSublayer(self.shaodowLayer)
        
        
        if isDarkModeAppearance {
            self.bottomView.addShadow(shadowColor: .clear, shadowOpacity: 0.3, shadowRadius: 0, shadowOffset: .zero)
            self.shaodowLayer.shadowColor = UIColor.white.cgColor
        } else {
            self.shaodowLayer.shadowColor = UIColor.clear.cgColor
            self.bottomView.addShadow(shadowColor: .black, shadowOpacity: 0.3, shadowRadius: 10, shadowOffset: .init(width: 0, height: -5))
        }
        
    }
    
    @objc private func languageChangedCallBack() {
        self.bottomStackView.subviews.enumerated().forEach({
            ($0.element as? BottomStackContainerView)?.lblTitle.text = viewControllerTitles[$0.offset]
        })
    }
    
    private func setupController() {
        
        /*let dvc =  CommonWebViewViewCotroller.instantiate(appStoryboard: .commonWebViewScreen)
        dvc.webView_Link_Open_Type = .other(urlString: rtiURL, headerString: "RTI".localizedString)
        
        let dvc_contact =  CommonWebViewViewCotroller.instantiate(appStoryboard: .commonWebViewScreen)
        dvc_contact.webView_Link_Open_Type = .other(urlString: contactUsURL, headerString: "Contact".localizedString)*/
        
        let vcs: [(vc: UIViewController, image: UIImage?)]
        vcs = [(UICustomNavigationController(rootViewController: HomePageVC.instantiate(appStoryboard: .homepage)),
                UIImage(named: "home")),
               (UICustomNavigationController(rootViewController: DashboardVC.instantiate(appStoryboard: .dashboard)),
                UIImage(named: "dashboard")),
               (UICustomNavigationController(rootViewController: CollectionVC.instantiate(appStoryboard: .collectionview)),
                UIImage(named: "Gallery")),
               (UICustomNavigationController(rootViewController: MusicPlayerVC.instantiate(appStoryboard: .musicPlayer)),
                UIImage(named: "Music"))]
        
        self.viewControllers = vcs.map({ $0.vc })
        self.viewControllerTitles = ["Dashboard", "List", "Grid" , "Music"]
        
        self.bottomStackView.subviews.forEach({ $0.removeFromSuperview() })
       
        self.bottomStackView.isLayoutMarginsRelativeArrangement = true
        self.bottomStackView.distribution = .fill

        let totalWidth = (UIScreen.main.bounds.width - (bottomBarHeight * CGFloat(vcs.count)))
        
        if UIScreen.main.bounds.width > totalWidth {
            
            let spacing = totalWidth / CGFloat(vcs.count + 1)
            self.bottomStackView.spacing = spacing
            self.bottomStackView.layoutMargins = .init(top: 0, left: spacing, bottom: 0, right: spacing)
        } else {
            
            self.bottomStackView.spacing = 16
            self.bottomStackView.layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
        }
        
        
        vcs.enumerated().forEach({
            let itemView = BottomStackContainerView.loadNib()
            itemView.imgView.image = $0.element.image?.withRenderingMode(.alwaysTemplate)
            itemView.imgView.tintColor = self.selectedImageTintColor
            itemView.lblTitle.text = viewControllerTitles[$0.offset]
            itemView.lblTitle.textAlignment = .center
            itemView.lblTitle.textColor = self.selectedImageTintColor
//            itemView.bottomView.backgroundColor = self.selectedImageTintColor
            itemView.btnView.tag = $0.offset
            itemView.btnView.addTarget(self, action: #selector(btnViewClicked), for: .touchUpInside)
            
            self.bottomStackView.addArrangedSubview(itemView)
            
            itemView.translatesAutoresizingMaskIntoConstraints = false
            itemView.widthAnchor.constraint(equalToConstant: bottomBarHeight).isActive = true
            
        })
        
        
        changeViewControllerIndex(index: 0)
    }
    
    @objc private func btnViewClicked(_ sender: UIButton) {
        self.changeViewControllerIndex(index: sender.tag)
    }
    
    private func changeViewControllerIndex(index: Int) {
        if self.viewControllers.indices.contains(index),
           self.selectedIndex != index {
            
            if self.selectedIndex > -1 {
                self.removeOldController()
            }
            
            selectedIndex = index
            self.addNewController()
            
        } else if self.selectedIndex == index {
            
            let nVC = self.viewControllers[index].parentNavigationController
            let topScrView = self.viewControllers[index].view.allSubViewsOf(type: UIScrollView.self).first
            
            if let getScrollView = topScrView,
               (getScrollView.contentOffset.x > 0 || getScrollView.contentOffset.y > 0) {
                getScrollView.setContentOffset(.zero, animated: true)
            } else if let getNavagtionVC = nVC,
                      getNavagtionVC.viewControllers.count > 1 {
                getNavagtionVC.popToRootViewController(animated: true)
            }
        }
    }
    
    private func addNewController() {
        self.bottomStackView.subviews.enumerated().forEach({
            ($0.element as? BottomStackContainerView)?.imgView.tintColor = $0.offset == self.selectedIndex ? self.selectedImageTintColor : self.unSelectedImageTintColor
//            ($0.element as? BottomStackContainerView)?.bottomView.backgroundColor = $0.offset == self.selectedIndex ? self.selectedImageTintColor : .clear
            ($0.element as? BottomStackContainerView)?.lblTitle.textColor = $0.offset == self.selectedIndex ? self.selectedImageTintColor : self.unSelectedImageTintColor
            ($0.element as? BottomStackContainerView)?.isSelected(isSelected: $0.offset == self.selectedIndex)
        })
        
        let currentVC = self.viewControllers[self.selectedIndex]
        self.selectedViewController = currentVC
        
        currentVC.willMove(toParent: self)
        addChild(currentVC)
        self.mainView.addSubview(currentVC.view)
        addConstraints(toVC: currentVC)
        currentVC.didMove(toParent: self)
    }
    
    private func removeOldController() {
        let currentVC = self.viewControllers[self.selectedIndex]
        currentVC.willMove(toParent: nil)
        currentVC.removeFromParent()
        currentVC.view.removeFromSuperview()
        currentVC.didMove(toParent: nil)
    }
    
    private func addConstraints(toVC: UIViewController) {
        toVC.view.translatesAutoresizingMaskIntoConstraints = false
        toVC.view.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor).isActive = true
        toVC.view.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor).isActive = true
        toVC.view.topAnchor.constraint(equalTo: self.mainView.topAnchor).isActive = true
        toVC.view.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor).isActive = true
    }
    
    
}
