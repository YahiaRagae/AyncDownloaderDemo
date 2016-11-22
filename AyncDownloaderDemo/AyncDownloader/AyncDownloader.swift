//
//  AyncDownloader.swift
//  AyncDownloaderDemo
//
//  Created by Yahia Work on 11/21/16.
//  Copyright © 2016 Yahia. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import JGProgressHUD


@objc public class AyncDownloader : NSObject {
    static let UD_CONFIG_MAX_MEMORY:String = "UD_CONFIG_MAX_MEMORY"
    static let UD_CONFIG_IGNORE_CACHING:String = "UD_CONFIG_IGNORE_CACHING"
    static var isSetConfig:Bool = false ;
    var onlineController:OnlineController!
    
    
    static func Configure( config :ConfigBuilder){
        NSUserDefaults.standardUserDefaults().setBool(config.isIgnoreCaching, forKey: UD_CONFIG_IGNORE_CACHING)
        if let maxMomry  = config.maxCacheMemory  {
            NSUserDefaults.standardUserDefaults().setInteger(maxMomry, forKey: UD_CONFIG_MAX_MEMORY)
            NSUserDefaults.standardUserDefaults().synchronize()
            isSetConfig = true;
            
            //Set Cache Size To NSURLCache
            let cacheSize : Int = maxMomry*1024*1024;
            NSURLCache.setSharedURLCache(NSURLCache(memoryCapacity: cacheSize, diskCapacity: cacheSize, diskPath: nil))
            
        }
        
    }
    
    class var sharedInstance: AyncDownloader {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: AyncDownloader? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = AyncDownloader()
        }
        return Static.instance!
    }
    
    
    override init() {
        super.init()
        onlineController =  OnlineController.sharedInstance
        
        if(!AyncDownloader.isSetConfig){
            NSException(name: "AyncDownloader", reason: "maxMemory Configuration cannot be nil", userInfo: nil).raise()
        }
    }
    internal func fetchJsonURL(  config : RequestConfig , withCompletion completion:( reponse  : JSON  )->Void ){
        
        if let link = config.link {
            var hud:JGProgressHUD!
            let task : NSURLSessionTask  = onlineController.getRequest(link) { (response, status) in
                
                if(hud != nil){
                    hud.dismiss()
                }
                if(status == true){
                    let json = JSON(data: response.data!)
                    completion(reponse: json)
                }
            }
            
            if(config.isShowLoadingView){
                hud = loadingView(task, message: config.loadingMessage, withView: config.loadindView)
            }
        }else{
            NSException(name: "AyncDownloader", reason: "config.link cannot be nil", userInfo: nil).raise()
        }
    }
    
    internal func loadFile(  config : RequestConfig , withCompletion completion:( fileData  : NSData  )->Void ){
        var hud:JGProgressHUD!
        if (config.link != nil && config.imageView != nil) {
            let task : NSURLSessionTask  = onlineController.getFile(config.link!) { (response, status) in
                if(status){
                    completion(fileData: response.data!)
                }
                if(hud != nil){
                    hud.dismiss()
                }
            }
            if(config.isShowLoadingView){
                hud = loadingView(task, message: config.loadingMessage, withView: config.loadindView)
            }
        }else{
            NSException(name: "AyncDownloader", reason: "( config.link || config.imageView ) cannot be nil", userInfo: nil).raise()
        }
    }
    
    
    public func loadingView(task : NSURLSessionTask, message msg:String! , withView view:UIView!) -> JGProgressHUD{
        let hud : JGProgressHUD =  JGProgressHUD(style: .Dark)
        hud.tapOnHUDViewBlock = { HUD   in
            task.cancel()
            self.showCanceledTaskHint(view)
        }
        hud.tapOutsideBlock  = { HUD   in
            task.cancel()
            self.showCanceledTaskHint(view)
        }
        hud.showInView(view)
        return hud;
    }
    
    public func showCanceledTaskHint(view : UIView){
        let hudNote : JGProgressHUD =  JGProgressHUD(style: .Dark)
        hudNote.indicatorView = JGProgressHUDErrorIndicatorView.init()
        hudNote.progress = 100
        hudNote.textLabel.text = "Connection Cancelled"
        hudNote.showInView(view)
        hudNote.dismissAfterDelay(1)
        
    }
}
