//
//  AppDelegate.swift
//  Cram
//
//  Created by Mert on 1.11.2019.
//  Copyright © 2019 Mert. All rights reserved.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift
import ChameleonFramework

public struct App {
    static var shared = App()

}

@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    internal var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        IQKeyboardManager.shared.enable = true
        
        FirebaseApp.configure()
        
        if Auth.auth().currentUser != nil {
            self.window?.rootViewController = UIStoryboard.tabbar.instantiateInitialViewController()
        } else {
            self.window?.rootViewController = UIStoryboard.auth.instantiateInitialViewController()
        }
        
        let tabbar = UITabBar.appearance()
        tabbar.tintColor = UIColor.flatSkyBlueColorDark()
        tabbar.setColors(background: .white, selectedBackground: .clear, item: .lightGray, selectedItem: UIColor.flatSkyBlueColorDark())
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    


}

