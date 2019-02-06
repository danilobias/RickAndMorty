//
//  EpisodesViewModel.swift
//  RickAndMortyGuide
//
//  Created by Danilo Bias Lago on 19/11/2018.
//  Copyright © 2018 Danilo Bias Lago. All rights reserved.
//

import UIKit

protocol EpisodesViewModelProtocol: ListProtocol {
    var response: EpisodesResponse? { get }
    var responseDidChange: ((EpisodesViewModelProtocol) -> Void)? { get set }
}


class EpisodesViewModel: EpisodesViewModelProtocol {
    
    // MARK: - Vars
    var url: String = Constants.APIUrls.getEpisodesUrl
    var searchUrl: String =  Constants.APIUrls.searchEpisodesUrl
    
    var response: EpisodesResponse? {
        didSet{
            self.responseDidChange?(self)
        }
    }
    
    var responseDidChange: ((EpisodesViewModelProtocol) -> Void)?
    
    // MARK: - Methods
    required init() {}
    
    
    // MARK: - Utils
    func numberOfRows() -> Int{
        return response?.results?.count ?? 0
    }
    
    func getEpisodeResponseBy(index: Int) -> EpisodeResult? {
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
                
        EpisodesRequest.get(withURL: url) { (episodesResponse, error) in
            
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
        
        EpisodesRequest.get(withURL: currentUrl, params: params) { (charactersResponse, error) in
            
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
        EpisodesRequest.get(withURL: currentUrl) { (episodesResponse, error) in
            
            if let episodes = episodesResponse {
                
                if self.response == nil || firstPage == true {
                    
                    self.response = episodes
                    
                }else {
                    
                    if let result = episodes.results {
                        self.response?.results?.append(contentsOf: result)
                    }
                    
                    self.response?.info = episodes.info
                    self.responseDidChange?(self)
                }
            }
            
            if let errorDetail = error {
                completion(errorDetail)
            }
        }
    }

}
