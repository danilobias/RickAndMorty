//
//  LocationsViewModel.swift
//  RickAndMortyGuide
//
//  Created by Danilo Bias Lago on 19/11/2018.
//  Copyright © 2018 Danilo Bias Lago. All rights reserved.
//

import UIKit

protocol LocationsViewModelProtocol: ListProtocol {
    var response: LocationsResponse? { get }
    var responseDidChange: ((LocationsViewModelProtocol) -> Void)? { get set }
}


class LocationsViewModel: LocationsViewModelProtocol {
    
    // MARK: - Vars
    var url: String = Constants.APIUrls.getLocationsUrl
    var searchUrl: String = Constants.APIUrls.sarchLocationsUrl
    
    var response: LocationsResponse? {
        didSet{
            self.responseDidChange?(self)
        }
    }
    
    var responseDidChange: ((LocationsViewModelProtocol) -> Void)?
    
    // MARK: - Methods
    required init() {}
    
    
    // MARK: - Utils
    func numberOfRows() -> Int{
        return response?.results?.count ?? 0
    }
    
    func getLocationResponseBy(index: Int) -> LocationResult? {
        return response!.results?[index]
    }
    
    func hasNextPage() -> String? {
        if let nextPage = self.response?.info?.next {
            return nextPage
        }
        
        return nil
    }
    
    // MARK: - Request
    func getElement(completion: @escaping (Error?) -> Void) {
                
        LocationsRequest.get(withURL: url) { (episodesResponse, error) in
            
            if let episodes = episodesResponse {
                self.response = episodes
            }
            
            if let errorDetail = error {
                completion(errorDetail)
            }
        }
    }
    
    func searchElement(firstPage: Bool, params: [String: Any], completion: @escaping (Error?) -> Void) {
        
        var currentUrl: String = self.searchUrl
        if firstPage == false {
            if let nextUrl: String = self.hasNextPage() {
                currentUrl = nextUrl
            }
        }

        LocationsRequest.get(withURL: currentUrl, params: params) { (charactersResponse, error) in

            if let characters = charactersResponse {
                if self.response == nil || firstPage == true {

                    self.response = characters

                }else {

                    if let result = characters.results {
                        self.response?.results?.append(contentsOf: result)
                    }

                    self.response?.info = characters.info
                    self.responseDidChange?(self)
                }
            }

            if let errorDetail = error {
                completion(errorDetail)
            }
        }
    }
    
    func getElement(firstPage: Bool, completion: @escaping (Error?) -> Void) {
        
        var currentUrl: String = self.url
        if firstPage == false {
            if let nextUrl: String = self.hasNextPage() {
                currentUrl = nextUrl
            }
        }
        
        print("URL \(currentUrl)")
        LocationsRequest.get(withURL: currentUrl) { (locationsResponse, error) in
            
            if let locations = locationsResponse {
                
                if self.response == nil || firstPage == true {
                    
                    self.response = locations
                    
                }else {
                    
                    if let result = locations.results {
                        self.response?.results?.append(contentsOf: result)
                    }
                    
                    self.response?.info = locations.info
                    self.responseDidChange?(self)
                }
            }
            
            if let errorDetail = error {
                completion(errorDetail)
            }
        }
    }
}
