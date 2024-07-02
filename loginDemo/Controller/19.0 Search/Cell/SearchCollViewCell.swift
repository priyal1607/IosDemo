//
//  SearchCollViewCell.swift
//  loginDemo
//
//  Created by Priyal on 21/09/23.
//

import UIKit

class SearchCollViewCell: UICollectionViewCell {

    @IBOutlet weak var imgCancel: UIImageView!
    @IBOutlet weak var btnimgView: UIView!
    @IBOutlet weak var btnCancelView: UIView!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var lblSearch: UILabel!
    var compForward : (() -> ())!
    var btnDeleteClickedCallBack : ((SearchCollViewCell) -> ())?
//    override var intrinsicContentSize: CGSize {
//        return CGSize(width: self.lblSearch.intrinsicContentSize.width + 80.0, height: 50)
//       }
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.setCustomCornerRadius(radius: 10)
        
        // Initialization code
    }

    @IBAction func btnCancelAction(_ sender: UIButton) {
        btnDeleteClickedCallBack?(self)
    }
    
    func configureCell(data : String , arr : [String]){
        btnimgView.isHidden = true
        btnCancelView.isHidden = false
        lblSearch.text = data
        
    }
    func configCellCategory(data : SearchModel){
        lblSearch.text = data.title
        

    }
    func configCellAuthor(data : SearchModel){
        lblSearch.text = data.title
        

    }
}
