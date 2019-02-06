//
//  EpisodesTableViewCell.swift
//  RickAndMortyGuide
//
//  Created by Danilo Bias Lago on 28/11/2018.
//  Copyright © 2018 Danilo Bias Lago. All rights reserved.
//

import UIKit
import Cards
import FirebaseStorage

class EpisodesTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: CardHighlight!
    
    let placeholder: UIImage = UIImage(named: "placeholder_custom")!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.cardView.backgroundImage = self.placeholder
    }
    
    // MARK: - Customize
    func showEpisodeInfo(episode: EpisodeResult, firebaseStorage: Storage) {
        
        self.cardView.title = episode.name!
        self.cardView.backgroundColor = UIColor.GrayColor.defaultGray
        
        if let image = episode.episodeImage {
            self.cardView.backgroundImage = image
        }
        
        self.cardView.itemTitle = episode.episode!
        self.cardView.itemSubtitle = ""
        self.cardView.textColor = UIColor.white
        self.cardView.buttonText = ""
    }
    
    // MARK: - UITableViewCell Methods
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
