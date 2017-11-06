//
//  ArticleCell.swift
//  GameNews
//
//  Created by Miguel Santos on 05/11/2017.
//  Copyright © 2017 Miguel Santos. All rights reserved.
//

import UIKit

class ArticleCell: UICollectionViewCell {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSummary: UILabel!
    @IBOutlet weak var imageArticle: UIImageView!
    @IBOutlet weak var buttonOpenPage: RoundShadowButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.sizeToFit()
    }
    
    func configureCell(pulse: Pulse){
        
        self.labelTitle.text = pulse.Title
        self.labelSummary.text = pulse.Summary
    }
    

    
    
    
}

