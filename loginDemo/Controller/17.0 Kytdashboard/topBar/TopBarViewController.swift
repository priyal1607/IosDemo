//
//  BottomBarViewController.swift
//  MEAIndia
//
//  Created by MacOS on 13/07/22.
//

import UIKit

extension UIViewController {
    var topBarViewController: TopBarViewController? {
        var parentResponder: UIViewController? = self
        while parentResponder != nil {
            if let viewController = parentResponder as? TopBarViewController {
                return viewController
            }
            parentResponder = parentResponder?.parent
        }
        return nil
    }
}

extension UIView {
    var topBarViewController: TopBarViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            if let viewController = parentResponder as? UIViewController {
                return viewController.topBarViewController
            }
            parentResponder = parentResponder?.next
        }
        return nil
    }
}

final class TopBarViewController : UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomStackView: UIStackView!
    @IBOutlet weak var anchorBottomStackViewHeight: NSLayoutConstraint!
    
    //MARK: - Variables
    
    public private(set) var bottomBarHeight: CGFloat = IS_IPAD ? 75 : 65
    public private(set) var viewControllers: [UIViewController] = []
    public private(set) var viewControllerTitles: [String] = []
    public private(set) var selectedIndex: Int = 0
    
    public var selectedViewController: UIViewController? {
        get {
            self.pageViewController?.viewControllers?.first
        }
    }
    
    public private(set) var pageViewController: UIPageViewController!
    
    
    public var selectedImageTintColor: UIColor = .red//.darkMode_bottomBarSelectedTintColor
    public var unSelectedImageTintColor: UIColor = .red //.darkMode_bottomBarUnSelectedTintColor
    
    //MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageViewController.view.backgroundColor = .white
        
        self.bottomBarHeight = TopStackContainerView.viewHeightSizeReturn()
        self.setupView()
        self.setupController()
        NotificationCenter.default.addObserver(self, selector: #selector(languageChangedCallBack), name: .languageChanged, object: nil)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if isDarkModeAppearance {
            self.bottomView.addShadow(shadowColor: .clear, shadowOpacity: 0.3, shadowRadius: 0, shadowOffset: .zero)
        } else {
            self.bottomView.addShadow(shadowColor: .black, shadowOpacity: 0.3, shadowRadius: 10, shadowOffset: .init(width: 0, height: 5))
        }
    }
    
    
    //MARK: - Public Methods
    
    public func setSelectedIndex(_ sIndex: Int) {
        self.changeViewControllerIndex(index: sIndex)
    }
    
    //MARK: - Private Methods
    
    private func setupView() {
        self.mainView.backgroundColor = .white//.darkMode_bottomBarWhiteBackground
        self.anchorBottomStackViewHeight.constant = self.bottomBarHeight
        self.view.layoutIfNeeded()
        self.bottomView.backgroundColor = .white //.darkMode_bottomBarWhiteBackground
        if isDarkModeAppearance {
            self.bottomView.addShadow(shadowColor: .clear, shadowOpacity: 0.3, shadowRadius: 0, shadowOffset: .zero)
        } else {
            self.bottomView.addShadow(shadowColor: .black, shadowOpacity: 0.3, shadowRadius: 10, shadowOffset: .init(width: 0, height: -5))
        }
        
    }
    
    @objc private func languageChangedCallBack() {
        self.bottomStackView.subviews.enumerated().forEach({
            ($0.element as? TopStackContainerView)?.lblTitle.text = viewControllerTitles[$0.offset].localizedString
        })
    }
    
    func setupController(setVCsTitles: [(vc: UIViewController, vcTitle: String)] = []) {
        
        if setVCsTitles.count > 0 {
            self.viewControllers = setVCsTitles.map({ $0.vc })
            self.viewControllerTitles = setVCsTitles.map({ $0.vcTitle })
        } else {
            self.viewControllers = [UIViewController()]
            self.viewControllerTitles = ["Mandir","genre"]
        }
        
        self.bottomStackView.subviews.forEach({ $0.removeFromSuperview() })
       
        self.bottomStackView.isLayoutMarginsRelativeArrangement = true
        self.bottomStackView.distribution = .fill
        
        self.bottomStackView.spacing = 10
        self.bottomStackView.layoutMargins = .init(top: 0, left: 10, bottom: 0, right: 10)
        
        
        self.viewControllers.enumerated().forEach({
            
            let itemView = TopStackContainerView.loadNib()
            itemView.lblTitle.text = self.viewControllerTitles[$0.offset].localizedString
            itemView.lblTitle.textColor = self.selectedImageTintColor

            itemView.btnView.tag = $0.offset
            itemView.btnView.addTarget(self, action: #selector(btnViewClicked), for: .touchUpInside)
            
            self.bottomStackView.addArrangedSubview(itemView)
            
        })
        
        if !viewControllers.indices.contains(selectedIndex) {
            selectedIndex = 0
        }
        
        pageViewController.setViewControllers([self.viewControllers[selectedIndex]], direction: .forward, animated: true)
        
        self.changeTopStackContainerViewSelected()
        
        if pageViewController.dataSource == nil {
            pageViewController.dataSource = self
            pageViewController.delegate = self
            
            self.addChild(self.pageViewController)
            self.mainView.addSubview(self.pageViewController.view)
            addConstraints(toVC: self.pageViewController)
            self.pageViewController.didMove(toParent: self)
            
        }
        
//        changeViewControllerIndex(index: 0)
    }
    
    @objc private func btnViewClicked(_ sender: UIButton) {
        self.changeViewControllerIndex(index: sender.tag)
        let buttonFrame = sender.superview!.convert(sender.frame, to: self.scrollView)
        self.scrollView.scrollRectToVisible(buttonFrame, animated: true)

    }
    
    private func changeViewControllerIndex(index: Int) {
        if self.viewControllers.indices.contains(index),
           self.selectedIndex != index {
            
//            if self.selectedIndex > -1 {
//                self.removeOldController()
//            }
//            self.addNewController()
            
            if index < self.selectedIndex && index != 0 {
                self.pageViewController.setViewControllers([self.viewControllers[index]], direction: .reverse, animated: true, completion: nil)
            } else if index > self.selectedIndex {
                self.pageViewController.setViewControllers([self.viewControllers[index]], direction: .forward, animated: true, completion: nil)
            }
            
            selectedIndex = index
            self.changeTopStackContainerViewSelected()
                   
//            self.currentPageIndex = index
//            self.pageViewController.set
            
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
    
    private func changeTopStackContainerViewSelected() {
        self.bottomStackView.subviews.enumerated().forEach({
            ($0.element as? TopStackContainerView)?.lblTitle.textColor = $0.offset == self.selectedIndex ? self.selectedImageTintColor : self.unSelectedImageTintColor
            ($0.element as? TopStackContainerView)?.isSelected(isSelected: $0.offset == self.selectedIndex)
        })
    }
    
    /*
    private func addNewController() {
        self.bottomStackView.subviews.enumerated().forEach({
            ($0.element as? TopStackContainerView)?.lblTitle.textColor = $0.offset == self.selectedIndex ? self.selectedImageTintColor : self.unSelectedImageTintColor
            ($0.element as? TopStackContainerView)?.isSelected(isSelected: $0.offset == self.selectedIndex)
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
    
    */
    
    private func addConstraints(toVC: UIViewController) {
        toVC.view.translatesAutoresizingMaskIntoConstraints = false
        toVC.view.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor).isActive = true
        toVC.view.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor).isActive = true
        toVC.view.topAnchor.constraint(equalTo: self.mainView.topAnchor).isActive = true
        toVC.view.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor).isActive = true
    }
    
    
}


