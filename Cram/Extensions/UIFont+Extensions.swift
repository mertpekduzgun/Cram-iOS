//
//  UIFont+Extensions.swift
//  Cram
//
//  Created by Mert on 2.11.2019.
//  Copyright © 2019 Mert. All rights reserved.
//

import UIKit

extension UIFont {
    private static func customFont(name: String, size: CGFloat) -> UIFont {
        let font = UIFont(name: name, size: size)
        return font ?? UIFont.systemFont(ofSize: size)
        
    }
    static func montserratMedium(ofsize size: CGFloat) -> UIFont {
        return customFont(name: "Montserrat-Medium", size: size)

    }
    static func montserratRegular(ofsize size: CGFloat) -> UIFont {
        return customFont(name: "Montserrat-Regular", size: size)

    }
    static func montserratSemiBold(ofsize size: CGFloat) -> UIFont {
        return customFont(name: "Montserrat-SemiBold", size: size)

    }
    static func montserratBold(ofsize size: CGFloat) -> UIFont {
        return customFont(name: "Montserrat-Bold", size: size)

    }
    
}
