//
//  ActionSheetTableViewControllerDelegateClass.swift
//  PSIS
//
//  Created by Vikram Jagad on 08/05/19.
//  Copyright © 2019 Vikram Jagad. All rights reserved.
//

import UIKit

class ActionSheetTableViewControllerDelegate: NSObject {
    //MARK:- Variables
    fileprivate let tblView: ActionSheetTableViewController
    fileprivate let index: ((Int) -> ())
    
    //MARK:- Initializers
    init(tbl: ActionSheetTableViewController, selectedIndex: @escaping ((Int) -> ())) {
        tblView = tbl
        index = selectedIndex
        super.init()
        setUp()
    }
    
    //MARK:- Private Methods
    fileprivate func setUp() {
        tblView.delegateAlert = self
    }
}

//MARK:- ActionSheetTableviewControllerDelegate Methods
extension ActionSheetTableViewControllerDelegate: ActionSheetTableviewControllerDelegate {
    func openActionAlert(index: Int) {
        self.index(index)
    }
}
