//
//  ArticleVC.swift
//  GameNews
//
//  Created by Miguel Santos on 05/11/2017.
//  Copyright © 2017 Miguel Santos. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

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
        
        //collectionView?.decelerationRate = UIScrollViewDecelerationRateFast
     
        //collectionView.collectionViewLayout = SnappingVCLayout()
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionViewFlowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
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
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pulses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_ARTICLE, for: indexPath) as? ArticleCell {

            if let p = pulses[indexPath.row] as Pulse? {
                cell.configureCell(pulse: p)
                
                cell.buttonOpenPage.addTarget(self, action: #selector(openPage(_:)), for: .touchUpInside)
                cell.buttonOpenPage.pageUrl = p.Url
                
                Alamofire.request(p.Image).responseImage { response in
                    //debugPrint(response)
                    
                    if let image = response.result.value {
                        cell.imageArticle.image = image.af_imageAspectScaled(toFill: IMAGE_SIZE_PULSE_ARTICLE)
                    }
                }
            }

            return cell
        }

        return UICollectionViewCell()
    }
    
    @objc func openPage(_ button:RoundShadowButton){
        
        if let url = button.pageUrl {
            self.performSegue(withIdentifier: SEGUE_TO_WEB_VC, sender: url)
        }
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




