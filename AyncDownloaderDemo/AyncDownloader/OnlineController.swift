//
//  OnlineController.swift
//  AyncDownloaderDemo
//
//  Created by Yahia Work on 11/21/16.
//  Copyright © 2016 Yahia. All rights reserved.
//

import Foundation
import UIKit

@objc  class OnlineController : NSObject {

    var session: NSURLSession!

    class var sharedInstance: OnlineController {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: OnlineController? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = OnlineController()
        }
        return Static.instance!
    }
    
    
    override init() {
        super.init()
        
         
        let configuration : NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.URLCache = NSURLCache.sharedURLCache()
        
        if(NSUserDefaults.standardUserDefaults().boolForKey(AyncDownloader.UD_CONFIG_IGNORE_CACHING)){
            configuration.requestCachePolicy = .ReloadIgnoringLocalCacheData
        }else{
            configuration.requestCachePolicy = .ReturnCacheDataElseLoad
        }
        session = NSURLSession(configuration: configuration)
        
        
    }
    
    internal func getRequest(  link:String , withCompletion completion:(response  : Response  , status : Bool )->Void )->NSURLSessionTask{
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true

        let url = NSURL(string: link)
        let task : NSURLSessionDataTask = session.dataTaskWithURL(url!) {  data, response, error in
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            var status : Bool = false
            if  ( error == nil )  {
                status = true ;
            }
            dispatch_async(dispatch_get_main_queue()) {
                completion(response: Response.init(error: error, response: response, data: data) , status: status)
            }            
        }
        task.resume()
        return task;
    }
    
    internal func getFile(  link:String , withCompletion completion:(response  : Response  , status : Bool )->Void )->NSURLSessionTask{
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        let url = NSURL(string: link)
        let task : NSURLSessionDownloadTask = session.downloadTaskWithURL(url!) {  nsurl,response, error in
            var status : Bool = false
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            if  ( error == nil )  {
                status = true ;
            }

            if(status){
                let data : NSData = NSData(contentsOfURL: nsurl!)!
                
                dispatch_async(dispatch_get_main_queue()) {
                    completion(response: Response.init(error: error, response: response, data: data) , status: status)
                }
            }

        }
        task.resume()
        return task;
    }
}
