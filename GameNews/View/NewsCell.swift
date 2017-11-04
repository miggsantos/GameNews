//
//  NewsCell.swift
//  GameNews
//
//  Created by Miguel Santos on 03/11/2017.
//  Copyright © 2017 Miguel Santos. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {


    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var source: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(imageUrl: String, title: String, source: String, date: String) {
        
        self.newsImage.image = UIImage(named: "sampleImage")
        self.title.text = "Call of Duty WWII Players Can Watch Each Other Open Loot Boxes"
        self.source.text = "KOTAKU"
        self.date.text = "Today, 20:10"
        
        
    }
    

}
