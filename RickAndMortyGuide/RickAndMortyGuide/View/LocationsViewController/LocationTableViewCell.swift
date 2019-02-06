//
//  LocationTableViewCell.swift
//  RickAndMortyGuide
//
//  Created by Danilo Bias Lago on 28/11/2018.
//  Copyright © 2018 Danilo Bias Lago. All rights reserved.
//

import UIKit
import Cards
import FirebaseStorage
import FirebaseUI

class LocationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    let placeholder: UIImage = UIImage(named: "placeholder_custom")!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.defaultLayoutConfig()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.defaultLayoutConfig()
    }
    
    func defaultLayoutConfig() {
        self.backgroundImageView.contentMode = .scaleAspectFit
        self.backgroundImageView.image = placeholder
        self.backgroundImageView.layer.cornerRadius = 20
        self.containerView.addShadow()
        self.titleLabel.textDropShadow()
        self.subtitleLabel.textDropShadow()
        self.descriptionLabel.textDropShadow()
        
        self.titleLabel.textColor = .lightGray
        self.subtitleLabel.textColor = .lightGray
        self.descriptionLabel.textColor = .lightGray
    }
    
    // MARK: - Customize
    func showLocationInfo(location: LocationResult, firebaseStorage: Storage) {
        
        self.containerView.addShadow()
        
        self.titleLabel.text = location.name!.uppercased()
        self.subtitleLabel.text = location.type!.uppercased()
        self.descriptionLabel.text = location.dimension ?? ""

        if let image = location.planetImage {
            
            self.backgroundImageView.image = image
            self.backgroundImageView.contentMode = .scaleAspectFill
            
            self.titleLabel.textColor = .white
            self.subtitleLabel.textColor = .white
            self.descriptionLabel.textColor = .white
        }
    }
    
    // MARK: - UITableViewCell Methods
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
