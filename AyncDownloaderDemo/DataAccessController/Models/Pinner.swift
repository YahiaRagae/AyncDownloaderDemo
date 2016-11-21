//
//  Pinner.swift
//
//  Created by Yahia Work on 11/21/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class Pinner: NSObject, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.


    // MARK: Properties


    // MARK: SwiftyJSON Initalizers
    /**
    Initates the class based on the object
    - parameter object: The object of either Dictionary or Array kind that was passed.
    - returns: An initalized instance of the class.
    */
    convenience public init(object: AnyObject) {
        self.init(json: JSON(object))
    }

    /**
    Initates the class based on the JSON that was passed.
    - parameter json: JSON object from SwiftyJSON.
    - returns: An initalized instance of the class.
    */
    public init(json: JSON) {

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        let dictionary: [String : AnyObject ] = [ : ]

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {

    }

    public func encodeWithCoder(aCoder: NSCoder) {

    }

}
