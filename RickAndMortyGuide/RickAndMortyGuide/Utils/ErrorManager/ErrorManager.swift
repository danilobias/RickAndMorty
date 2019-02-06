//
//  ErrorManager.swift
//  RickAndMortyGuide
//
//  Created by Danilo Bias Lago on 19/11/2018.
//  Copyright © 2018 Danilo Bias Lago. All rights reserved.
//

import UIKit

enum ErrorType {
    case unknown
    case alamofire
}

struct ErrorManager {
    static func error(type: ErrorType) -> NSError {
        switch type {
        case .unknown:
            return NSError(domain: "Não foi possível acessar no momento.", code: 404, userInfo: nil)
        case .alamofire:
            return NSError(domain: "Erro na requisição...", code: 430, userInfo: nil)
        }
    }
}
