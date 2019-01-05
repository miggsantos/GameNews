//
//  NewsVC.swift
//  GameNews
//
//  Created by Miguel Santos on 26/10/2017.
//  Copyright © 2017 Miguel Santos. All rights reserved.
//

import UIKit

var pulses = [Pulse]()
let maxPages = 5
let totalItems = 100
let pageSize = 20
let totalPages = 5



class NewsVC: BaseVC {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    var canLoadData = false
    var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "All News"
        
        sideMenus(menuButton: menuButton)
        customizeNavBar()
        
        tableView.delegate = self
        tableView.dataSource = self
        
 
        getData(offset: 0)

    }
    
    
    func getData(offset:Int){
        
        print("getData News \(offset)")
        
        DataService.getInstance().getNews(offset: offset, completion: { (list) in
 
            pulses.append(contentsOf: list)

            self.tableView.reloadData()
            self.canLoadData = true
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
 
        if (self.currentPage == maxPages
            || self.currentPage == totalPages
            || totalItems == pulses.count) {
            return pulses.count;
        }
        return pulses.count + 1;
        
        //return pulses.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // load more data
        if indexPath.row == pulses.count - 1 && canLoadData {
            print("willDisplay News \(pulses.count)")
            canLoadData = false
            currentPage+=1
            getData(offset: currentPage * pageSize)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell //CELL_NEWS_LOADING
        
        if indexPath.row == pulses.count {
            cell = tableView.dequeueReusableCell(withIdentifier: CELL_NEWS_LOADING, for: indexPath)
            if let activityIndicator = cell.contentView.viewWithTag(100) as? UIActivityIndicatorView {
                activityIndicator.startAnimating()
            }
            return cell
        }
        else if let cell = tableView.dequeueReusableCell(withIdentifier: CELL_NEWS, for: indexPath) as? NewsCell {

            if let p = pulses[indexPath.row] as Pulse? {
                cell.configure(pulse: p)
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


