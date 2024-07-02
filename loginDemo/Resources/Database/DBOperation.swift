//
//  DBOperation.swift
//  loginDemo
//
//  Created by Priyal on 05/10/23.
//

import Foundation
fileprivate let sharedDBOperationInstance = DBOperation()
protocol TableDefautProperties {
    static var tableName: String { get }
}
struct DBOperationDatabaseTables {
    
    private init() { }
    
    static let dataBaseName : String = "Note_Database.db"
    
    struct AddBookMarkTable : TableDefautProperties {
        private init() { }
        
        static var tableName: String { return "Notes" }
        
        static let date_time: String = "date_time"
        static let note : String = "note"
        static let id : String = "id"
    }
    struct BookMarkTable : TableDefautProperties {
        private init() { }
        
        static var tableName: String { return "BookMark" }
        static let color : String = "color"
        static let date: String = "date"
        static let title : String = "title"
        static let type : String = "type"
        static let id : String = "publicationDataID"
    }
}
class DBOperation: NSObject {
    
    //MARK: - Class Methods
    class func getInstance() -> DBOperation {
        return sharedDBOperationInstance
    }
    
    
    //MARK: - Bookmark Methods
    
    func insertNotes(list: [NotesModel]) -> Bool {
        
        guard list.count > 0 else { return false }
        
        var returnFlag: Bool!
        
        for item in list {
            
            let tableKeys = DBOperationDatabaseTables.AddBookMarkTable.self
            
            var str = "INSERT INTO \(tableKeys.tableName) "
            str += "(\(tableKeys.id), \(tableKeys.note), \(tableKeys.date_time)) VALUES "
            
            let queries = "\(str)(?,?,?);"
            
            let flag = DatabaseHelper.getInstance().executeInsert(aStrQuery: queries, value: [item.id, item.note, item.date_time])
            returnFlag = (returnFlag == nil) ? flag : (returnFlag && flag)
        }
        
        debugPrint(returnFlag ?? "")
        
        return returnFlag
    }
    
    func NoteList(id: String = "") -> [NotesModel] {
        
        let tableKeys = DBOperationDatabaseTables.AddBookMarkTable.self
        
        let whereCondtion = id.isEmptyString ? "" : " WHERE \(tableKeys.id)=\'\(id)\'"
        
        if let arrSource = DatabaseHelper.getInstance().getdataFromQuery(aStrQuery: "SELECT * FROM \(tableKeys.tableName)\(whereCondtion)") as? [[String : Any]] {
            
            let list = arrSource.map({ NotesModel(fromDictionary: $0) })
            
            return list
        }
        
        return []
    }
    
    func deleteNote(id: String) -> Bool {
    
        let tableKeys = DBOperationDatabaseTables.AddBookMarkTable.self
        
        let returnFlag = DatabaseHelper.getInstance().executeQuery(aStrQuery: "DELETE from \(tableKeys.tableName) WHERE " + "(\(tableKeys.id) = \'\(id.self)\')")
        
        debugPrint(returnFlag)
        
        return returnFlag
    }
    
        func updateMEANote(id : String, note:String, date_time:String) -> Bool {
    
            let tableKeys = DBOperationDatabaseTables.AddBookMarkTable.self
    
            let updateQuerie : String = "UPDATE \(tableKeys.tableName) SET note =?, date_time =? WHERE id =?"
    
            let returnFlag = DatabaseHelper.getInstance().executeQuery(aStrQuery: updateQuerie, value: [note, date_time, id])
    
            debugPrint(returnFlag)
    
            return returnFlag
        }

