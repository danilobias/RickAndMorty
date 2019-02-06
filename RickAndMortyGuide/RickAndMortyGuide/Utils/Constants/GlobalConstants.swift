//
//  GlobalConstants.swift
//  RickAndMortyGuide
//
//  Created by Danilo Bias Lago on 22/11/2018.
//  Copyright © 2018 Danilo Bias Lago. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    //MARK: URL's e métodos
    struct APIPreffix {
        static let urlPreffix: String = "https://rickandmortyapi.com/api"
    }
        
    struct URLPaths {
        static let commonPath: String = "/"
        static let concatKey: String = "&"
        static let question: String = "?"
    }
    
    struct CommonMethods {
        static let images: String = "images"
        static let search: String = "search"
    }
    
    struct CharactersMethods {
        static let getCharacters: String = "character"
    }
    
    struct EpisodesMethods {
        static let getEpisodes: String = "episode"
    }

    struct LocationsMethods {
        static let getLocations: String = "location"
    }

    
    struct APIUrls {
        
        static let getCharactersUrl: String = Constants.APIPreffix.urlPreffix + URLPaths.commonPath + CharactersMethods.getCharacters
        static let searchCharactersUrl: String = Constants.APIPreffix.urlPreffix + URLPaths.commonPath + CharactersMethods.getCharacters + URLPaths.commonPath
        
        static let getEpisodesUrl: String = Constants.APIPreffix.urlPreffix + URLPaths.commonPath + EpisodesMethods.getEpisodes
        static let searchEpisodesUrl: String = Constants.APIPreffix.urlPreffix + URLPaths.commonPath + EpisodesMethods.getEpisodes + URLPaths.commonPath
        
        static let getLocationsUrl: String = Constants.APIPreffix.urlPreffix + URLPaths.commonPath + LocationsMethods.getLocations
        static let sarchLocationsUrl: String = Constants.APIPreffix.urlPreffix + URLPaths.commonPath + LocationsMethods.getLocations + URLPaths.commonPath

    }
        
    struct Placeholders {
        static let placeholderImageName: String = "placeholder_custom"
        static let placeholderImage: UIImage = UIImage(named: Constants.Placeholders.placeholderImageName)!
    }
}
