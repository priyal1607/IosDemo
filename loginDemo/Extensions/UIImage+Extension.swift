//
//  UIImage+Extension.swift
//  SharkID
//
//  Created by Vikram Jagad on 25/02/19.
//  Copyright © 2019 sttl. All rights reserved.
//

import UIKit
import CoreImage
import SDWebImage
import ImageIO
import Photos

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

extension UIImage
{
    func fixOrientation() -> UIImage
    {
        
        // No-op if the orientation is already correct
        if ( self.imageOrientation == UIImage.Orientation.up )
        {
            return self;
        }
        
        // We need to calculate the proper transformation to make the image upright.
        // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
        var transform: CGAffineTransform = CGAffineTransform.identity
        
        if ( self.imageOrientation == UIImage.Orientation.down || self.imageOrientation == UIImage.Orientation.downMirrored )
        {
            transform = transform.translatedBy(x: self.size.width, y: self.size.height)
            transform = transform.rotated(by: CGFloat(Double.pi))
        }
        
        if ( self.imageOrientation == UIImage.Orientation.left || self.imageOrientation == UIImage.Orientation.leftMirrored )
        {
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.rotated(by: CGFloat(Double.pi / 2.0))
        }
        
        if ( self.imageOrientation == UIImage.Orientation.right || self.imageOrientation == UIImage.Orientation.rightMirrored )
        {
            transform = transform.translatedBy(x: 0, y: self.size.height);
            transform = transform.rotated(by: CGFloat(-Double.pi / 2.0));
        }
        
        if ( self.imageOrientation == UIImage.Orientation.upMirrored || self.imageOrientation == UIImage.Orientation.downMirrored )
        {
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        }
        
        if ( self.imageOrientation == UIImage.Orientation.leftMirrored || self.imageOrientation == UIImage.Orientation.rightMirrored )
        {
            transform = transform.translatedBy(x: self.size.height, y: 0);
            transform = transform.scaledBy(x: -1, y: 1);
        }
        
        // Now we draw the underlying CGImage into a new context, applying the transform
        // calculated above.
        let ctx: CGContext = CGContext(data: nil, width: Int(self.size.width), height: Int(self.size.height),
                                       bitsPerComponent: self.cgImage!.bitsPerComponent, bytesPerRow: 0,
                                       space: self.cgImage!.colorSpace!,
                                       bitmapInfo: self.cgImage!.bitmapInfo.rawValue)!;
        
        ctx.concatenate(transform)
        
        if ( self.imageOrientation == UIImage.Orientation.left ||
            self.imageOrientation == UIImage.Orientation.leftMirrored ||
            self.imageOrientation == UIImage.Orientation.right ||
            self.imageOrientation == UIImage.Orientation.rightMirrored )
        {
            ctx.draw(self.cgImage!, in: CGRect(x: 0,y: 0,width: self.size.height,height: self.size.width))
        }
        else
        {
            ctx.draw(self.cgImage!, in: CGRect(x: 0,y: 0,width: self.size.width,height: self.size.height))
        }
        
        // And now we just create a new UIImage from the drawing context and return it
        return UIImage(cgImage: ctx.makeImage()!)
    }
    
    func rotate(degrees: Float) -> UIImage?
    {
        let radians = degrees * (Float.pi / 180.0)
        var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
        // Trim off the extremely small float value to prevent core graphics from rounding it up
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, true, self.scale)
        let context = UIGraphicsGetCurrentContext()!
        
        // Move origin to middle
        context.translateBy(x: newSize.width/2, y: newSize.height/2)
        // Rotate around middle
        context.rotate(by: CGFloat(radians))
        // Draw the image at its center
        self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func hasFace() -> Bool
    {
        guard let ciImage = CIImage(image: self) else{
            return false
        }
        let accuracy = [CIDetectorAccuracy:CIDetectorAccuracyHigh]
        if let detector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: accuracy){
            let faces = detector.features(in: ciImage)
            if faces.count > 0{
                return true
            }
        }
        return false
    }
    
    //MARK: - Image Compression Function
    func compressImage() -> UIImage
    {
        let originalImageSize = self.size
        var compressedImage = self
        
        if(originalImageSize.width > 400.0 || originalImageSize.height  > 400.0)
        {
            let newsize = CGSize(width: 400.0, height: 400.0)
            
            // Scale the original image to match the new size.
            UIGraphicsBeginImageContext(newsize)
            self.draw(in: CGRect(x: 0, y: 0, width: newsize.width, height: newsize.height))
            compressedImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
        }
        
        return compressedImage
    }
    
    func compressImageToLogoSize() -> UIImage
    {
        let originalImageSize = self.size
        var compressedImage = self
        
        if(originalImageSize.width > 40 || originalImageSize.height  > 40)
        {
            var ratio: CGFloat = 0
            var newsize = CGSize(width: 0, height: 0)
            if (originalImageSize.width > originalImageSize.height)
            {
                ratio = originalImageSize.height/originalImageSize.width
                newsize = CGSize(width: 100, height: 100*ratio)
            }
            else
            {
                ratio = originalImageSize.width/originalImageSize.height
                newsize = CGSize(width: 100*ratio, height: 100)
            }
            
            // Scale the original image to match the new size.
            UIGraphicsBeginImageContext(newsize)
            self.draw(in: CGRect(x: 0, y: 0, width: newsize.width, height: newsize.height))
            compressedImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
        }
        
        return compressedImage
    }
    
    func compressImageToImageSizeLimit(scale: CGFloat) -> UIImage {
        // Calculate new size given scale factor.
        let originalImageSize = self.size
        let newsize = CGSize(width: scale * originalImageSize.width, height: scale * originalImageSize.height)
        
        // Scale the original image to match the new size.
        UIGraphicsBeginImageContext(newsize)
        self.draw(in: CGRect(x: 0, y: 0, width: newsize.width, height: newsize.height))
        let compressedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return compressedImage
    }
    
    //MARK:- Resize Percentage
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    
    func grayscaleImage() -> UIImage? {
        let filter = CIFilter(name: "CIPhotoEffectMono")
        let ciInput = CIImage(image: self)
        filter?.setValue(ciInput, forKey: "inputImage")
        let ciOutput = filter?.outputImage
        let ciContext = CIContext()
        let cgImage = ciContext.createCGImage(ciOutput!, from: (ciOutput?.extent)!)
        return UIImage(cgImage: cgImage!)
    }
    
    enum ImageTypeReturn : String {
        case jpeg = "jpeg"
        case png = "png"
    }
    
}

