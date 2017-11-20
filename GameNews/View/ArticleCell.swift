//
//  ArticleCell.swift
//  GameNews
//
//  Created by Miguel Santos on 05/11/2017.
//  Copyright © 2017 Miguel Santos. All rights reserved.
//

import UIKit
import AlamofireImage

class ArticleCell: UICollectionViewCell {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSummary: UILabel!
    @IBOutlet weak var imageArticle: UIImageView!
    @IBOutlet weak var buttonOpenPage: RoundShadowButton!
    
    let placeholderImage = UIImage(named: "placeholder")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.sizeToFit()
    }
    
    func configure(pulse: Pulse){
        
        self.labelTitle.text = pulse.Title
        self.labelSummary.text = pulse.Summary
        
        let size = imageArticle.frame.size
        if pulse.Image != "" {
            self.imageArticle.af_setImage(
                withURL: URL(string: pulse.Image)!,
                placeholderImage: placeholderImage,
                filter: AspectScaledToFillSizeFilter(size: size),
                imageTransition: .crossDissolve(0.2)
            )
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageArticle.af_cancelImageRequest()
        imageArticle.layer.removeAllAnimations()
        imageArticle.image = nil
    }
    

    
    
    
}

