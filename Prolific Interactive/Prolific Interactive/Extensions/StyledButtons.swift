//
//  StyledButtons.swift
//  Prolific Interactive
//
//  Created by Pranav Bhandari on 3/22/18.
//  Copyright © 2018 Pranav Bhandari. All rights reserved.
//

import UIKit

@IBDesignable class StyledButtons: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var backgroundClr: UIColor = UIColor.clear {
        didSet {
            self.layer.backgroundColor = backgroundClr.cgColor
        }
    }
    
    @IBInspectable var borderClr: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderClr.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
}
