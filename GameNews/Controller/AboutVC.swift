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
    @IBOutlet weak var versionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "About"
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            self.versionLabel.text = version
        }
        sideMenus(menuButton: menuButton)
        customizeNavBar()
        
    }
    

}
