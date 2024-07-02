//
//  NotesModel.swift
//  loginDemo
//
//  Created by Priyal on 05/10/23.
//

import Foundation

import UIKit

class NotesModel: NSObject {
    var note: String = ""
    var id: String = ""
    var date_time:String = ""
    
    init(note: String, id: String, date_time:String) {
        self.note = note
        self.id = id
        self.date_time = date_time
    }
    
    init(fromDictionary dictionary: [String:Any]) {
        self.note = getString(anything: dictionary[DBOperationDatabaseTables.AddBookMarkTable.note])
        self.id = getString(anything: dictionary[DBOperationDatabaseTables.AddBookMarkTable.id])
        self.date_time = getString(anything: dictionary[DBOperationDatabaseTables.AddBookMarkTable.date_time])
    }
}

