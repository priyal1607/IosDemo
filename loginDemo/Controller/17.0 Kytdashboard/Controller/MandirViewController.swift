//
//  MandirViewController.swift
//  loginDemo
//
//  Created by Priyal on 11/09/23.
//

import UIKit

class MandirViewController: UIViewController {
    fileprivate var delegateDataSource: mandirTblViewDelegate!
    fileprivate var list: [HomePageData] = []
    @IBOutlet weak var tblView: UITableView!
    var webService = HomePageWebService()
    override func viewDidLoad() {
        super.viewDidLoad()
        getList()

        // Do any additional setup after loading the view.
    }
    
    func setupTableView() {
        if delegateDataSource == nil {
            delegateDataSource = .init(arrData: self.list, delegate: self, tbl: self.tblView)
//            delegateDataSource.block_btnTitleImageClicked = self.btnTitleImageClicked
//            delegateDataSource.block_collViewDidSelected = self.collectionViewDidSelected
        } else {
            delegateDataSource.reload(arr: self.list)
        }
    }
   
}
extension MandirViewController : TblViewDelegate {
    
}
extension MandirViewController {
    func getList() {
        webService.getMandirData(block: { list in
            self.list = list
            self.setupTableView()
        })
    }
//    func getList() {
//        CustomActivityIndicator.sharedInstance.showIndicator(view: self.view)
//        self.webService.getList { (list, result) in
//            if result {
//                self.list = list.filter({ $0.list.count > 0 })
//
//                for inx in 0..<self.list.count {
//                    if self.list[inx].viewtype == MandirViewTypes.shorts.rawValue {
//                        for idx in 0..<self.list[inx].list.count {
//                            if self.list[inx].list[idx].avPlayer == nil {
//                                //self.arrBanner[inx].list[idx].addAvplayer()
//                                self.list[inx].list[idx].avPlayer?.automaticallyWaitsToMinimizeStalling = false
//                                self.list[inx].list[idx].avPlayer?.currentItem?.canUseNetworkResourcesForLiveStreamingWhilePaused = true
//                                self.list[inx].list[idx].avPlayer?.currentItem?.preferredForwardBufferDuration = 1.0
//                                self.list[inx].list[idx].avPlayer?.actionAtItemEnd = .none
//                            }
//                        }
//                    }
//
//                }
//
//            }
//            CustomActivityIndicator.sharedInstance.hideIndicator(view: self.view)
//            self.setupTableView()
//        }
//    }
}
