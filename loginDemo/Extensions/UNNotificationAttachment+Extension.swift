//
//  UNNotificationAttachment+Extension.swift
//  SharkID
//
//  Created by Shark id Employee on 14/03/19.
//  Copyright © 2019 sttl. All rights reserved.
//

import UIKit
import UserNotifications

//MARK:- Extension for Attachment
@available(iOS 10.0, *)
extension UNNotificationAttachment
{
    static func create(identifier: String, image: UIImage?, options: [NSObject : AnyObject]?) -> UNNotificationAttachment?
    {
        let fileManager = FileManager.default
        let tmpSubFolderName = identifier
        let tmpSubFolderURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(tmpSubFolderName, isDirectory: true)
        do
        {
            try fileManager.createDirectory(at: tmpSubFolderURL, withIntermediateDirectories: true, attributes: nil)
            let imageFileIdentifier = identifier+".png"
            let fileURL = tmpSubFolderURL.appendingPathComponent(imageFileIdentifier)
            guard let tempImage = image, let imageData = tempImage.pngData() else {
                return nil
            }
            try imageData.write(to: fileURL)
            let imageAttachment = try UNNotificationAttachment.init(identifier: identifier, url: fileURL, options: [UNNotificationAttachmentOptionsTypeHintKey : "png"])
            return imageAttachment
        }
        catch
        {
            debugPrint("error " + error.localizedDescription)
        }
        return nil
    }
}
