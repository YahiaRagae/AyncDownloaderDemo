//
//  RequestConfig.swift
//  AyncDownloaderDemo
//
//  Created by Yahia Work on 11/21/16.
//  Copyright © 2016 Yahia. All rights reserved.
//

import Foundation
import UIKit
class RequestConfig {
    /**
     Link of Download.
     */
    var link:String?
    /**
     Show/hide Loading View , defualt value false
     */
    var isShowLoadingView:Bool = false
    
    /**
     The view which will be the parent of the HUD
     */
    var loadindView:UIView?
    /**
     Loading Message.
     */
    var loadingMessage:String?
    /**
     If you whant to force reload the data set to true , defualt value false
     */
    var isIgnoreCaching:Bool = false
    /**
     ImageView to show image on
     */
    var imageView:UIImageView?
    
    
    typealias BuilderClosure = (RequestConfig) -> ()
    
    init(buildClosure: BuilderClosure) {
        buildClosure(self)
    }
}