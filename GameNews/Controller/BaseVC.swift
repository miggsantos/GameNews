//
//  BaseVC.swift
//  GameNews
//
//  Created by Miguel Santos on 03/11/2017.
//  Copyright © 2017 Miguel Santos. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func sideMenus(menuButton: UIBarButtonItem) {
        
        if revealViewController() != nil {
            
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 275
            revealViewController().rightViewRevealWidth = 160
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
    }
    
    func customizeNavBar() {

        navigationController?.navigationBar.tintColor = COLOR_GN_ORANGE
        navigationController?.navigationBar.barTintColor = COLOR_GN_DARK_GRAY
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: COLOR_GN_ORANGE]
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent 
    }


}
