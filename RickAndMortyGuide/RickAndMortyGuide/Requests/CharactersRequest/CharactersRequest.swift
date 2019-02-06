//
//  CharactersRequest.swift
//  RickAndMortyGuide
//
//  Created by Danilo Bias Lago on 19/11/2018.
//  Copyright © 2018 Danilo Bias Lago. All rights reserved.
//

import UIKit
import SwiftyJSON

class CharactersRequest: NSObject {
    
    static func getAll(withURL url: String, params: [String: Any]? = nil, completion: @escaping(CharactersResponse?, Error?) -> Void) {
        BaseRequest.get(url, params) { (result) in
            
            if let data = result as? Data {
                
                let json: JSON = JSON(data)
                let charactersResponse: CharactersResponse = CharactersResponse(json: json)
                completion(charactersResponse, nil)

                
            }else if let error = result as? Error {
                completion(nil, error)
            }else{
                completion(nil, ErrorManager.error(type: .unknown))
            }
        }
    }
    
    static func search(withURL url: String, params: [String: Any]? = nil, completion: @escaping(CharactersResponse?, Error?) -> Void) {
        BaseRequest.get(url, params) { (result) in
            
            if let data = result as? Data {
                
                let json: JSON = JSON(data)
                let charactersResponse: CharactersResponse = CharactersResponse(json: json)
                completion(charactersResponse, nil)
                
                
            }else if let error = result as? Error {
                completion(nil, error)
            }else{
                completion(nil, ErrorManager.error(type: .unknown))
            }
        }
    }
}
