//
//  ConfigBuilder.swift
//  AyncDownloaderDemo
//
//  Created by Yahia Work on 11/21/16.
//  Copyright © 2016 Yahia. All rights reserved.
//

import Foundation

class ConfigBuilder {
    /**
     Max Cache Memory in MBs.
     */
    var maxCacheMemory:Int?
    
    /**
     If you whant to force reload the data set to true , defualt value false
     */
    var isIgnoreCaching:Bool = false
    
    typealias BuilderClosure = (ConfigBuilder) -> ()
    
    init(buildClosure: BuilderClosure) {
        buildClosure(self)
    }
}
 