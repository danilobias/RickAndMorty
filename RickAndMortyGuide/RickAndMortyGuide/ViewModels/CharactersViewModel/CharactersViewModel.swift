//
//  CharactersViewModel.swift
//  RickAndMortyGuide
//
//  Created by Danilo Bias Lago on 19/11/2018.
//  Copyright © 2018 Danilo Bias Lago. All rights reserved.
//

import UIKit

protocol CharactersViewModelProtocol: ListProtocol {
    var response: CharactersResponse? { get }
    var responseDidChange: ((CharactersViewModelProtocol) -> Void)? { get set }
}


class CharactersViewModel: CharactersViewModelProtocol {
    
    // MARK: - Vars
    var url: String = Constants.APIUrls.getCharactersUrl
    var searchUrl: String = Constants.APIUrls.searchCharactersUrl
    
    var response: CharactersResponse? {
        didSet{
            self.responseDidChange?(self)
        }
    }
    
    var responseDidChange: ((CharactersViewModelProtocol) -> Void)?
    
    // MARK: - Methods
    required init() {}
    
    
    // MARK: - Utils
    func numberOfRows() -> Int {
        return response?.results?.count ?? 0
    }
    
    func getCharacterResponseBy(index: Int) -> CharacterResult? {
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
        
    }
    
    func searchElement(firstPage: Bool, params: [String: Any], completion: @escaping (Error?) -> Void) {
        
        var currentUrl: String = self.searchUrl
        if firstPage == false {
            if let nextUrl: String = self.hasNextPage() {
                currentUrl = nextUrl
            }
        }
        
        CharactersRequest.search(withURL: currentUrl, params: params) { (charactersResponse, error) in
            
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
        CharactersRequest.getAll(withURL: currentUrl) { (charactersResponse, error) in
            
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
}
