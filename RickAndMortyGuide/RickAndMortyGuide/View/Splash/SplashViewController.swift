//
//  SplashViewController.swift
//  RickAndMortyGuide
//
//  Created by Danilo Bias Lago on 27/11/2018.
//  Copyright © 2018 Danilo Bias Lago. All rights reserved.
//

import UIKit
import RevealingSplashView


class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "splash_v1")!,
                                                      iconInitialSize: CGSize(width: 256, height: 256),
                                                      backgroundColor: UIColor.white)
        
        //Adds the revealing splash view as a sub view
        self.view.addSubview(revealingSplashView)
        
        revealingSplashView.animationType = SplashAnimationType.squeezeAndZoomOut
        
        //Starts animation
        revealingSplashView.startAnimation(){
            print("Completed")
        }

    }

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