//MARK: - Phasset To Image

extension PHAsset {
    
    private var imageRequestOptions: PHImageRequestOptions {
        let options = PHImageRequestOptions()
        options.version = .current
        options.resizeMode = .exact
        options.deliveryMode = .highQualityFormat
        options.isNetworkAccessAllowed = true
        options.isSynchronous = true
        return options
    }
    
    func phAssetToImage(gifImageCallBack: @escaping ((URL?) -> Void), imageCallBack: @escaping ((UIImage?) -> Void)) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            
            guard let `self` = self else {
                DispatchQueue.main.async {
                    gifImageCallBack(nil)
                }
                return
            }
            
            if PHAssetResource.assetResources(for: self).first?.uniformTypeIdentifier == PHASSET_GIF_IMAGE_TYPE {
                
                self.requestContentEditingInput(with: PHContentEditingInputRequestOptions(), completionHandler: { (contentEditingInput, dictInfo) in
                    
                    DispatchQueue.main.async {
                        gifImageCallBack(contentEditingInput?.fullSizeImageURL)
                    }
                })
            } else {
                
                PHImageManager.default().requestImage(for: self, targetSize: PHImageManagerMaximumSize, contentMode: .default, options: self.imageRequestOptions) { image, info in
                    DispatchQueue.main.async {
                        imageCallBack(image)
                    }
                }
            }
        }
    }
    
}


//MARK: - GIF Image
extension UIImage {
    
    public class func gifImageWithData(_ data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("image doesn't exist")
            return nil
        }
        
        return UIImage.animatedImageWithSource(source)
    }
    
    public class func gifImageWithURL(_ gifUrl:String) -> UIImage? {
        guard let bundleURL:URL = URL(string: gifUrl)
            else {
                print("image named \"\(gifUrl)\" doesn't exist")
                return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("image named \"\(gifUrl)\" into NSData")
            return nil
        }
        
        return gifImageWithData(imageData)
    }
    
    public class func gifImageWithName(_ name: String) -> UIImage? {
        guard let bundleURL = Bundle.main
            .url(forResource: name, withExtension: "gif") else {
                print("SwiftGif: This image named \"\(name)\" does not exist")
                return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
            return nil
        }
        
        return gifImageWithData(imageData)
    }
    
    class func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
        var delay = 0.1
        
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifProperties: CFDictionary = unsafeBitCast(
            CFDictionaryGetValue(cfProperties,
                Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()),
            to: CFDictionary.self)
        
        var delayObject: AnyObject = unsafeBitCast(
            CFDictionaryGetValue(gifProperties,
                Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()),
            to: AnyObject.self)
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties,
                Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }
        
        delay = delayObject as! Double
        
        if delay < 0.1 {
            delay = 0.1
        }
        
        return delay
    }
    
    class func gcdForPair(_ a: Int?, _ b: Int?) -> Int {
        var a = a
        var b = b
        if b == nil || a == nil {
            if b != nil {
                return b!
            } else if a != nil {
                return a!
            } else {
                return 0
            }
        }
        
        if a < b {
            let c = a
            a = b
            b = c
        }
        
        var rest: Int
        while true {
            rest = a! % b!
            
            if rest == 0 {
                return b!
            } else {
                a = b
                b = rest
            }
        }
    }
    
    class func gcdForArray(_ array: Array<Int>) -> Int {
        if array.isEmpty {
            return 1
        }
        
        var gcd = array[0]
        
        for val in array {
            gcd = UIImage.gcdForPair(val, gcd)
        }
        
        return gcd
    }
    
    class func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(source)
        var images = [CGImage]()
        var delays = [Int]()
        
        for i in 0..<count {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(image)
            }
            
            let delaySeconds = UIImage.delayForImageAtIndex(Int(i),
                source: source)
            delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
        }
        
        let duration: Int = {
            var sum = 0
            
            for val: Int in delays {
                sum += val
            }
            
            return sum
        }()
        
        let gcd = gcdForArray(delays)
        var frames = [UIImage]()
        
        var frame: UIImage
        var frameCount: Int
        for i in 0..<count {
            frame = UIImage(cgImage: images[Int(i)])
            frameCount = Int(delays[Int(i)] / gcd)
            
            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }
        
        let animation = UIImage.animatedImage(with: frames,
            duration: Double(duration) / 1000.0)
        
        return animation
    }
}