    func deleteAllBookmark() -> Bool {
        let returnFlag = DatabaseHelper.getInstance().executeQuery(aStrQuery: "DELETE from \(DBOperationDatabaseTables.AddBookMarkTable.tableName)")
        
        debugPrint(returnFlag)
        
        return returnFlag
        /*if let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            do {
                let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsUrl,
                                                                           includingPropertiesForKeys: nil,
                                                                           options: .skipsHiddenFiles)
                
                for fileURL in fileURLs {
                    if fileURL.pathExtension != "sqlite" {
                        try FileManager.default.removeItem(at: fileURL)
                    }
                }
            } catch  {
                print(error)
            }
        } */
    }
    
    
    //MARK: - Bookmark Methods
    
//    func insertMeaNote(list: [MyMEANoteData]) -> Bool {
//        
//        guard list.count > 0 else { return false }
//        
//        var returnFlag: Bool!
//        
//        for item in list {
//            
//            let tableKeys = DBOperationDatabaseTables.AddMEANoteTable.self
//            
//            var str = "INSERT INTO \(tableKeys.tableName) "
//            str += "(\(tableKeys.note), \(tableKeys.id), \(tableKeys.date_time)) VALUES "
//            
//            let queries = "\(str)(?,?,?);"
//            
//            let flag = DatabaseHelper.getInstance().executeInsert(aStrQuery: queries, value: [item.note, item.id, item.date_time])
//            returnFlag = (returnFlag == nil) ? flag : (returnFlag && flag)
//        }
//        
//        
//        debugPrint(returnFlag ?? "")
//        
//        return returnFlag
//    }
//    
//    func updateMEANote(id : String, note:String, date_time:String) -> Bool {
//        
//        let tableKeys = DBOperationDatabaseTables.AddMEANoteTable.self
//        
//        let updateQuerie : String = "UPDATE \(tableKeys.tableName) SET note =?, date_time =? WHERE id =?"
//        
//        let returnFlag = DatabaseHelper.getInstance().executeQuery(aStrQuery: updateQuerie, value: [note, date_time, id])
//        
//        debugPrint(returnFlag)
//        
//        return returnFlag
//    }
//    
//    func meaNoteList(id: String = "") -> [MyMEANoteData] {
//        
//        let tableKeys = DBOperationDatabaseTables.AddMEANoteTable.self
//
//        let whereCondtion = id.isEmptyString ? "" : " WHERE \(tableKeys.id) in (\(id))"
//        
//        if let arrSource = DatabaseHelper.getInstance().getdataFromQuery(aStrQuery: "SELECT * FROM \(tableKeys.tableName)\(whereCondtion)") as? [[String : Any]] {
//            
//            let list = arrSource.map({ MyMEANoteData(fromDictionary: $0) })
//            
//            return list
//        }
//        
//        return []
//    }
//    
//    func deleteMEANoteRow(id:String) -> Bool {
//
//        let tableKeys = DBOperationDatabaseTables.AddMEANoteTable.self
//
//        let returnFlag = DatabaseHelper.getInstance().executeQuery(aStrQuery: "DELETE from \(tableKeys.tableName) WHERE \(tableKeys.id)=\'\(id)\'")
//        
//        debugPrint(returnFlag)
//        
//        return returnFlag
//        
//    }
//    
//    func deleteMEA_AllNotes() -> Bool {
//        let returnFlag = DatabaseHelper.getInstance().executeQuery(aStrQuery: "DELETE from \(DBOperationDatabaseTables.AddMEANoteTable.tableName)")
//        
//        debugPrint(returnFlag)
//        
//        return returnFlag
//    }
//    
////    MARK: - Passport List
//    
//    func passportList() -> [PassportModel] {
//        
//        let tableKeys = DBOperationDatabaseTables.PassportTable.self
//
////        let whereCondtion = id.isEmptyString ? "" : " WHERE \(tableKeys.id) in (\(id))"
//        
//        if let arrSource = DatabaseHelper.getInstance().getdataFromQuery(aStrQuery: "SELECT * FROM \(tableKeys.tableName)") as? [[String : Any]] {
//            print(arrSource)
//            let list = arrSource.map({ PassportModel(fromDictionary: $0) })
//            
//            return list
//        }
//        
//        return []
//    }
    
    func insertBookmark(list: [book_mark_model]) -> Bool {
        
        guard list.count > 0 else { return false }
        
        var returnFlag: Bool!
        
        for item in list {
            
            let tableKeys = DBOperationDatabaseTables.BookMarkTable.self
            
            var str = "INSERT INTO \(tableKeys.tableName) "
            str += "(\(tableKeys.color),\(tableKeys.type), \(tableKeys.title), \(tableKeys.date) , \(tableKeys.id)) VALUES "
            
            let queries = "\(str)(?,?,?,?,?);"
            
            let flag = DatabaseHelper.getInstance().executeInsert(aStrQuery: queries, value: [item.color,item.type, item.title, item.date , item.id])
            returnFlag = (returnFlag == nil) ? flag : (returnFlag && flag)
        }
        
        debugPrint(returnFlag ?? "")
        
        return returnFlag
    }
    func deleteBookmark(id: String) -> Bool {
    
        let tableKeys = DBOperationDatabaseTables.BookMarkTable.self
        
        let returnFlag = DatabaseHelper.getInstance().executeQuery(aStrQuery: "DELETE from \(tableKeys.tableName) WHERE " + "(\(tableKeys.id) = \'\(id.self)\')")
        
        debugPrint(returnFlag)
        
        return returnFlag
    }
    
    func bookmark_list(id: String = "") -> [book_mark_model] {
        
        let tableKeys = DBOperationDatabaseTables.BookMarkTable.self
        
        let whereCondtion = id.isEmptyString ? "" : " WHERE \(tableKeys.id)=\'\(id)\'"
        
        if let arrSource = DatabaseHelper.getInstance().getdataFromQuery(aStrQuery: "SELECT * FROM \(tableKeys.tableName)\(whereCondtion)") as? [[String : Any]] {
            
            let list = arrSource.map({ book_mark_model(fromDictionary: $0) })
            
            return list
        }
        
        return []
    }
}
