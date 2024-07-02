//
//  BookMarkDataSourceDelegate.swift
//  loginDemo
//
//  Created by Priyal on 17/10/23.
//

import Foundation
import UIKit

class BookMarkDataSourceDelegate : NSObject {
    typealias TblView = UITableView
    typealias Delegate = TblViewDelegate
    var comp: ((Int) -> ())?
    var bookmarkarray : [String] = []
    var compdelete: ((Int) ->())?
    var color : String
    var typeId : Int
    var type : String = ""
    //var updateAddNotesCalled : ((String) -> Void)?
    //MARK:- Variables
    var arrSource: [book_mark_model]
    internal var tblView: UITableView
    internal var delegate: TblViewDelegate
    
    
    //MARK:- Initializers
    required init(arrData: [book_mark_model],delegate: TblViewDelegate, tbl: UITableView , color : String , typeId : Int ) {
        arrSource = arrData
        tblView = tbl
        self.delegate = delegate
        self.color = color
        self.typeId = typeId
        tblView.dragInteractionEnabled = true
        super.init()
        tblView.delegate = self
        tblView.dataSource = self
        registerCell()
        
    }
    
    internal func registerCell() {
        let cellTypes: [UITableViewCell.Type] = [BookMarkTblViewCell.self]
        tblView.register(cellTypes: cellTypes)
    }
    @objc func onClickBookMark(_ sender:UIButton){
        sender.tintColor = UIColor.init(hexStringToUIColor: color)
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            if typeId == 50 {
                type = "Medis briefings"
            }
            else if typeId == 51 {
                type = "Speeches & Statements"
            }
            else if typeId == 69 {
                type = "response To MediaQueries"
            } else {
                type = "Virtual Meeting"
            }
            let model = book_mark_model(title: arrSource[sender.tag].title, type: type, date: arrSource[sender.tag].date , id:arrSource[sender.tag].id, color: color )
            bookmarkarray.append(arrSource[sender.tag].id)
            
            //btnBookMark.tintColor = UIColor.init(hexStringToUIColor: color)
            //UserDefaults.setValue(bookmarkarray, forKey: "bookarray")
            if DBOperation.getInstance().insertBookmark(list: [model]) {
                self.arrSource.insert(model, at: 0)
            }
        } else {
            DBOperation.getInstance().deleteBookmark(id: arrSource[sender.tag].id )
            
        }
    }
   
    func reloadData(arr:[book_mark_model] , color : String , typeId : Int ) {
        arrSource = arr
        self.color = color
        self.typeId = typeId
        tblView.reloadData()
        
        if (arrSource.count > 0) {
            tblView.backgroundView = nil
        } else {
            tblView.backgroundView = UIView.makeNoRecordFoundView(frame: tblView.bounds, msg: "No Records Found")
        }
    }
    
}
extension BookMarkDataSourceDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate.didSelect?(tbl: tableView, indexPath: indexPath)
    }
   
}

//MARK:- UITableViewDataSource Methods
extension BookMarkDataSourceDelegate: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSource.count
    }
    
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(with: BookMarkTblViewCell.self, for: indexPath)
        Cell.configCell(data: arrSource[indexPath.row])
        Cell.btnBookMark.tag = indexPath.row
        Cell.bgView.backgroundColor = UIColor.init(hexStringToUIColor: color)
        Cell.btnBookMark.addTarget(self, action: #selector(onClickBookMark), for: .touchUpInside)
        let d = UserDefaults.standard.array(forKey: "myArray")
        if d!.count > 0 {
            for id in d!{
                if id as! String == arrSource[indexPath.row].id {
                    Cell.btnBookMark.isSelected = true
                    
                    //let col = UserPreferences.data(forKey: "color")
                    Cell.btnBookMark.tintColor = UIColor.init(hexStringToUIColor: color)
                }
            }
        } else {
            Cell.btnBookMark.isSelected = false
        }
      
//        Cell.btnDelete.addTarget(self, action: #selector(onClickDelete), for: .touchUpInside)
        return Cell
        }
    
}
