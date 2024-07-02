//
//  OnBoardingVC.swift
//  loginDemo
//
//  Created by Priyal on 01/09/23.
//

import UIKit
import CHIPageControl

class OnBoardingVC: UIViewController {

    @IBOutlet weak var btnNext: UIButton!
    
    
    
    @IBOutlet weak var pgControl: CHIPageControlJaloro!
    @IBOutlet weak var collView: UICollectionView!
    var arr : [ String] = ["Stay aligned with panchang","Personalized journey","Discover sanatan temples"]
    var onBoardingDataSource : OnBoardingDataSource!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTbl()
        btnNext.setCustomCornerRadius(radius: btnNext.frame.width/2)
        self.pgControl.numberOfPages = arr.count

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func setUpTbl(){
        if self.onBoardingDataSource == nil {
            self.onBoardingDataSource = .init(arrData: arr, delegate: self, scrl: collView)
        } else {
            self.onBoardingDataSource?.reloadData(arrData: arr)
        }
        setUpPageControl()
    }
    private func setUpPageControl() {
        pgControl.radius = IS_IPAD ? 7.5 : 5
        pgControl.elementWidth = IS_IPAD ? 15 : 10
        pgControl.elementHeight = IS_IPAD ? 15 : 10
        pgControl.numberOfPages = arr.count
//      pgControl.inactiveTransparency = 0.0
        pgControl.borderWidth = 1.0
        pgControl.currentPageTintColor = .customWhite
        pgControl.tintColor = .customWhite
        pgControl.padding = IS_IPAD ? 9 : 6
    }
    
    @IBAction func btnAction(_ sender: UIButton) {
        UserPreferences.set(value: true, forKey: UserPreferencesKeys.General.intro)
        appDelegate?.setUpinitialVc()
    }
}
extension OnBoardingVC : ColViewDelegate {
    func changeCurrentPage(index: Double) {
        pgControl.progress = index
        if index == 2 {
            btnNext.isHidden = false
        } else {
            btnNext.isHidden = true
        }
    }
}
