//
//  Pinterest.swift
//
//  Created by Yahia Work on 11/21/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class Pinterest: NSObject, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kPinterestHostKey: String = "host"
	internal let kPinterestCodeKey: String = "code"
	internal let kPinterestDataKey: String = "data"
	internal let kPinterestGeneratedAtKey: String = "generated_at"
	internal let kPinterestStatusKey: String = "status"
	internal let kPinterestMessageKey: String = "message"


    // MARK: Properties
	public var host: String?
	public var code: Int?
	public var data: Data?
	public var generatedAt: String?
	public var status: String?
	public var message: String?


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
		host = json[kPinterestHostKey].string
		code = json[kPinterestCodeKey].int
		data = Data(json: json[kPinterestDataKey])
		generatedAt = json[kPinterestGeneratedAtKey].string
		status = json[kPinterestStatusKey].string
		message = json[kPinterestMessageKey].string

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if host != nil {
			dictionary.updateValue(host!, forKey: kPinterestHostKey)
		}
		if code != nil {
			dictionary.updateValue(code!, forKey: kPinterestCodeKey)
		}
		if data != nil {
			dictionary.updateValue(data!.dictionaryRepresentation(), forKey: kPinterestDataKey)
		}
		if generatedAt != nil {
			dictionary.updateValue(generatedAt!, forKey: kPinterestGeneratedAtKey)
		}
		if status != nil {
			dictionary.updateValue(status!, forKey: kPinterestStatusKey)
		}
		if message != nil {
			dictionary.updateValue(message!, forKey: kPinterestMessageKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
		self.host = aDecoder.decodeObjectForKey(kPinterestHostKey) as? String
		self.code = aDecoder.decodeObjectForKey(kPinterestCodeKey) as? Int
		self.data = aDecoder.decodeObjectForKey(kPinterestDataKey) as? Data
		self.generatedAt = aDecoder.decodeObjectForKey(kPinterestGeneratedAtKey) as? String
		self.status = aDecoder.decodeObjectForKey(kPinterestStatusKey) as? String
		self.message = aDecoder.decodeObjectForKey(kPinterestMessageKey) as? String

    }

    public func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(host, forKey: kPinterestHostKey)
		aCoder.encodeObject(code, forKey: kPinterestCodeKey)
		aCoder.encodeObject(data, forKey: kPinterestDataKey)
		aCoder.encodeObject(generatedAt, forKey: kPinterestGeneratedAtKey)
		aCoder.encodeObject(status, forKey: kPinterestStatusKey)
		aCoder.encodeObject(message, forKey: kPinterestMessageKey)

    }

}
