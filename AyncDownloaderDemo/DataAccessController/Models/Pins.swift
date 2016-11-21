//
//  Pins.swift
//
//  Created by Yahia Work on 11/21/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class Pins: NSObject, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kPinsDominantColorKey: String = "dominant_color"
	internal let kPinsPinnerKey: String = "pinner"
	
	internal let kPinsDomainKey: String = "domain"
	internal let kPinsInternalIdentifierKey: String = "id"
	internal let kPinsImagesKey: String = "images"
	internal let kPinsDescriptionValueKey: String = "description"
	internal let kPinsLikeCountKey: String = "like_count"
	internal let kPinsIsVideoKey: String = "is_video"
	internal let kPinsRepinCountKey: String = "repin_count"


    // MARK: Properties
	public var dominantColor: String?
	public var pinner: Pinner?
	
	public var domain: String?
	public var internalIdentifier: String?
	public var images: [Image]?
	public var descriptionValue: String?
	public var likeCount: Int?
	public var isVideo: Bool = false
	public var repinCount: Int?


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
		dominantColor = json[kPinsDominantColorKey].string
		pinner = Pinner(json: json[kPinsPinnerKey])
		
		domain = json[kPinsDomainKey].string
		internalIdentifier = json[kPinsInternalIdentifierKey].string
		images = []
		if let items = json[kPinsImagesKey].dictionary {
            
            for (_, json) in items {
                images?.append(Image(json: json))
            }

		} else {
			images = nil
		}
		descriptionValue = json[kPinsDescriptionValueKey].string
		likeCount = json[kPinsLikeCountKey].int
		
		isVideo = json[kPinsIsVideoKey].boolValue
		
		repinCount = json[kPinsRepinCountKey].int

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if dominantColor != nil {
			dictionary.updateValue(dominantColor!, forKey: kPinsDominantColorKey)
		}
		if pinner != nil {
			dictionary.updateValue(pinner!.dictionaryRepresentation(), forKey: kPinsPinnerKey)
		}
		 
		if domain != nil {
			dictionary.updateValue(domain!, forKey: kPinsDomainKey)
		}
		if internalIdentifier != nil {
			dictionary.updateValue(internalIdentifier!, forKey: kPinsInternalIdentifierKey)
		}
		if images?.count > 0 {
			var temp: [AnyObject] = []
			for item in images! {
				temp.append(item.dictionaryRepresentation())
			}
			dictionary.updateValue(temp, forKey: kPinsImagesKey)
		}
		if descriptionValue != nil {
			dictionary.updateValue(descriptionValue!, forKey: kPinsDescriptionValueKey)
		}
		if likeCount != nil {
			dictionary.updateValue(likeCount!, forKey: kPinsLikeCountKey)
		}
		 
		if repinCount != nil {
			dictionary.updateValue(repinCount!, forKey: kPinsRepinCountKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
		self.dominantColor = aDecoder.decodeObjectForKey(kPinsDominantColorKey) as? String
		self.pinner = aDecoder.decodeObjectForKey(kPinsPinnerKey) as? Pinner
		
		self.domain = aDecoder.decodeObjectForKey(kPinsDomainKey) as? String
		self.internalIdentifier = aDecoder.decodeObjectForKey(kPinsInternalIdentifierKey) as? String
		self.images = aDecoder.decodeObjectForKey(kPinsImagesKey) as? [Image]
		self.descriptionValue = aDecoder.decodeObjectForKey(kPinsDescriptionValueKey) as? String
		self.likeCount = aDecoder.decodeObjectForKey(kPinsLikeCountKey) as? Int
		self.isVideo = aDecoder.decodeBoolForKey(kPinsIsVideoKey)
		self.repinCount = aDecoder.decodeObjectForKey(kPinsRepinCountKey) as? Int

    }

    public func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(dominantColor, forKey: kPinsDominantColorKey)
		aCoder.encodeObject(pinner, forKey: kPinsPinnerKey)
		aCoder.encodeObject(domain, forKey: kPinsDomainKey)
		aCoder.encodeObject(internalIdentifier, forKey: kPinsInternalIdentifierKey)
		aCoder.encodeObject(images, forKey: kPinsImagesKey)
		aCoder.encodeObject(descriptionValue, forKey: kPinsDescriptionValueKey)
		aCoder.encodeObject(likeCount, forKey: kPinsLikeCountKey)
		aCoder.encodeBool(isVideo, forKey: kPinsIsVideoKey)
		aCoder.encodeObject(repinCount, forKey: kPinsRepinCountKey)

    }

}
