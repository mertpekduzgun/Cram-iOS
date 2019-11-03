//
//  UIStoryboardExtensions.swift
//  SwifterSwift
//
//  Created by Steven on 2/6/17.
//  Copyright © 2017 SwifterSwift
//

#if canImport(UIKit)  && !os(watchOS)
import UIKit

// MARK: - Methods
public extension UIStoryboard {

    static var courses: UIStoryboard {
        return UIStoryboard(name: "Courses", bundle: .main)
    }
    
    static var chats: UIStoryboard {
        return UIStoryboard(name: "Chats", bundle: .main)
    }
    
    static var settings: UIStoryboard {
        return UIStoryboard(name: "Settings", bundle: .main)
    }

}

#endif
