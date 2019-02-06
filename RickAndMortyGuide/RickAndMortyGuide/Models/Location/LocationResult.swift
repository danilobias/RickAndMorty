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

public class LocationResult: NSCoding {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let name = "name"
        static let residents = "residents"
        static let id = "id"
        static let created = "created"
        static let dimension = "dimension"
        static let type = "type"
        static let url = "url"
    }
    
    // MARK: Properties
    public var name: String?
    public var residents: [String]?
    public var id: Int?
    public var created: String?
    public var dimension: String?
    public var type: String?
    public var url: String?
    public var planetImage: UIImage?
    
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
        self.name = json[SerializationKeys.name].string
        if let items = json[SerializationKeys.residents].array {
            self.residents = items.map { $0.stringValue }
        }
        self.id = json[SerializationKeys.id].int
        self.created = json[SerializationKeys.created].string
        self.dimension = json[SerializationKeys.dimension].string
        self.type = json[SerializationKeys.type].string
        self.url = json[SerializationKeys.url].string
                
        if let locationId = self.id {
            // Reference to an image file in Firebase Storage
            let firebaseStorage = Storage.storage()
            let reference = firebaseStorage.reference().child("Planets/\(locationId).jpg")
            
            // UIImageView in your ViewController
            let imageView: UIImageView = UIImageView()
            
            // Load the image using SDWebImage
            imageView.sd_setImage(with: reference, placeholderImage: Constants.Placeholders.placeholderImage) { (image, error, cachedType, storeReference) in
                
                if image != nil {
                    self.planetImage = image
                    
                    let attributedName: NSAttributedString = NSAttributedString(string: self.name ?? "")
                    let attributedDescription: NSAttributedString = NSAttributedString(string: self.type ?? "")
                    let attributedCredit: NSAttributedString = NSAttributedString(string: self.dimension ?? "")
                    
                    let axPhoto: AXPhoto = AXPhoto(attributedTitle: attributedName,
                                                   attributedDescription: attributedDescription,
                                                   attributedCredit: attributedCredit,
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
        if let value = name { dictionary[SerializationKeys.name] = value }
        if let value = residents { dictionary[SerializationKeys.residents] = value }
        if let value = id { dictionary[SerializationKeys.id] = value }
        if let value = created { dictionary[SerializationKeys.created] = value }
        if let value = dimension { dictionary[SerializationKeys.dimension] = value }
        if let value = type { dictionary[SerializationKeys.type] = value }
        if let value = url { dictionary[SerializationKeys.url] = value }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
        self.residents = aDecoder.decodeObject(forKey: SerializationKeys.residents) as? [String]
        self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
        self.created = aDecoder.decodeObject(forKey: SerializationKeys.created) as? String
        self.dimension = aDecoder.decodeObject(forKey: SerializationKeys.dimension) as? String
        self.type = aDecoder.decodeObject(forKey: SerializationKeys.type) as? String
        self.url = aDecoder.decodeObject(forKey: SerializationKeys.url) as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: SerializationKeys.name)
        aCoder.encode(residents, forKey: SerializationKeys.residents)
        aCoder.encode(id, forKey: SerializationKeys.id)
        aCoder.encode(created, forKey: SerializationKeys.created)
        aCoder.encode(dimension, forKey: SerializationKeys.dimension)
        aCoder.encode(type, forKey: SerializationKeys.type)
        aCoder.encode(url, forKey: SerializationKeys.url)
    }
}
