//
//  FileManagerExtension.swift
//  DemoUFOBeaconManager
//
//  Created by Vikram Jagad on 19/05/21.
//

import UIKit

extension FileManager {
    // MARK: - Enums
    enum FileName: String {
        case beaconScan
    }

    enum FileType: String {
        case txt
    }

    class func removeOldFile(name: FileName = .beaconScan, type: FileType = .txt) {
        let fileManager = FileManager.default
        let path = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = path.appendingPathComponent("\(name.rawValue).\(type.rawValue)")
        if fileManager.fileExists(atPath: url.path) {
            do {
                try fileManager.removeItem(at: url)
            } catch {
                print("Remove old file failed. \(error.localizedDescription)")
            }
        }
    }

    @discardableResult class func writeToTextFile(name: FileName = .beaconScan, type: FileType = .txt, _ text: String) -> Bool {
        let fileManager = FileManager.default
        let path = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = path.appendingPathComponent("\(name.rawValue).\(type.rawValue)")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy hh:mm:ss a"
        let strDate = dateFormatter.string(from: Date())
        guard let data = "\n\(text) ==== \(strDate) ==== \(UIApplication.shared.applicationState == .active ? "Active" : "Background")".data(using: .utf8) else {
            print("Data conversion failed.")
            return false
        }
        if fileManager.fileExists(atPath: url.path) {
            do {
                let oldData = try Data(contentsOf: url)
                let newData = oldData + data
                try newData.write(to: url)
                if let str = String(data: newData, encoding: .utf8) {
                    print("Text File - \(str)")
                }
            } catch {
                print("Read or write failed. \(error.localizedDescription)")
                return false
            }
        } else {
            fileManager.createFile(atPath: url.path, contents: data, attributes: nil)
        }
        return true
    }
}
