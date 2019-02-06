//
//  CharacterDetailsViewController.swift
//  RickAndMortyGuide
//
//  Created by Danilo Bias Lago on 22/11/2018.
//  Copyright © 2018 Danilo Bias Lago. All rights reserved.
//

import UIKit

class CharacterDetailsViewController: BaseViewController {
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var lastLocationLabel: UILabel!
    
    @IBOutlet weak var shareButton: UIButton!
    
    var character: CharacterResult!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.showCharacterInfo()
        self.shareButton.addBlurEffect()
        self.shareButton.cornerRadius()
    }
        
    // MARK: - Load Info
    func showCharacterInfo() {
        self.statusLabel.text = self.character.status
        self.speciesLabel.text = self.character.species
        self.genderLabel.text = self.character.gender
        self.originLabel.text = self.character.origin?.name
        self.lastLocationLabel.text = self.character.location?.name
    }
    
    // MARK: - Actions
    @IBAction func share(_ sender: UIButton) {}
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    
}
