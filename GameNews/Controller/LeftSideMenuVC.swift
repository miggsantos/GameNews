//
//  LeftSideMenuVC.swift
//  GameNews
//
//  Created by Miguel Santos on 27/10/2017.
//  Copyright © 2017 Miguel Santos. All rights reserved.
//

import UIKit

let menuItems = ["All News", "Favorites", "Platforms", "Sources", "Videos", "About"];
let menuItemsVC = [VC_NEWS, VC_ABOUT, VC_ABOUT, VC_ABOUT, VC_ABOUT, VC_ABOUT];


class LeftSideMenuVC: UIViewController {

    var selectedMenuItem = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension LeftSideMenuVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CELL_LEFT_MENU, for: indexPath) as? LeftMenuCell {
            cell.configure(title: menuItems[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let option = menuItemsVC[indexPath.row] as String? {
            
            self.performSegue(withIdentifier: option, sender: self)
        }

    }
 
    
}
