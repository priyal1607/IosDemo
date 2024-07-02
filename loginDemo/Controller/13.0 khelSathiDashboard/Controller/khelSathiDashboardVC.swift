//
//  khelSathiDashboardVC.swift
//  loginDemo
//
//  Created by Priyal on 04/07/23.
//

import UIKit

class khelSathiDashboardVC: UIViewController, ColViewDelegate {
    @IBOutlet weak var btnViewAll: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    fileprivate var khelsathiSportsDelegate: khelsathiSportsDelegate!
    fileprivate var khelSathiPagerDelegate: khelSathiPagerDelegate!
    fileprivate var khelSathiCalDelegate: khelSathiCalDelegate!
    fileprivate var khelSathiFacDelegate: khelSathiFacDelegate!
    fileprivate var khelSathiMidDelegate: khelSathiMidDelegate!
    fileprivate var arrsports : [String] = ["Volleyball","Volleyball","Volleyball","Volleyball"]
    fileprivate var arrFac : [String] = ["Volleyball","Volleyball","Volleyball","Volleyball"]
    fileprivate var arrPager : [String] = ["Group 2","Group 2","Group 2","Group 2"]
    fileprivate var arrcal : [String] = ["Group 2","Group 2","Group 2","Group 2","Group 2","Group 2","Group 2","Group 2"]
    fileprivate var arrSportsCal : [String] = ["Volleyball","Volleyball","Volleyball","Volleyball"]
    
    
    @IBOutlet weak var CalHeight: NSLayoutConstraint!
    @IBOutlet weak var topCollView: UICollectionView!
    @IBOutlet weak var healthFac: UICollectionView!
    @IBOutlet weak var midView: UICollectionView!
    @IBOutlet weak var sportsCal: UICollectionView!
    @IBOutlet weak var pagerView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollView()
        setupCollView2()
        setupCollView3()
        setuptimer()
        addObserver()
        setupCollView4()
        setupCollView5()
        self.pageControl.numberOfPages = arrPager.count
        // Do any additional setup after loading the view.
    }
    @objc func startScrolling() {

        if pageControl.currentPage == pageControl.numberOfPages - 1 {
            pageControl.currentPage = 0
        } else {
            pageControl.currentPage += 1
        }
        pagerView.scrollToItem(at: IndexPath(row: pageControl.currentPage, section: 0), at: .right, animated: true)
    }
    func setuptimer() {
      Timer.scheduledTimer(timeInterval: 3, target: self , selector:
    #selector(startScrolling), userInfo: nil, repeats: true)

    }
    func addObserver(){
        midView.addObserver(self, forKeyPath: "contentSize", options: [.old,.new], context: nil )
     

    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let obj = object as? UICollectionView, obj == self.midView {
            CalHeight.constant = midView.contentSize.height + 10
        }
    }
    fileprivate func setupCollView() {
        if self.khelsathiSportsDelegate == nil {
            self.khelsathiSportsDelegate = .init(arrData: arrsports, delegate: self, scrl: topCollView )
        } else {
            self.khelsathiSportsDelegate?.reloadData(arrData: arrsports)
        }
    }
    fileprivate func setupCollView2() {
        if self.khelSathiPagerDelegate == nil {
            self.khelSathiPagerDelegate = .init(arrData: arrsports, delegate: self, scrl: pagerView )
        } else {
            self.khelSathiPagerDelegate?.reloadData(arrData: arrsports)
        }
    }
    fileprivate func setupCollView3() {
        if self.khelSathiCalDelegate == nil {
            self.khelSathiCalDelegate = .init(arrData: arrcal, delegate: self, scrl: midView )
        } else {
            self.khelSathiCalDelegate?.reloadData(arrData: arrcal)
        }
    }
    fileprivate func setupCollView4() {
        if self.khelSathiFacDelegate == nil {
            self.khelSathiFacDelegate = .init(arrData: arrFac, delegate: self, scrl: healthFac )
        } else {
            self.khelSathiFacDelegate?.reloadData(arrData: arrFac)
        }
    }
    
    fileprivate func setupCollView5() {
        if self.khelSathiMidDelegate == nil {
            self.khelSathiMidDelegate = .init(arrData: arrSportsCal, delegate: self, scrl: sportsCal )
        } else {
            self.khelSathiMidDelegate?.reloadData(arrData: arrFac)
        }
    }
}

