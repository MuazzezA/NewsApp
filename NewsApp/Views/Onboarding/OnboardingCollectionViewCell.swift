//
//  OnboardingCollectionViewCell.swift
//  NewsApp
//
//  Created by Muazzez Aydın on 10.09.2023.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    func setup(_ slide:OnboardingSlide){
        descriptionLabel.text = slide.description
        titleLabel.text = slide.title
        image.image = slide.image
        
    }
}
