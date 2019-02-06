//
//  Results.swift
//
//  Created by Danilo Bias on 13/11/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class CharacterResult: NSCoding {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let status = "status"
        static let location = "location"
        static let origin = "origin"
        static let id = "id"
        static let image = "image"
        static let created = "created"
        static let name = "name"
        static let gender = "gender"
        static let type = "type"
        static let episode = "episode"
        static let url = "url"
        static let species = "species"
    }
    
    // MARK: Properties
    public var status: String?
    public var location: Location?
    public var origin: Origin?
    public var id: Int?
    public var image: String?
    public var created: String?
    public var name: String?
    public var gender: String?
    public var type: String?
    public var episode: [String]?
    public var url: String?
    public var species: String?
    
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
        status = json[SerializationKeys.status].string
        location = Location(json: json[SerializationKeys.location])
        origin = Origin(json: json[SerializationKeys.origin])
        id = json[SerializationKeys.id].int
        image = json[SerializationKeys.image].string
        created = json[SerializationKeys.created].string
        name = json[SerializationKeys.name].string
        gender = json[SerializationKeys.gender].string
        type = json[SerializationKeys.type].string
        if let items = json[SerializationKeys.episode].array { episode = items.map { $0.stringValue } }
        url = json[SerializationKeys.url].string
        species = json[SerializationKeys.species].string
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = status { dictionary[SerializationKeys.status] = value }
        if let value = location { dictionary[SerializationKeys.location] = value.dictionaryRepresentation() }
        if let value = origin { dictionary[SerializationKeys.origin] = value.dictionaryRepresentation() }
        if let value = id { dictionary[SerializationKeys.id] = value }
        if let value = image { dictionary[SerializationKeys.image] = value }
        if let value = created { dictionary[SerializationKeys.created] = value }
        if let value = name { dictionary[SerializationKeys.name] = value }
        if let value = gender { dictionary[SerializationKeys.gender] = value }
        if let value = type { dictionary[SerializationKeys.type] = value }
        if let value = episode { dictionary[SerializationKeys.episode] = value }
        if let value = url { dictionary[SerializationKeys.url] = value }
        if let value = species { dictionary[SerializationKeys.species] = value }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.status = aDecoder.decodeObject(forKey: SerializationKeys.status) as? String
        self.location = aDecoder.decodeObject(forKey: SerializationKeys.location) as? Location
        self.origin = aDecoder.decodeObject(forKey: SerializationKeys.origin) as? Origin
        self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
        self.image = aDecoder.decodeObject(forKey: SerializationKeys.image) as? String
        self.created = aDecoder.decodeObject(forKey: SerializationKeys.created) as? String
        self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
        self.gender = aDecoder.decodeObject(forKey: SerializationKeys.gender) as? String
        self.type = aDecoder.decodeObject(forKey: SerializationKeys.type) as? String
        self.episode = aDecoder.decodeObject(forKey: SerializationKeys.episode) as? [String]
        self.url = aDecoder.decodeObject(forKey: SerializationKeys.url) as? String
        self.species = aDecoder.decodeObject(forKey: SerializationKeys.species) as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(status, forKey: SerializationKeys.status)
        aCoder.encode(location, forKey: SerializationKeys.location)
        aCoder.encode(origin, forKey: SerializationKeys.origin)
        aCoder.encode(id, forKey: SerializationKeys.id)
        aCoder.encode(image, forKey: SerializationKeys.image)
        aCoder.encode(created, forKey: SerializationKeys.created)
        aCoder.encode(name, forKey: SerializationKeys.name)
        aCoder.encode(gender, forKey: SerializationKeys.gender)
        aCoder.encode(type, forKey: SerializationKeys.type)
        aCoder.encode(episode, forKey: SerializationKeys.episode)
        aCoder.encode(url, forKey: SerializationKeys.url)
        aCoder.encode(species, forKey: SerializationKeys.species)
    }
    
}
