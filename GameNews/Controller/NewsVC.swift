//
//  NewsVC.swift
//  GameNews
//
//  Created by Miguel Santos on 26/10/2017.
//  Copyright © 2017 Miguel Santos. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

var pulses = [Pulse]()

class NewsVC: BaseVC {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "All News"
        
        sideMenus(menuButton: menuButton)
        customizeNavBar()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        DataService.instance.getNews(completion: { (list) in
            
            print("Callback \(list.count)")
            
            pulses = list
            
            self.tableView.reloadData()
        })
        
        

    }
    
}

extension NewsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pulses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: CELL_NEWS, for: indexPath) as? NewsCell {

            
            if let p = pulses[indexPath.row] as Pulse? {
                cell.configure(pulse: p)
          
                Alamofire.request(p.Image).responseImage { response in
                    //debugPrint(response)
                    
                    if let image = response.result.value {
                        cell.newsImage.image = image.af_imageAspectScaled(toFill: IMAGE_SIZE_PULSE_NEWS)
                    }
                }
              }
            
            
            return cell
            
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
    
    
    
}

