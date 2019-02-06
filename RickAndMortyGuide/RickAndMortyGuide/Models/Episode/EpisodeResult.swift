//
//  Results.swift
//
//  Created by Danilo Bias on 13/11/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON
import AXPhotoViewer
import FirebaseStorage
import FirebaseUI

public class EpisodeResult: NSCoding {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let airDate = "air_date"
        static let name = "name"
        static let id = "id"
        static let created = "created"
        static let episode = "episode"
        static let url = "url"
        static let characters = "characters"
    }
    
    // MARK: Properties
    public var airDate: String?
    public var name: String?
    public var id: Int?
    public var created: String?
    public var episode: String?
    public var url: String?
    public var characters: [String]?
    
    public var episodeImage: UIImage?
    
    public var photos: [AXPhoto] = []
    
    
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
        airDate = json[SerializationKeys.airDate].string
        name = json[SerializationKeys.name].string
        id = json[SerializationKeys.id].int
        created = json[SerializationKeys.created].string
        episode = json[SerializationKeys.episode].string
        url = json[SerializationKeys.url].string
        if let items = json[SerializationKeys.characters].array { characters = items.map { $0.stringValue } }
        
        if let episodeId = self.id {
            // Reference to an image file in Firebase Storage
            let firebaseStorage = Storage.storage()
            let reference = firebaseStorage.reference().child("Episodes/\(episodeId).jpg")
            
            // UIImageView in your ViewController
            let imageView: UIImageView = UIImageView()
            
            // Load the image using SDWebImage
            imageView.sd_setImage(with: reference, placeholderImage: Constants.Placeholders.placeholderImage) { (image, error, cachedType, storeReference) in
                
                if image != nil {
                    self.episodeImage = image
                    
                    let attributedName: NSAttributedString = NSAttributedString(string: self.name ?? "")
                    let attributedDescription: NSAttributedString = NSAttributedString(string: self.episode ?? "")
                    
                    let axPhoto: AXPhoto = AXPhoto(attributedTitle: attributedName,
                                                   attributedDescription: attributedDescription,                                                   
                                                   image: image!)
                    
                    self.photos.append(axPhoto)
                }
            }
        }
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = airDate { dictionary[SerializationKeys.airDate] = value }
        if let value = name { dictionary[SerializationKeys.name] = value }
        if let value = id { dictionary[SerializationKeys.id] = value }
        if let value = created { dictionary[SerializationKeys.created] = value }
        if let value = episode { dictionary[SerializationKeys.episode] = value }
        if let value = url { dictionary[SerializationKeys.url] = value }
        if let value = characters { dictionary[SerializationKeys.characters] = value }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.airDate = aDecoder.decodeObject(forKey: SerializationKeys.airDate) as? String
        self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
        self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
        self.created = aDecoder.decodeObject(forKey: SerializationKeys.created) as? String
        self.episode = aDecoder.decodeObject(forKey: SerializationKeys.episode) as? String
        self.url = aDecoder.decodeObject(forKey: SerializationKeys.url) as? String
        self.characters = aDecoder.decodeObject(forKey: SerializationKeys.characters) as? [String]
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(airDate, forKey: SerializationKeys.airDate)
        aCoder.encode(name, forKey: SerializationKeys.name)
        aCoder.encode(id, forKey: SerializationKeys.id)
        aCoder.encode(created, forKey: SerializationKeys.created)
        aCoder.encode(episode, forKey: SerializationKeys.episode)
        aCoder.encode(url, forKey: SerializationKeys.url)
        aCoder.encode(characters, forKey: SerializationKeys.characters)
    }
    
}
