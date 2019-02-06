//
//  Info.swift
//
//  Created by Danilo Bias on 13/11/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class PaginationInfo: NSCoding {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let count = "count"
        static let next = "next"
        static let prev = "prev"
        static let pages = "pages"
    }
    
    // MARK: Properties
    public var count: Int?
    public var next: String?
    public var prev: String?
    public var pages: Int?
    
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
        count = json[SerializationKeys.count].int
        next = json[SerializationKeys.next].string
        prev = json[SerializationKeys.prev].string
        pages = json[SerializationKeys.pages].int
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = count { dictionary[SerializationKeys.count] = value }
        if let value = next { dictionary[SerializationKeys.next] = value }
        if let value = prev { dictionary[SerializationKeys.prev] = value }
        if let value = pages { dictionary[SerializationKeys.pages] = value }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.count = aDecoder.decodeObject(forKey: SerializationKeys.count) as? Int
        self.next = aDecoder.decodeObject(forKey: SerializationKeys.next) as? String
        self.prev = aDecoder.decodeObject(forKey: SerializationKeys.prev) as? String
        self.pages = aDecoder.decodeObject(forKey: SerializationKeys.pages) as? Int
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(count, forKey: SerializationKeys.count)
        aCoder.encode(next, forKey: SerializationKeys.next)
        aCoder.encode(prev, forKey: SerializationKeys.prev)
        aCoder.encode(pages, forKey: SerializationKeys.pages)
    }
    
}
