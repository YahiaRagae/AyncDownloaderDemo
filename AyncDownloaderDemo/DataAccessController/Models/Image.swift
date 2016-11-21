//
//  Image.swift
//
//  Created by Yahia Work on 11/21/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class Image: NSObject, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kImageWidthKey: String = "width"
	internal let kImageHeightKey: String = "height"
	internal let kImageUrlKey: String = "url"


    // MARK: Properties
	public var width: Int?
	public var height: Int?
	public var url: String?


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
		width = json[kImageWidthKey].int
		height = json[kImageHeightKey].int
		url = json[kImageUrlKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if width != nil {
			dictionary.updateValue(width!, forKey: kImageWidthKey)
		}
		if height != nil {
			dictionary.updateValue(height!, forKey: kImageHeightKey)
		}
		if url != nil {
			dictionary.updateValue(url!, forKey: kImageUrlKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
		self.width = aDecoder.decodeObjectForKey(kImageWidthKey) as? Int
		self.height = aDecoder.decodeObjectForKey(kImageHeightKey) as? Int
		self.url = aDecoder.decodeObjectForKey(kImageUrlKey) as? String

    }

    public func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(width, forKey: kImageWidthKey)
		aCoder.encodeObject(height, forKey: kImageHeightKey)
		aCoder.encodeObject(url, forKey: kImageUrlKey)

    }

}
