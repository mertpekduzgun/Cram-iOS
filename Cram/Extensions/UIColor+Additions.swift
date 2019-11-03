//
//  UIColor+Additions.swift
//  Cram
//
//  Created by Mert on 2.11.2019.
//  Copyright © 2019 Mert. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    @nonobjc class var cramBlue: UIColor {
        return UIColor(red: 52.0, green: 152.0, blue: 219.0, alpha: 1.0)
    }
    
    @nonobjc class var cramBlack: UIColor {
        return UIColor(red: 22.0, green: 31.0, blue: 61.0, alpha: 1.0)
    }
}
