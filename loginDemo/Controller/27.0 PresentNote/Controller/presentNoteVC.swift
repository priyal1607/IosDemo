//
//  presentNoteVC.swift
//  loginDemo
//
//  Created by Priyal on 05/10/23.
//

import UIKit

class presentNoteVC: UIViewController {

    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var txtView: PlaceHolderTextView!
    var updateAddNotesCalled : ((String) -> Void)?
    var previousRect = CGRect.zero
    var isEdit : Bool = false
    var note : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        txtView.delegate = self
        btnAdd.setCustomCornerRadius(radius: 10)
        txtView.setCustomCornerRadius(radius: 10 , borderColor: .lightGray , borderWidth: 2)
        txtView.text = note
        setupView()

        // Do any additional setup after loading the view.
    }
    
    func setupView(){
        if !isEdit {
            lblType.text = "Add"
        } else {
            lblType.text = "Update"
        }
    }
    

    @IBAction func btnAddAction(_ sender: UIButton) {
        if (getString(anything: txtView.text).is_trimming_WS_NL_to_String ?? "").isStringEmpty {
            Global.shared.showBanner(message: "Add Notes Messages")
        } else {
            updateAddNotesCalled?(getString(anything: txtView.text))
            txtView.resignFirstResponder()
            self.dismiss(animated: true)
        }
    }

    
}
extension presentNoteVC  : UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        let pos = textView.endOfDocument
        let currentRect = textView.caretRect(for: pos)
        if(currentRect.origin.y > previousRect.origin.y) {
            print(currentRect.origin.y)
            if currentRect.origin.y > 50 {
                //self.setSlideInPresentationController(ratio: self.scrollView.subviews.first!, maxRatio: self.ratio)
            }
        }
        previousRect = currentRect
    }
    
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        //self.scrollView.isScrollEnabled = false
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        //self.scrollView.isScrollEnabled = true
    }
}

