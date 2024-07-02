//
//  OptionsTblViewDelegate.swift
//  loginDemo
//
//  Created by Priyal on 26/09/23.
//

import Foundation
import UIKit

class OptionsTblViewDelegate : NSObject {
    typealias TblView = UITableView
    typealias Delegate = TblViewDelegate
    var selectedIndexPaths: [IndexPath] = []
    var isSel : Bool = true
    
    var comp: (([dashboardList]) -> ())?
    //MARK:- Variables
    var arrSource: [dashboardList]
    internal var tblView: UITableView
    internal var delegate: TblViewDelegate
    
    
    //MARK:- Initializers
    required init(arrData: [dashboardList],delegate: TblViewDelegate, tbl: UITableView ) {
        arrSource = arrData
        tblView = tbl
        self.delegate = delegate
        tblView.dragInteractionEnabled = true
        super.init()
        tblView.delegate = self
        tblView.dataSource = self
        tblView.dragDelegate = self
        tblView.dropDelegate = self
        registerCell()
        
    }
    
    internal func registerCell() {
        let cellTypes: [UITableViewCell.Type] = [OptionsTblViewCell.self]
        tblView.register(cellTypes: cellTypes)
        //        tblView.contentInset = UIEdgeInsets(top: topBottomInsets, left: 0, bottom: topBottomInsets, right: 0)
    }
   
    
    func reloadData(arr:[dashboardList]) {
        arrSource = arr
        tblView.reloadData()
        
        if (arrSource.count > 0) {
            tblView.backgroundView = nil
        } else {
            tblView.backgroundView = UIView.makeNoRecordFoundView(frame: tblView.bounds, msg: .LanguageLocalisation.no_record_found)
        }
    }
    
    
    
}
extension OptionsTblViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.didSelect?(tbl : tableView, indexPath: indexPath)
        arrSource[indexPath.row].isSelected.toggle()
        comp?(arrSource)
      //  UserDefaults.standard.set(selectedIndexPaths, forKey: "selArray")
        UserDefaults.standard.set(selectedIndexPaths.count, forKey: "total")
        //UserDefaults.standard.set(secondValues, forKey: "selArray")
        tblView.reloadData()
            
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        delegate.willDisplay?(tbl: tableView, atIndexPath: indexPath)
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
           return true
       }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
            // Reorder the data source array
            let movedItem = arrSource.remove(at: sourceIndexPath.row)
            arrSource.insert(movedItem, at: destinationIndexPath.row)
            comp?(arrSource)
            // Optional: Update UserDefaults or any other data storage mechanism to persist the changes
            //UserDefaults.standard.set(arrSource, forKey: "arrSourceKey")
        }
       
}

//MARK:- UITableViewDataSource Methods
extension OptionsTblViewDelegate: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSource.count
    }
    
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(with: OptionsTblViewCell.self, for: indexPath)
        Cell.configCell(data: arrSource[indexPath.row])
        if arrSource[indexPath.row].isSelected {
            Cell.upView.backgroundColor = .white
            Cell.imgSelect.tintColor = .lightGray
            Cell.img.isHidden = true
        } else {
            Cell.upView.backgroundColor = .clear
            Cell.imgSelect.tintColor = .black
            Cell.img.isHidden = false
        }

            return Cell
        }
    
}
extension OptionsTblViewDelegate: UITableViewDragDelegate {
func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return [UIDragItem(itemProvider: NSItemProvider())]
    }
}

extension OptionsTblViewDelegate: UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {

        if session.localDragSession != nil { // Drag originated from the same app.
            return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
 
        return UITableViewDropProposal(operation: .cancel, intent: .unspecified)
    }

    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
    }
}
