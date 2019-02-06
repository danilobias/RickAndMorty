//
//  Protocols.swift
//  RickAndMortyGuide
//
//  Created by Danilo Bias Lago on 19/11/2018.
//  Copyright © 2018 Danilo Bias Lago. All rights reserved.
//

import UIKit

protocol InitializerProtocol: class{
    init()
}

protocol Countable: class{
    func numberOfRows() -> Int
}

protocol RequestElement: class{
    func getElement(completion: @escaping(Error?) -> Void)
}

protocol RequestElementURL: class{
    func getElement(withURL url: String, completion: @escaping(Error?) -> Void)
}


protocol SingleElement: InitializerProtocol, RequestElementURL{
    
}

protocol ListProtocol: InitializerProtocol, Countable, RequestElement{
    
}

protocol ListParamURLProtocol: InitializerProtocol, Countable, RequestElementURL{
    
}
