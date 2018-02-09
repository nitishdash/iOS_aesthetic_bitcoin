//
//  GradientBackgroud.swift
//  Aesthetic Bitcoin
//
//  Created by Nitish Dash on 09/02/18.
//  Copyright © 2018 Nitish Dash. All rights reserved.
//

import Foundation
import UIKit

class GradientBackground: UIView {
    override open class var layerClass: AnyClass {
        return CAGradientLayer.classForCoder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let gradientLayer = self.layer as! CAGradientLayer
        gradientLayer.colors = [UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1).cgColor, UIColor.init(red: 44/255, green: 62/255, blue: 80/255, alpha: 1).cgColor]
        
//        gradientLayer.colors = [UIColor.black.cgColor, UIColor.brown.cgColor]
    }
}
