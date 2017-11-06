//
//  NewsVC.swift
//  GameNews
//
//  Created by Miguel Santos on 26/10/2017.
//  Copyright © 2017 Miguel Santos. All rights reserved.
//

import UIKit

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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 
        if segue.identifier == SEGUE_TO_ARTICLE_VC {
            if let detailsVC = segue.destination as? ArticleVC {
                if let index = sender as? Int {
                    detailsVC.selectedIndex = index
                }
            }
        }
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
          
                if let image = DataService.instance.cachedImage(for: p.Image) {
                    cell.newsImage.image = image
                } else {
                    DataService.instance.getImage(imageUrl: p.Image, resize: IMAGE_SIZE_PULSE_NEWS, completion: { (imageResponse) in
                        cell.newsImage.image = imageResponse
                    })
                }
            }

            return cell
            
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: SEGUE_TO_ARTICLE_VC, sender: indexPath.row)
    }

}


