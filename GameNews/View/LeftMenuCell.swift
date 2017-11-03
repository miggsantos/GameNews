//
//  LeftMenuCell.swift
//  GameNews
//
//  Created by Miguel Santos on 27/10/2017.
//  Copyright © 2017 Miguel Santos. All rights reserved.
//

import UIKit

class LeftMenuCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(title: String){
        self.title.text = title
    }
    



}
