//
//  ImagePickerControllerDelegate.swift
//  PSIS
//
//  Created by Vikram Jagad on 08/05/19.
//  Copyright © 2019 Vikram Jagad. All rights reserved.
//

import UIKit

class ImagePickerControllerDelegate: NSObject {
    //MARK:- Variables
    fileprivate let picker: UIImagePickerController
    fileprivate let delegate: ImageViewPickerDelegate!
    fileprivate let sender: UIView
    
    //MARK:- Initializers
    init(imagePicker: UIImagePickerController, delegate: ImageViewPickerDelegate, sender: UIView) {
        picker = imagePicker
        self.delegate = delegate
        self.sender = sender
        super.init()
        setUp()
    }
    
    //MARK:- Private Methods
    //Set Up
    fileprivate func setUp() {
        picker.delegate = self
    }
}

//MARK:- UIImagePickerControllerDelegate Methods
extension ImagePickerControllerDelegate: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                let compressedImgLogo = image.compressImageToLogoSize()
                if let imgData = image.pngData() {
                    let imageSize = Double(getInteger(anything: Double(imgData.count)/1048576.0))
                    if (imageSize > imageSizeLimit) {
                        let compressedImage = image.compressImageToImageSizeLimit(scale: CGFloat(imageSizeLimit/imageSize))
                        self.delegate?.imageData(img: compressedImage, compressedLogoImg: compressedImgLogo, imgType: "png", errorMsg: "", sender: self.sender)
                        return
                    }
                    self.delegate?.imageData(img: image, compressedLogoImg: compressedImgLogo, imgType: "png", errorMsg: "", sender: self.sender)
                }
            } else {
                self.delegate?.imageData(img: nil, compressedLogoImg: nil, imgType: "", errorMsg: String.LanguageLocalisation.no_image_selected, sender: self.sender)
            }
        }
    }
}
