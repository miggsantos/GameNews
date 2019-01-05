//
//  NewsCell.swift
//  GameNews
//
//  Created by Miguel Santos on 03/11/2017.
//  Copyright © 2017 Miguel Santos. All rights reserved.
//

import UIKit
import AlamofireImage

class NewsCell: UITableViewCell {


    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var source: UILabel!
    @IBOutlet weak var date: UILabel!
    
    let placeholderImage = UIImage(named: "placeholder")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure() {
        
        self.newsImage.image = UIImage(named: "sampleImage")
        self.title.text = "Call of Duty WWII Players Can Watch Each Other Open Loot Boxes"
        self.source.text = "KOTAKU"
        self.date.text = "Today, 20:10"

    }
    
    func configure(pulse: Pulse) {
        
        self.title.text = pulse.Title
        self.source.text = pulse.Source
        self.date.text = pulse.PublishDate
        
        let size = newsImage.frame.size
        if pulse.Image != "" {
            self.newsImage.af_setImage(
                withURL: URL(string: pulse.Image)!,
                placeholderImage: placeholderImage,
                filter: AspectScaledToFillSizeFilter(size: size),
                imageTransition: .crossDissolve(0.2)
            )
        }

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        newsImage.af_cancelImageRequest()
        newsImage.layer.removeAllAnimations()
        newsImage.image = nil
    }

}
