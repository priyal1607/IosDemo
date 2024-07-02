//
//  CollectionViewCell.swift
//  loginDemo
//
//  Created by Chelsi on 27/04/23.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

  
    @IBOutlet var Colview: UIView!
    @IBOutlet var lblName: UILabel!
    @IBOutlet weak var CollectionImageView: UIImageView!
    let model :DashboardModel! = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.asyncAfter(deadline:.now()+0.1)  {
            self.Colview.setCustomCornerRadius(radius: 20)
//            self.Colview.addShadow()
            self.layer.masksToBounds = false
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOpacity = 0.2
            self.layer.shadowOffset = CGSize(width: 0, height: 2)
            self.layer.shadowRadius = 4
            
        }


    }
    
    
    
    
    
    
    
//    @IBAction func DetailsBtnAction(_ sender: UIButton) {
//        let storyboard = UIStoryboard(name: "DetailsStoryboard", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier:"DetailsViewController" ) as! DetailsViewController
//        vc.model =
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
    func configureCell(data:DashboardModel){
        CollectionImageView.image = UIImage(named: data.image)
        lblName.text = data.name
        
    }
    func configureCell1(data:DetailsDoc){
        CollectionImageView.image = UIImage(named: data.docImg)
        lblName.text = data.docName
        
    }
}

