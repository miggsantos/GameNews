//
//  ArticleVC.swift
//  GameNews
//
//  Created by Miguel Santos on 05/11/2017.
//  Copyright © 2017 Miguel Santos. All rights reserved.
//

import UIKit


class ArticleVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!

    var selectedIndex:Int!
    var hasSetFirstPosition = false
    
    var collectionViewFlowLayout: UICollectionViewLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let scrollView = collectionView as UIScrollView
        scrollView.delegate = self

        
    }
    
    func getData(offset: Int){

        print("getData Article \(offset)")
        DataService.getInstance().getNews(offset: offset, completion: { (list) in

            pulses.append(contentsOf: list)
            print("Callback Article \(list.count)")
            self.collectionView.reloadData()
        })
    }

}

extension ArticleVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !hasSetFirstPosition {
            //set the row and section you need.
            let indexToScrollTo = IndexPath(row: selectedIndex, section: indexPath.section)
            self.collectionView.scrollToItem(at: indexToScrollTo, at: .left, animated: false)
            hasSetFirstPosition = true
        }
        
        // load more data
        if indexPath.row == pulses.count - 1 {
            getData(offset: pulses.count);
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return pulses.count
        if(pulses.count < 10){
            return pulses.count
        }
        
        let currentPage = (pulses.count / 10)
        
        if (currentPage == totalPages || totalItems == pulses.count) {
            return pulses.count;
        }
        return pulses.count + 1;
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        var cell: UICollectionViewCell
        
        if indexPath.row == pulses.count {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_ARTICLE_LOADING, for: indexPath)
            if let activityIndicator = cell.contentView.viewWithTag(101) as? UIActivityIndicatorView {
                activityIndicator.startAnimating()
            }
            return cell
        }
        else if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_ARTICLE, for: indexPath) as? ArticleCell {

            if let p = pulses[indexPath.row] as Pulse? {
                cell.configure(pulse: p)
                
                cell.buttonOpenPage.addTarget(self, action: #selector(openPage(_:)), for: .touchUpInside)
                cell.buttonOpenPage.pageUrl = p.Url
 
            }
            
            return cell
        }

        return UICollectionViewCell()
    }
    

    
    @objc func openPage(_ button:RoundShadowButton){

        // Bronken in api v3
        /*
        if let url = button.pageUrl {
            self.performSegue(withIdentifier: SEGUE_TO_WEB_VC, sender: url)
        }
        */
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == SEGUE_TO_WEB_VC {
            if let destinationVC = segue.destination as? WebVC {
                if let url = sender as? String {
                    destinationVC.pageUrl = url
                }
            }
        }
    }
    
}

extension ArticleVC: UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.bounds.width
        let itemHeight = collectionView.bounds.height
        return CGSize(width: itemWidth, height: itemHeight)
    }

}
