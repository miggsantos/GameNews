//
//  AboutVC.swift
//  GameNews
//
//  Created by Miguel Santos on 28/10/2017.
//  Copyright © 2017 Miguel Santos. All rights reserved.
//

import UIKit

class AboutVC: BaseVC {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "About"
        
        sideMenus(menuButton: menuButton)
        customizeNavBar()
        
    }
    

}
