//
//  GradientView.swift
//  GameNews
//
//  Created by Miguel Santos on 21/11/2017.
//  Copyright © 2017 Miguel Santos. All rights reserved.
//

import UIKit

class GradientView: UIView {

    let gradient = CAGradientLayer()
    
    override func awakeFromNib() {
        setupGradientView()
    }
    
    func setupGradientView() {
        gradient.frame = self.bounds
        //gradient.colors = [UIColor.white.cgColor, UIColor.init(white: 1.0, alpha: 0.0).cgColor]
        gradient.colors = [UIColor.black.cgColor, UIColor.init(white: 1.0, alpha: 0.0).cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint.zero
        //where the colors should stop
        //gradient.locations = [0.8, 1.0]
        gradient.locations = [0.2, 0.8]
        self.layer.addSublayer(gradient)
    }

}
