//
//  EpisodesRequest.swift
//  RickAndMortyGuide
//
//  Created by Danilo Bias Lago on 19/11/2018.
//  Copyright © 2018 Danilo Bias Lago. All rights reserved.
//

import UIKit
import SwiftyJSON

class EpisodesRequest: NSObject {

    static func get(withURL url: String, params: [String: Any]? = nil, completion: @escaping(EpisodesResponse?, Error?) -> Void) {
        BaseRequest.get(url, params) { (result) in
            
            if let data = result as? Data {
                
                let json: JSON = JSON(data)
                let episodesResponse: EpisodesResponse = EpisodesResponse(json: json)
                completion(episodesResponse, nil)
                
                
            }else if let error = result as? Error {
                completion(nil, error)
            }else{
                completion(nil, ErrorManager.error(type: .unknown))
            }
        }
    }
}
