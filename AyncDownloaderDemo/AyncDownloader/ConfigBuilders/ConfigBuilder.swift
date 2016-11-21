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
     Max Memory in KBs.
     */
    var maxMemory:Int?
    
    typealias BuilderClosure = (ConfigBuilder) -> ()
    
    init(buildClosure: BuilderClosure) {
        buildClosure(self)
    }
}
 