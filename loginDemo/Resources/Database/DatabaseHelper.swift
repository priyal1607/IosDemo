//
//  DatabaseHelper.swift
//  RuralDevelopment
//
//  Created by Pradip Patel Mac on 29/07/21.
//  Copyright © 2021 Pradip Patel. All rights reserved.
//

import UIKit
import FMDB

fileprivate let sharedDatabaseHelperInstance = DatabaseHelper()

class DatabaseHelper: NSObject
{
    //MARK:- Variables
    //Local
    fileprivate var documentsDirectory: String = ""
    fileprivate var databaseFilename: String = ""
    fileprivate var databasequeue: FMDatabaseQueue = FMDatabaseQueue()
    
    //MARK:- Class Methods
    class func getInstance() -> DatabaseHelper {
        if (sharedDatabaseHelperInstance.databasequeue.path == nil)
        {
            _ = DatabaseHelper(databaseFilename: DBOperationDatabaseTables.dataBaseName)
            sharedDatabaseHelperInstance.databasequeue = FMDatabaseQueue(path: getFilePath(fileName: "/\(DBOperationDatabaseTables.dataBaseName)")) ?? FMDatabaseQueue()
        }
        
        return sharedDatabaseHelperInstance
    }
    
    //MARK:- Initializers
    override fileprivate init()
    {
        super.init()
    }
    
    fileprivate init(databaseFilename dbFilename: String)
    {
        super.init()
        self.documentsDirectory = getFilePath(fileName: "\(dbFilename)")
        self.databaseFilename = dbFilename
        self.copyDatabaseIntoDocumentsDirectory(databaseFilename: dbFilename)
    }
    
    //MARK:- Copy Database Into Documents Directory()
    func copyDatabaseIntoDocumentsDirectory(databaseFilename dbFilename: String)
    {
        let fileManager = FileManager.default
        let documentsPath = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
        let destinationSqliteURL = documentsPath.appendingPathComponent(dbFilename)
        print("des:", destinationSqliteURL)
        let arrDBNameExtension = dbFilename.components(separatedBy: ".")
        let sourceSqliteURL = Bundle.main.url(forResource: arrDBNameExtension[0], withExtension: arrDBNameExtension[1])
        
        if !(FileManager.default.fileExists(atPath: destinationSqliteURL.path))
        {
            do
            {
                try fileManager.copyItem(at: sourceSqliteURL!, to: destinationSqliteURL)
            }
            catch let error
            {
                debugPrint("Error while copying database \(error.localizedDescription)")
            }
        }
    }
    
    //MARK:- Insert, Delete or Update Data using executeQuery
    func executeQuery(aStrQuery: String, value : [Any] = []) -> Bool
    {
        var isSuccess = false
        databasequeue.inTransaction { (db, rollback) in
            do
            {
                isSuccess = (db.executeUpdate(aStrQuery, withArgumentsIn: value))
            }
        }
        return isSuccess
    }
    
    //MARK:- Bulk Data Insert using executeInsertStatement
    
    func executeInsert(aStrQuery: String, value : [Any] = []) -> Bool
    {
        var isSuccess = false
        databasequeue.inTransaction { (db, rollback) in
            do
            {
                isSuccess = (db.executeUpdate(aStrQuery, withArgumentsIn: value))
            }
        }
        return isSuccess
    }
    
    func executeBulkInsert(aStrQuery: String) -> Bool
    {
        var isSuccess = false
        databasequeue.inTransaction { (db, rollback) in
            do
            {
                isSuccess = (db.executeStatements(aStrQuery))
            }
        }
        return isSuccess
    }
    
    //MARK:- Get Data from Query generalize function
    func getdataFromQuery(aStrQuery: String) -> [Any]
    {
        var arrData: [Any] = []
        var resultSet : FMResultSet! = FMResultSet()
        
        databasequeue.inTransaction { (db, rollback) in
            do {
                resultSet = (db.executeQuery(aStrQuery, withArgumentsIn:[]))
                if (resultSet != nil)
                {
                    while resultSet.next()
                    {
                        let rowdata : NSMutableDictionary = NSMutableDictionary()
                        for i in 0..<resultSet.columnCount
                        {
                            rowdata.setValue(resultSet.string(forColumn:resultSet.columnName(for: Int32(i))!), forKey:resultSet.columnName(for: Int32(i))!)
                        }
                        arrData.append(rowdata)
                    }
                }
                else
                {
                    debugPrint(db.lastErrorMessage())
                }
            }
        }
        return arrData
    }
}
