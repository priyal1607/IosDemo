//
//  DocumentDirectoryShared.swift
//  DemoPhotoVideoSelection
//
//  Created by Vikram Jagad on 14/04/21.
//

import UIKit
import AVKit

class DocumentDirectoryShared: NSObject {
    enum DirectoryName : String {
        case TempDocument
    }
    
    class func createDirectory(name: DirectoryName) {
        let fileManager = FileManager.default
        if let tDocumentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            let filePath =  tDocumentDirectory.appendingPathComponent("\(name.rawValue)")
            if !fileManager.fileExists(atPath: filePath.path) {
                do {
                    try fileManager.createDirectory(atPath: filePath.path, withIntermediateDirectories: true, attributes: nil)
                } catch {
                    print("Couldn't create document directory")
                }
            }
            print("Document directory is \(filePath)")
        }
    }
    
    class func getUrlOfDir(dirName: DirectoryName, fileName: String) -> URL {
        let documentDirectoryPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let outputFilePath = documentDirectoryPath[0].appendingPathComponent("\(dirName.rawValue)" + "/" + "\(fileName)")
        print("outputFilePath: \(outputFilePath)")
        return outputFilePath
    }
    
    class func saveImageTo(dirName: DirectoryName, fileUrl: URL, image: UIImage) {
        if let data = image.pngData() {
            do {
                try data.write(to: fileUrl)
            } catch {
                print("error saving file to documents:", error)
            }
        } else if let data = image.jpegData(compressionQuality: 1) {
            do {
                try data.write(to: fileUrl)
            } catch {
                print("error saving file to documents:", error)
            }
        }
    }
    
    class func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    class func clearSubFilesOf(name: DirectoryName) {
        let documentDirectoryPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let subDirectoryPath = documentDirectoryPath[0].appendingPathComponent(name.rawValue)
        let fileManager = FileManager.default
        do {
            let filePaths = try fileManager.contentsOfDirectory(atPath: subDirectoryPath.absoluteString)
            for filePath in filePaths {
                try fileManager.removeItem(atPath: subDirectoryPath.absoluteString + filePath)
            }
        } catch {
            print("Could not clear temp folder: \(error)")
        }
    }
    
    class func compressVideo(inputURL: URL, outputURL: URL, handler:@escaping (_ exportSession: AVAssetExportSession?)-> Void) {
        let urlAsset = AVURLAsset(url: inputURL, options: nil)
        guard let exportSession = AVAssetExportSession(asset: urlAsset, presetName: AVAssetExportPresetLowQuality) else {
            handler(nil)
            return
        }
        
        exportSession.outputURL = outputURL
        exportSession.outputFileType = AVFileType.mp4
        exportSession.shouldOptimizeForNetworkUse = true
        exportSession.exportAsynchronously { () -> Void in
            handler(exportSession)
        }
    }
    
    class func thumbnailForVideoAtURL(url: URL) -> UIImage? {
        let asset = AVAsset(url: url)
        let assetImageGenerator = AVAssetImageGenerator(asset: asset)
        var time = asset.duration
        time.value = min(time.value, 2)
        do {
            let imageRef = try assetImageGenerator.copyCGImage(at: time, actualTime: nil)
            return UIImage(cgImage: imageRef).fixImageOrientation()
        } catch {
            print("error")
            return nil
        }
    }
    
    

    
    class func checkIfDocumentExistInLocalDirectory(dirName: DirectoryName, fileName: String, fileExtension: String) -> URL? {
        let fileManager = FileManager.default
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        var dataPath = documentsDirectory.appending("/\(dirName.rawValue)")
        var directory: ObjCBool = ObjCBool(false)
        let exists: Bool = fileManager.fileExists(atPath: dataPath, isDirectory: &directory)
        dataPath = dataPath.appending("/\(fileName).\(fileExtension)")
        if (exists && directory.boolValue) {
            if (fileManager.fileExists(atPath: dataPath)) {
                return URL(fileURLWithPath: dataPath)
            }
        }
        return nil
    }
}

extension UIImage {
    func fixImageOrientation()->UIImage {
        UIGraphicsBeginImageContext(self.size)
        self.draw(at: .zero)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? self
    }
}

extension Date {
    var ticks: UInt64 {
        return UInt64((self.timeIntervalSince1970 + Double(Int(Double.random(in: 1...62135596800)))) * 10_000_000)
    }
}
