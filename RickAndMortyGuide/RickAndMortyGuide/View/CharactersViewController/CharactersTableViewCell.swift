//
//  CharactersTableViewCell.swift
//  RickAndMortyGuide
//
//  Created by Danilo Bias Lago on 19/11/2018.
//  Copyright © 2018 Danilo Bias Lago. All rights reserved.
//

import UIKit
import Alamofire
import Cards
import SDWebImage

class CharactersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var card: CardHighlight!
    
    var character: CharacterResult? {
        didSet {
            if let _character = character {
                showCharacterInfo(character: _character)
            }
        }
    }
    
    let manager: SDWebImageManager = SDWebImageManager.shared()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.card.icon = UIImage(named: "placeholder_image")
    }
    
    // MARK: - Customize
    func showCharacterInfo(character: CharacterResult) {

        self.card.title = character.name!
        self.card.backgroundColor = UIColor.GrayColor.defaultGray
        self.card.icon = UIImage(named: "placeholder_image")
        
        if let urlImage = character.image {

            self.manager.loadImage(with: URL(string: urlImage), options: [], progress: { (receivedSize, expectedSize, url) in
                
            }) { (image, data, error, cacheType, finished, url) in
                
                if let finalImage = image {
                    self.card.icon = finalImage
                }
            }
        }
        
        self.card.itemTitle = ""
        self.card.itemSubtitle = ""
        self.card.textColor = UIColor.white
        self.card.buttonText = ""
    }
    
    // MARK: - UITableViewCell Methods
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
