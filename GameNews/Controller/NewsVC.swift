//
//  NewsVC.swift
//  GameNews
//
//  Created by Miguel Santos on 26/10/2017.
//  Copyright © 2017 Miguel Santos. All rights reserved.
//

import UIKit

class NewsVC: UIViewController {

    var delegate: CenterVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func menuButtonPressed(_ sender: Any) {
        delegate?.toogleLeftPanel()
    }
}

