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
        return UIStoryboard(name: "Course", bundle: .main)
    }
    
    static var chats: UIStoryboard {
        return UIStoryboard(name: "Chat", bundle: .main)
    }
    
    static var settings: UIStoryboard {
        return UIStoryboard(name: "Setting", bundle: .main)
    }
    
    static var auth: UIStoryboard {
        return UIStoryboard(name: "Auth", bundle: .main)
    }

}

#endif
