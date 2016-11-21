//
//  Data.swift
//
//  Created by Yahia Work on 11/21/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class Data: NSObject, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kDataPinsKey: String = "pins"


    // MARK: Properties
	public var pins: [Pins]?


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
		pins = []
		if let items = json[kDataPinsKey].array {
			for item in items {
				pins?.append(Pins(json: item))
			}
		} else {
			pins = nil
		}

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if pins?.count > 0 {
			var temp: [AnyObject] = []
			for item in pins! {
				temp.append(item.dictionaryRepresentation())
			}
			dictionary.updateValue(temp, forKey: kDataPinsKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
		self.pins = aDecoder.decodeObjectForKey(kDataPinsKey) as? [Pins]

    }

    public func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(pins, forKey: kDataPinsKey)

    }

}
