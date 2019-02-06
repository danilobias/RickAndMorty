//
//  UILabel.swift
//  RickAndMortyGuide
//
//  Created by Danilo Bias Lago on 22/01/2019.
//  Copyright © 2019 Danilo Bias Lago. All rights reserved.
//

import UIKit

extension UILabel {
    
    func textDropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 1, height: 2)
    }
}
