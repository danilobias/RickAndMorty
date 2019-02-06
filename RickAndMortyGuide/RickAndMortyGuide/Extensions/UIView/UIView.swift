//
//  UIView.swift
//  RickAndMortyGuide
//
//  Created by Danilo Bias Lago on 22/01/2019.
//  Copyright © 2019 Danilo Bias Lago. All rights reserved.
//

import UIKit

extension UIView {

    func addShadow() {
        self.layer.shadowOpacity = 0.6
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 14
        self.layer.cornerRadius = 20
    }
}

