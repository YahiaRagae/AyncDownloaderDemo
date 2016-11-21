//
//  UIImage+AyncDownloader.swift
//  AyncDownloaderDemo
//
//  Created by Yahia Work on 11/21/16.
//  Copyright © 2016 Yahia. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func loadImage(link: String, isIgnoreCaching:Bool)  {
        
        AyncDownloader.sharedInstance.loadFile(RequestConfig{ builder in
            builder.link = link
            builder.imageView =  self
            builder.isIgnoreCaching = isIgnoreCaching;
            
        }) { (fileData) in
            self.image = UIImage(data: fileData)
            UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.alpha = 1.0
                }, completion: nil)
        }
       
    }
}