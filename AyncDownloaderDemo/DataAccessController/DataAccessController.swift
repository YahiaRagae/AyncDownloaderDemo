//
//  DataAccessController.swift
//  AsyncDownloaderDemo
//
//  Created by Yahia Work on 11/21/16.
//  Copyright © 2016 Yahia. All rights reserved.
//

import Foundation
import UIKit
import AsyncDownloader
@objc public class DataAccessController: NSObject {
    class var sharedInstance: DataAccessController {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: DataAccessController? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = DataAccessController()
        }
        return Static.instance!
    }
    
    
    override init() {
        super.init()
        
        AsyncDownloader.Configure(ConfigBuilder{builder in
            builder.maxCacheMemory = 50
            })
    }
    
    public func getImagesList( onView view : UIView! , pageIndex : Int ,withCompletion completion:( imagesList  : [Pins])->Void){
        let requestConfig : RequestConfig  = RequestConfig{ builder in
            builder.link = "https://api.pinterest.com/v3/pidgets/boards/naturallife/road-trip/pins/"
            builder.loadingMessage = "Loading"
            builder.isShowLoadingView = true
            builder.loadindView = view
        }
        
        AsyncDownloader.sharedInstance.fetchJsonURL(requestConfig) { (reponse) in
            let object = Pinterest.init(json: reponse)
            completion(imagesList: object.data!.pins! )
        }
    }
}