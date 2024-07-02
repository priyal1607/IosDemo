//
//  pNoteVC.swift
//  loginDemo
//
//  Created by Priyal on 17/10/23.
//

import UIKit

class pNoteVC: UIViewController {

    @IBOutlet weak var lblNote: UILabel!
    var note : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        lblNote.text = note

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnclickClose(_ sender: UIButton) {
        resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
}
