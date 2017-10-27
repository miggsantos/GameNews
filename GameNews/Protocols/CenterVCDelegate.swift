//
//  CenterVCDelegate.swift
//  GameNews
//
//  Created by Miguel Santos on 27/10/2017.
//  Copyright © 2017 Miguel Santos. All rights reserved.
//

import Foundation

protocol CenterVCDelegate {
    func toogleLeftPanel()
    func addLeftPanelViewController()
    func animateLeftPanel(shouldExpand: Bool)
}
