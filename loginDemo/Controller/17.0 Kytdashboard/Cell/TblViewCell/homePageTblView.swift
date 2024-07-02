//
//  homePageTblView.swift
//  loginDemo
//
//  Created by Priyal on 11/09/23.
//

import UIKit

class homePageTblView: UITableViewCell {
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var collViewHeight: NSLayoutConstraint!
    @IBOutlet weak var collView: UICollectionView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    var mandirListData: [MandirItemModel] = []
    var type: MandirCollViewType = .none
    var imgURL : String  = ""
    var bannerDataSourceDelegate : bannerDataSourceDelegate!
    var arr : [MandirItemModel] = []
    override func awakeFromNib() {
        super.awakeFromNib()
       
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func addObserver(){
        collView.addObserver(self, forKeyPath: "contentSize", options: [.old,.new], context: nil )

    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        collViewHeight.constant = collView.contentSize.height + 10
    }
    private func setupCollView() {
        if bannerDataSourceDelegate == nil {
            bannerDataSourceDelegate = .init(arrData: mandirListData, delegate: self, scrl: collView, type: self.type)
        } else {
            bannerDataSourceDelegate.reloadData(arrData: mandirListData, type: self.type)
        }
    }
    func cellData(data: [MandirItemModel], type: MandirCollViewType) {
        self.mandirListData = data
        self.type = type
        
        switch type {
        case .banner(padding: _, minimumLineSpace: _, minimumInteritemSpace: _):
            self.collViewHeight.constant = 250
        case .shorts(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
            self.collViewHeight.constant = 170
        case .trendingArticles(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
            self.collViewHeight.constant = SCREEN_WIDTH/3.5 * 1.5
        case .photos(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
            self.collViewHeight.constant = 200
        case .otherCell(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
            break
        case .verticalCell(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
            addObserver()
        case .mantras(padding: let padding, minimumLineSpace: let minimumLineSpace, minimumInteritemSpace: let minimumInteritemSpace):
            collView.setCustomCornerRadius(radius: 10)
            addObserver()
        case .none:
            break
        
        }
        setupCollView()
    }
}
extension homePageTblView : ColViewDelegate {
    
}
