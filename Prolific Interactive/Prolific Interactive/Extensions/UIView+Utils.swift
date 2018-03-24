//
//  UIView+Utils.swift
//  Prolific Interactive
//
//  Created by Pranav Bhandari on 3/23/18.
//  Copyright © 2018 Pranav Bhandari. All rights reserved.
//

import UIKit

@IBDesignable class StyledView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderClr: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderClr.cgColor
        }
    }
    
    @IBInspectable var maskToBounds:Bool = true {
        didSet {
            self.layer.masksToBounds = maskToBounds
        }
    }
}
