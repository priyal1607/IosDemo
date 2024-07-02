//
//  SharingFunctions.swift
//  SharkID
//
//  Created by Vikram Jagad on 06/03/19.
//  Copyright © 2019 sttl. All rights reserved.
//

import UIKit
import Alamofire

private var af_saveURLDocuments: [String:URL] = [:]
typealias CompletionBlock1 = (_ act: Any?, _ result: Bool) -> Void


/// Save Document To Files is show UIActivityViewController Share.
///
/// saveDocumentToFiles:
///
///     saveDocumentToFiles(url: URL(string: "http://www.example.com/report.pdf"),
///                         onVC: self,
///                         sourceView: sender,
///                         isShowActivityIndicator: true) {
///         sender.isUserInteractionEnabled = true
///         debugPrint("saveDocumentToFiles completion called")
///     }
///
/// - Parameters:
///   - url: URL to download url. if url nil then not working
///   - onVC: pass present on UIActivityViewController.
///   - sourceView: pass manage UIActivityViewController for iPad & Show Activity Indicator on super view.
///   - isShowActivityIndicator: If TRUE Show Activity Indicator else hide.
///   - completion: when it is called when download file and show UIActivityViewController.
func saveDocumentToFiles(url: URL?, onVC: UIViewController, sourceView: UIView, isShowActivityIndicator: Bool = false, completion: @escaping (() -> Void)) {
    guard let getURL = url else {
        completion()
        return
    }
    
    debugPrint(getURL)
    
    if let takeURL = af_saveURLDocuments[getURL.absoluteString] {
        saveURLFromActivityVC(url: takeURL, onVC: onVC, sourceView: sourceView, completion: completion)
        return
    }
    
    var activityIndicatorView : UIActivityIndicatorView!
    if isShowActivityIndicator {
        activityIndicatorView = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            activityIndicatorView.style = .medium
        } else {
            activityIndicatorView.style = .gray
        }
        activityIndicatorView.color = .gray
        activityIndicatorView.tintColor = .gray
        activityIndicatorView.backgroundColor = .clear
        sourceView.superview?.addSubview(activityIndicatorView)
        activityIndicatorView.center = sourceView.superview?.center ?? .zero
        sourceView.isHidden = true
        activityIndicatorView.startAnimating()
    }
    
    
    let destination: DownloadRequest.Destination = { _, _ in
        var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        documentsURL.appendPathComponent(getURL.lastPathComponent)
        return (documentsURL, [.removePreviousFile])
    }
    
    AF.download(getURL, method: .get, parameters: nil, headers: nil, interceptor: nil, requestModifier: { (session) in
        session.timeoutInterval = 120
    }, to: destination).responseURL(queue: .main) { afURLResponse in
        
        sourceView.isHidden = false
        activityIndicatorView?.stopAnimating()
        activityIndicatorView?.removeFromSuperview()
        
        switch afURLResponse.result {
        case .success(let takeURL):
            af_saveURLDocuments[getURL.absoluteString] = takeURL
            saveURLFromActivityVC(url: takeURL, onVC: onVC, sourceView: sourceView, completion: completion)
        case .failure(let err):
            print(err)
            saveURLFromActivityVC(url: getURL, onVC: onVC, sourceView: sourceView, completion: completion)
        }
    }
    
}

private func saveURLFromActivityVC(url: URL, onVC: UIViewController, sourceView: UIView, completion: @escaping (() -> Void)) {
    debugPrint(url)
    let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
    activityVC.excludedActivityTypes = [.addToReadingList, .airDrop, .assignToContact, .copyToPasteboard, .mail, .markupAsPDF, .message, .openInIBooks, .postToFacebook, .postToFlickr, .postToTencentWeibo, .postToTwitter, .postToVimeo, .postToWeibo, .print]
    activityVC.popoverPresentationController?.sourceView = sourceView
    onVC.present(activityVC, animated: true, completion: nil)
    
    completion()
}
