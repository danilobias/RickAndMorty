//
//  UIButton.swift
//  RickAndMortyGuide
//
//  Created by Danilo Bias Lago on 28/11/2018.
//  Copyright © 2018 Danilo Bias Lago. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func addBlurEffect() {
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        blur.frame = self.bounds
        blur.isUserInteractionEnabled = false
        self.insertSubview(blur, at: 0)
        if let imageView = self.imageView{
            self.bringSubviewToFront(imageView)
        }
    }
    
    func cornerRadius() {
        self.layer.cornerRadius = frame.height / 2
    }
}
