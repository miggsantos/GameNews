//
//  ContainerVC.swift
//  GameNews
//
//  Created by Miguel Santos on 27/10/2017.
//  Copyright © 2017 Miguel Santos. All rights reserved.
//

import UIKit

enum SlideOutState {
    case collapsed
    case leftPanelExpanded
}

enum ShowWichVC {
    case newsVC
    case favoritesVC
    case platformsVC
    case sourcesVC
    case videosVC
    case aboutVC
}

//defualt VC
var showVC: ShowWichVC = .newsVC

class ContainerVC: UIViewController {
    
    var newsVC: NewsVC!
    var leftVC: LeftSideMenuVC!
    var centerController: UIViewController!
    var currentState: SlideOutState = .collapsed {
        didSet {
            let shouldShowShadow = (currentState != .collapsed)
            
            shouldShowShadowForCenterViewController(shouldShowShadow)
        }
    }
    
    var isHidden = false
    let centerPanelExpandedOffset: CGFloat = 100
    
    var tap: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCenter(screen: showVC)
    }
    
    func initCenter(screen: ShowWichVC) {
        var presentingController: UIViewController
        
        showVC = screen
        
        if newsVC == nil {
            newsVC = UIStoryboard.newsVC()
            newsVC.delegate = self
        }
        
        presentingController = newsVC
        
        //Prevent from instantiate multiple copies of the same controller
        if let con = centerController {
            con.view.removeFromSuperview()
            con.removeFromParentViewController()
        }
        
        centerController = presentingController
        
        view.addSubview(centerController.view)
        addChildViewController(centerController)
        centerController.didMove(toParentViewController: self)
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }

}

extension ContainerVC: CenterVCDelegate {
    
    func toogleLeftPanel() {
        let notAlreadyExpanded = ( currentState != .leftPanelExpanded )
        
        if notAlreadyExpanded {
            addLeftPanelViewController()
        }
        animateLeftPanel(shouldExpand: notAlreadyExpanded)
    }
    
    func addLeftPanelViewController() {
        if leftVC == nil {
            leftVC = UIStoryboard.leftViewController()
            addChildSidePanelViewController(leftVC!)
        }
    }
    
    
    
    func addChildSidePanelViewController(_ sidePanelController: LeftSideMenuVC) {
        view.insertSubview(sidePanelController.view, at: 0)
        addChildViewController(sidePanelController)
        sidePanelController.didMove(toParentViewController: self)
    }
    
    @objc func animateLeftPanel(shouldExpand: Bool) {
        if shouldExpand {
            isHidden = !isHidden
            animateStatusBar()
            setupWhiteCoverView()
            currentState = .leftPanelExpanded
            
            animaterCenterPanelXPosition(targetPosition: centerController.view.frame.width - centerPanelExpandedOffset)
            
            
        } else {
            isHidden = !isHidden
            animateStatusBar()
            hideWhiteCoverView()
            
            animaterCenterPanelXPosition(targetPosition: 0, completion: { (finished) in
                if finished {
                    self.currentState = .collapsed
                    self.leftVC = nil
                }
            })
            
        }
    }
    
    func animaterCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil ){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.centerController.view.frame.origin.x = targetPosition
        }, completion: completion)
    }
    
    func shouldShowShadowForCenterViewController(_ status: Bool) {
        if status {
            centerController.view.layer.shadowOpacity = 0.6
        } else {
            centerController.view.layer.shadowOpacity = 0.0
        }
    }
    
    func animateStatusBar(){
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.setNeedsStatusBarAppearanceUpdate()
        })
    }
    
    func setupWhiteCoverView(){
        let whiteCoverView = UIView(frame:  CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        whiteCoverView.alpha = 0.75
        whiteCoverView.backgroundColor = UIColor.white
        whiteCoverView.tag = 25
        
        //self.centerController.view.addSubview(whiteCoverView)
        //whiteCoverView.fadeTo(alphaValue: 0.75, withDuration: 0.2)
        
        
        tap = UITapGestureRecognizer(target: self, action: #selector(animateLeftPanel(shouldExpand:)))
        tap.numberOfTapsRequired = 1
        
        self.centerController.view.addGestureRecognizer(tap)
    }
    
    func hideWhiteCoverView() {
        
        self.centerController.view.removeGestureRecognizer(tap)
        
        for subview in self.centerController.view.subviews{
            if subview.tag == 25 {
                UIView.animate(withDuration: 0.2, animations: {
                    subview.alpha = 0.0
                }, completion: { (finished) in
                    subview.removeFromSuperview()
                })
                break;
            }
        }
    }
    
}


private extension UIStoryboard {
    
    class func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: MAIN_STORYBOARD, bundle: Bundle.main)
    }
    
    class func leftViewController() -> LeftSideMenuVC? {
        return mainStoryboard().instantiateViewController(withIdentifier: VC_LEFT_MENU_PANEL) as? LeftSideMenuVC
    }
    
    class func newsVC() -> NewsVC? {
        return mainStoryboard().instantiateViewController(withIdentifier: VC_NEWS) as? NewsVC
    }
}



