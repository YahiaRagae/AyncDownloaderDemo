//
//  Response.swift
//  AyncDownloaderDemo
//
//  Created by Yahia Work on 11/21/16.
//  Copyright © 2016 Yahia. All rights reserved.
//

import Foundation
public struct Response  {
    /// The URL request sent to the server.
    public let error: NSError?
    
    /// The server's response to the URL request.
    public let response: NSURLResponse?
    
    /// The data returned by the server.
    public let data: NSData?
 
    public init(
        error: NSError?,
        response: NSURLResponse?,
        data: NSData? )
    {
        self.error = error
        self.response = response
        self.data = data
    }
}