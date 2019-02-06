//
//  Origin.swift
//
//  Created by Danilo Bias on 13/11/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class Origin: NSCoding {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let name = "name"
        static let url = "url"
    }
    
    // MARK: Properties
    public var name: String?
    public var url: String?
    
    // MARK: SwiftyJSON Initializers
    /// Initiates the instance based on the object.
    ///
    /// - parameter object: The object of either Dictionary or Array kind that was passed.
    /// - returns: An initialized instance of the class.
    public convenience init(object: Any) {
        self.init(json: JSON(object))
    }
    
    /// Initiates the instance based on the JSON that was passed.
    ///
    /// - parameter json: JSON object from SwiftyJSON.
    public required init(json: JSON) {
        name = json[SerializationKeys.name].string
        url = json[SerializationKeys.url].string
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        
        if let value = name {
            dictionary[SerializationKeys.name] = value
        }
        
        if let value = url {
            dictionary[SerializationKeys.url] = value
        }
        
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
        self.url = aDecoder.decodeObject(forKey: SerializationKeys.url) as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: SerializationKeys.name)
        aCoder.encode(url, forKey: SerializationKeys.url)
    }
    
}