extension TopBarViewController : UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let index = self.viewControllers.firstIndex(of: viewController) else { return nil }
        
        if index == 0 {
            return nil
        }
        
        let count = self.viewControllers.count
        
        let prevIndex = (index - 1) < 0 ? count - 1 : index - 1
        
        let pageContentViewController = self.viewControllers[prevIndex]
        
        return pageContentViewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = self.viewControllers.firstIndex(of: viewController) else { return nil }
        
        let count = self.viewControllers.count
        
        if index == (count - 1) {
            return nil
        }
        
        let nextIndex = (index + 1) >= count ? 0 : index + 1
        
        let pageContentViewController = self.viewControllers[nextIndex]
        
        return pageContentViewController
    }
    
    /*
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.viewControllers.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return self.selectedIndex
    }
    */
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let vc = pageViewController.viewControllers?.first, let index = self.viewControllers.firstIndex(of: vc) else { return }
        
        self.selectedIndex = index
//        if (finished) {
//
//        } else {
//            self.selectedIndex = index
//        }
//        self.selectedViewController =
        self.changeTopStackContainerViewSelected()
        
        guard let btn = (self.bottomStackView.subviews[index] as? TopStackContainerView)?.btnView else { return }
        
        let buttonFrame = btn.superview!.convert(btn.frame, to: self.scrollView)
        self.scrollView.scrollRectToVisible(buttonFrame, animated: true)
        
    }
    
}
