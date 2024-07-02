//
//  PickerDelegate.swift
//  DemoPhotoVideoSelection
//
//  Created by Vikram Jagad on 14/04/21.
//

import UIKit
import MobileCoreServices
import AVKit
import Photos

@objc protocol PickerDelegate {
    func imageViewUrl(url: URL?,data:Data?, errorMsg: String,sender:UIView)
    @objc optional func videoViewUrl(url: URL?, thumbnailUrl: URL?, errorMsg: String)
}

class PickerDelegateController: NSObject {
    //MARK:- Variables
    private let picker: UIImagePickerController
    private weak var delegate: PickerDelegate?
    private let fileSizeLimit:Double
    private let sender:UIView
    //MARK:- Initializers
    init(imagePicker: UIImagePickerController, fileSizeLimit: Double, delegate: PickerDelegate,sender:UIView) {
        picker = imagePicker
        self.delegate = delegate
        self.fileSizeLimit = fileSizeLimit
        self.sender = sender
        super.init()
        setUp()
    }
    
    //MARK:- Private Methods
    //Set Up
    private func setUp() {
        picker.delegate = self
    }
}

//MARK:- UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension PickerDelegateController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                if let imgData = image.pngData() {
                    let imageSize = Double(getInteger(anything: Double(imgData.count)/1048576.0))
                    print("imageSize - ", imageSize)
                    var compressedImage = image
                    if (imageSize > self.fileSizeLimit) {
                        compressedImage = image.compressImageToImageSizeLimit(scale: CGFloat(self.fileSizeLimit/imageSize))
                    }
                    print("compressedImage - ", Double(getInteger(anything: Double((compressedImage.pngData())?.count ?? 0)/1048576.0)))
                    let imagefileUrl = DocumentDirectoryShared.getUrlOfDir(dirName: .TempDocument, fileName: "\(Date().ticks).png")
                   DocumentDirectoryShared.saveImageTo(dirName: .TempDocument, fileUrl: imagefileUrl, image: compressedImage.fixImageOrientation())
                    self.delegate?.imageViewUrl(url: imagefileUrl,data:imgData, errorMsg: "",sender:self.sender)
                    
                } else if let imgData = image.jpegData(compressionQuality: 1) {
                    let imageSize = Double(getInteger(anything: Double(imgData.count)/1048576.0))
                    print("imageSize - ", imageSize)
                    var compressedImage = image
                    if (imageSize > self.fileSizeLimit) {
                        compressedImage = image.compressImageToImageSizeLimit(scale: CGFloat(self.fileSizeLimit/imageSize))
                    }
                    print("compressedImage - ", Double(getInteger(anything: Double((compressedImage.pngData())?.count ?? 0)/1048576.0)))
                    let imagefileUrl = DocumentDirectoryShared.getUrlOfDir(dirName: .TempDocument, fileName: "\(Date().ticks).png")
                   // DocumentDirectoryShared.saveImageTo(dirName: .TempDocument, fileUrl: imagefileUrl, image: compressedImage.fixImageOrientation())
                    self.delegate?.imageViewUrl(url: imagefileUrl,data:imgData, errorMsg: "",sender:self.sender)
                }
                
            } else if info[UIImagePickerController.InfoKey.mediaType] as? String == (kUTTypeMovie as String) {
                if let selectedVideo = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
                    
                    guard let selectedVideoData = NSData(contentsOf: selectedVideo) else {
                        return
                    }
                    
                    print("File size selectedVideo : \(Double(selectedVideoData.length / 1048576)) mb")
                    
                    let compressedUrl = DocumentDirectoryShared.getUrlOfDir(dirName: .TempDocument, fileName: "\(Date().ticks).mp4")
                    //CustomActivityIndicator.sharedInstance.showIndicator()
                    DocumentDirectoryShared.compressVideo(inputURL: selectedVideo, outputURL: compressedUrl) { (exportSession) in
                        DispatchQueue.main.async {
                          //  CustomActivityIndicator.sharedInstance.hideIndicator()
                        }
                        guard let session = exportSession else {
                            return
                        }
                        
                        switch session.status {
                        case .unknown:
                            break
                        case .waiting:
                            break
                        case .exporting:
                            break
                        case .completed:
                            guard let compressedData = NSData(contentsOf: compressedUrl) else {
                                return
                            }
                            
                            let compressedDataSize = Double(compressedData.length / 1048576)//mb
                            print("File size after compression: \(compressedDataSize) mb", " fileSizeLimit - ", self.fileSizeLimit)

                            if (compressedDataSize > self.fileSizeLimit) {
                                
                                DispatchQueue.main.async {
                                    UIAlertController.showWith(title: String.LanguageLocalisation.video_size_must_be_up_to_4_MB, msg: "", actionTitles: [String.LanguageLocalisation.OK], actionStyles: [.default], actionHandlers: [{ (yesAction) in
                                        self.delegate?.imageViewUrl(url: nil,data: nil, errorMsg: "",sender:self.sender)
                                    }])
                                }
                                
                            } else {
                                let imagefileUrl = DocumentDirectoryShared.getUrlOfDir(dirName: .TempDocument, fileName: "\(Date().ticks).png")
                                var imageVideoThumb = DocumentDirectoryShared.thumbnailForVideoAtURL(url: compressedUrl)
                                imageVideoThumb = imageVideoThumb!.rotate(degrees: 90)
                                DocumentDirectoryShared.saveImageTo(dirName: .TempDocument, fileUrl: imagefileUrl, image: imageVideoThumb ?? UIImage())
                                self.delegate?.videoViewUrl?(url: compressedUrl, thumbnailUrl: imagefileUrl, errorMsg: "")
                            }
                            
                        case .failed:
                            break
                        case .cancelled:
                            break
                        @unknown default:
                            break
                        }
                    }
                } else {
                    self.delegate?.videoViewUrl?(url: nil, thumbnailUrl: nil, errorMsg: "Can not capture Video")
                }
            } else {
                self.delegate?.imageViewUrl(url: nil,data: nil, errorMsg: "",sender:self.sender)
            }
        }
    }
}

extension PickerDelegateController {
    
    static func checkCameraPermission(callback: ((Bool) -> Void)?) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                DispatchQueue.main.async {
                    callback?(granted)
                }
            })
        case .restricted:
            UIAlertController.showWith(title: nil, msg: String.LanguageLocalisation.this_Device_Has_No_Camera, style: .alert, sender: nil, actionTitles: [.LanguageLocalisation.OK], actionStyles: [.default], actionHandlers: [nil])
            
        case .denied:
            UIAlertController.showWith(title: nil, msg: String.LanguageLocalisation.camera_unavailable, style: .alert, sender: nil, actionTitles: [.LanguageLocalisation.OK, .LanguageLocalisation.go_to_settings], actionStyles: [.destructive, .default], actionHandlers: [nil, { (goToSettingsAction) in
                
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
                
            }])
            callback?(false)
        case .authorized:
            callback?(true)
            
        @unknown default: break
        }
    }
    
}

