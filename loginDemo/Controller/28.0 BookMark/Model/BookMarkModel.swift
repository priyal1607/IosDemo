//
//  BookMarkModel.swift
//  loginDemo
//
//  Created by Priyal on 18/10/23.
//

import Foundation

import UIKit

class BookMarkModel: NSObject {
    var date: String = ""
    var title: String = ""
    var websiteUrl:String = ""
    var publicationDataID : String = ""
    var isSel : Bool = false
    
    
    init(dictionary: DICTIONARY) {
        self.date = getString(anything: dictionary["date"])
        self.title = getString(anything: dictionary["title"])
        self.websiteUrl = getString(anything: dictionary["websiteUrl"])
        self.publicationDataID = getString(anything: dictionary["publicationDataID"])
        self.isSel = getBoolean(anything: dictionary["isSel"])
    }
}


class book_mark_model: NSObject {
    var title: String = ""
    var type: String = ""
    var date:String = ""
    var id : String = ""
    var color : String = ""
    init(title: String, type: String, date:String , id:String , color : String) {
        self.title = title
        self.type = type
        self.date = date
        self.id = id
        self.color = color
    }
    
    init(fromDictionary dictionary: [String:Any]) {
        self.title = getString(anything: dictionary[DBOperationDatabaseTables.BookMarkTable.title])
        self.type = getString(anything: dictionary[DBOperationDatabaseTables.BookMarkTable.type])
        self.date = getString(anything: dictionary[DBOperationDatabaseTables.BookMarkTable.date])
        self.id = getString(anything: dictionary[DBOperationDatabaseTables.BookMarkTable.id])
        self.color = getString(anything: dictionary[DBOperationDatabaseTables.BookMarkTable.color])
    }
}

