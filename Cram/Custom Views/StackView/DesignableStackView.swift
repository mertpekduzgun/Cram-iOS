//
//  DesignableStackView.swift
//  Cram
//
//  Created by Mert on 2.11.2019.
//  Copyright © 2019 Mert. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableStackView: UIStackView {
    
    @IBInspectable var cornerRadius: CGFloat = 0
    
    @IBInspectable var backgroundCGColor: UIColor = UIColor.white {
        didSet {
            let subView = UIView(frame: bounds)
            subView.backgroundColor = backgroundCGColor
            subView.layer.cornerRadius = cornerRadius
            subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            insertSubview(subView, at: 0)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
