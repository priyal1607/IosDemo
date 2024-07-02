//
//  UIImageView+Extension.swift
//  Vidyanjali
//
//  Created by Vikram Jagad on 11/11/20.
//  Copyright © 2020 Vikram Jagad. All rights reserved.
//

import UIKit
import SDWebImage
import SDWebImageWebPCoder

extension UIImageView {
  
    func downloadImage(with string: String?, placeholderImage: UIImage? = nil, options: SDWebImageOptions = .continueInBackground, progess: SDImageLoaderProgressBlock? = nil, completed: ((UIImage?, Error?, URL?) -> Void)? = nil) {
        
        self.image = nil
        
        guard let getImageString = string?.trimmingCharacters(in: .whitespacesAndNewlines),
              getImageString.count > 0 else {
            self.image = placeholderImage
            return
        }
        
        let url = URL(string: getImageString) ?? URL(string: getImageString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        
        self.sd_setImage(with: url, placeholderImage: placeholderImage, options: options, progress: progess) { [weak self] (getImage, getError, sdImageType, getUrl) in
            if getImage == nil {
                self?.image = placeholderImage
                completed?(placeholderImage, getError, getUrl)
            } else {
                completed?(getImage, getError, getUrl)
            }
        }
    }
    
    
    func downloadImageWithoutProgress(with string: String?, placeholderImage: UIImage? = nil, options: SDWebImageOptions = .continueInBackground, progess: SDImageLoaderProgressBlock? = nil,completed:SDExternalCompletionBlock? = nil) {
        
        self.image = nil
        
        guard let getImageString = string?.trimmingCharacters(in: .whitespacesAndNewlines),
              getImageString.count > 0 else {
            self.image = placeholderImage
            return
        }
        
        let url = URL(string: getImageString) ?? URL(string: getImageString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        
        //self.sd_imageIndicator = SDWebImageActivityIndicator.
        
        self.sd_setImage(with: url, placeholderImage: placeholderImage, options: options, progress: progess, completed: completed)

//        self.sd_setImage(with: url, placeholderImage: placeholderImage, options: options, progress: progess) { [weak self] (getImage, getError, sdImageType, getUrl) in
//            if getImage == nil {
//                self?.image = placeholderImage
//            }
//        }
    }
}


class RoundedImageView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setFullCornerRadius(type: .automatic)
    }
    
}
