//
//  FileFolderFunctions.swift
//  PSIS
//
//  Created by Vikram Jagad on 03/05/19.
//  Copyright © 2019 Vikram Jagad. All rights reserved.
//

import UIKit

//MARK:- Get File Path
func getFilePath(fileName: String) -> String
{
    let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    let destinationPath:NSString = documentsPath.appendingFormat(fileName) as NSString
    return destinationPath as String
}

func changeURL(url: URL, name: String) -> URL? {
    var tempURL = URL(fileURLWithPath: NSTemporaryDirectory())
    // Apend filename (name+extension) to URL
    tempURL.appendPathComponent(name)
    do {
        // If file with same name exists remove it (replace file with new one)
        if FileManager.default.fileExists(atPath: tempURL.path) {
            try FileManager.default.removeItem(atPath: tempURL.path)
        }
        // Move file from app_id-Inbox to tmp/filename
        try FileManager.default.moveItem(atPath: url.path, toPath: tempURL.path)
        return tempURL
    } catch let er {
        print(er.localizedDescription)
        return nil
    }
}
