//
//  PhotoGalleryDetailScrollViewDelegate.swift
//  MyGovMaharashtra
//
//  Created by Vikram Jagad on 19/06/19.
//  Copyright © 2019 Vikram Jagad. All rights reserved.
//

import UIKit

class PhotoGalleryAlbumDetailPopupScrollViewDelegate: NSObject
{
    //MARK:- Variables
    //Local
    fileprivate let scrlView: UIScrollView
    fileprivate let viewForZooming: UIImageView
    //Public
    var isImageZoomed: Bool
    
    //MARK:- Initializers
    init(scrl: UIScrollView, viewForZooming: UIImageView)
    {
        scrlView = scrl
        isImageZoomed = false
        self.viewForZooming = viewForZooming
        super.init()
        setUp()
    }
    
    //MARK:- Private Methods
    //Set up
    fileprivate func setUp()
    {
        scrlView.delegate = self
        setUpZoomScale()
        setUpZoomGesture()
    }
    
    //Zoom scale set up
    fileprivate func setUpZoomScale()
    {
        scrlView.maximumZoomScale = 4.0
        scrlView.minimumZoomScale = 1.0
       /* if let viewForZooming = viewForZooming
        {
            scrlView.minimumZoomScale = scrlView.frame.size.width / viewForZooming.frame.size.width
            scrlView.contentSize = viewForZooming.frame.size
        }*/
    }
    
    //Zoom gesture set up
    fileprivate func setUpZoomGesture()
    {
        let doubleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.cancelsTouchesInView = false
        scrlView.addGestureRecognizer(doubleTap)
    }
    
    //MARK:- IBActions
    @objc func handleTap(_ gestureRecognizer: UIGestureRecognizer)
    {
        if !(isImageZoomed)
        {
            isImageZoomed = true
            scrlView.setZoomScale(4.0, animated: false)
        }
        else
        {
            isImageZoomed = false
            scrlView.setZoomScale(1.0, animated: false)
            /*if let viewForZooming = viewForZooming
            {
                scrlView.setZoomScale(scrlView.frame.size.width / viewForZooming.frame.size.width, animated: false)
            }*/
        }
    }
}

extension PhotoGalleryAlbumDetailPopupScrollViewDelegate: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        viewForZooming
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrlView.zoomScale > 1 {
            if let image = viewForZooming.image {
                let ratioW = viewForZooming.frame.width/image.size.width
                let rationH = viewForZooming.frame.height/image.size.height
                
                let ratio = ratioW < rationH ? ratioW :rationH
                let newWidth = image.size.width * ratio
                let newHeight = image.size.height * ratio
                
                let leftCondition = newWidth*scrlView.zoomScale > viewForZooming.frame.width
                let left = 0.5 * (leftCondition ? newWidth - viewForZooming.frame.width : (scrlView.frame.width - scrlView.contentSize.width))
                let topCondition = newHeight*scrlView.zoomScale > viewForZooming.frame.height
                let top =  0.5 * (topCondition ? newHeight - viewForZooming.frame.height : (scrlView.frame.height - scrlView.contentSize.height))
                
                scrlView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
                isImageZoomed = true
            }
        } else {
            isImageZoomed = false
            scrlView.contentInset = .zero
        }
    }
}
