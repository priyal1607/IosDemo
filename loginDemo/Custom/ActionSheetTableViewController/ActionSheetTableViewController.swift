//
//  BusinessCardActionSheetTableViewController.swift
//  SharkID
//
//  Created by Jainesh Lad on 10/11/17.
//  Copyright © 2017 sttl. All rights reserved.
//

import UIKit

class ActionSheetTableViewController: UITableViewController {

    //MARK:- Properties
    //Public Properties
    var alertController: UIAlertController = UIAlertController()
    var delegateAlert: ActionSheetTableviewControllerDelegate?
    
    //Local Properties
    var labelTexts: [String] = []
    var imgNames: [String] = []
    var imgTintColor: UIColor = .black
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK:- Set Initial Data
    func setUpView()
    {
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.separatorStyle = .none
        self.tableView.isScrollEnabled = false
        tableView.register(cellType: ActionSheetTableViewCell.self)
    }
}

//MARK:- UITableViewDataSource and UITableViewDelegate
extension ActionSheetTableViewController
{
    //MARK:- UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return labelTexts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let aObjCell = tableView.dequeueReusableCell(with: ActionSheetTableViewCell.self, for: indexPath)
        aObjCell.lblAlertAction.text = getString(anything: labelTexts[indexPath.row])
        aObjCell.imgAlertAction.image = UIImage(named: getString(anything: imgNames[indexPath.row]))?.withRenderingMode(.alwaysTemplate)
        aObjCell.imgAlertAction.tintColor = imgTintColor
        
        return aObjCell
    }
    
    //MARK:- UITableViewDelegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        DispatchQueue.main.async {
            self.alertController.dismiss(animated: true) {
                self.delegateAlert?.openActionAlert?(index: indexPath.row)
            }
        }
        /*alertController.dismiss(animated: true, completion: nil)
        self.delegateAlert?.openActionAlert?(index: indexPath.row)*/
    }
}
