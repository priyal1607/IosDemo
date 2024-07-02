//
//  PressDetailsVC.swift
//  loginDemo
//
//  Created by Priyal on 03/07/23.
//

import UIKit

class PressDetailsVC: HeaderViewController {
    @IBOutlet weak var gredView: GradientView!
    @IBOutlet weak var contactDetails: UILabel!
    @IBOutlet weak var date: UILabel!
   
    @IBOutlet weak var des: UILabel!
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titleView : UILabel!
    var dictData:PressReleaseResult?
    var imgURL = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpData()
        setUpHeader()

        // Do any additional setup after loading the view.
    }
    func setUpHeader() {
        self.setUpHeaderTitle(strHeaderTitle: "Press Release")
        self.viewHeader.lblHeaderTitle.textColor = .white
        self.gredView.setGradientViewColors(colors:[.custom_top, .custom_bottom])
        self.gredView.setGradientViewStartEndPoint(gradientPoint: .topBottom)
    }
    
    func setUpData(){
        titleView.text = dictData?.title
        contactDetails.text = dictData?.shortDescription
        des.text = dictData?.descriptionField
        date.text = getString(anything: DateConverter.getDateString(aStrDate: dictData?.date, inputFormat: DateFormats.yyyy_MM_dd_T_HH_mm_ss_XXX, outputFormat: DateFormats.dd_MMM_yyyy))
        img.downloadImageWithoutProgress(with: imgURL +  (dictData?.image)!,placeholderImage: UIImage(named: "common_placeholder"))
    }
                                         
}
