//
//  NewsVC.swift
//  GameNews
//
//  Created by Miguel Santos on 26/10/2017.
//  Copyright © 2017 Miguel Santos. All rights reserved.
//

import UIKit

class NewsVC: BaseVC {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "All News"
        
        sideMenus(menuButton: menuButton)
        customizeNavBar()

    }
    
}

