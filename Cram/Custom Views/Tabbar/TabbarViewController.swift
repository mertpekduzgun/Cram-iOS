//
//  TabbarViewController.swift
//  Cram
//
//  Created by Mert on 3.11.2019.
//  Copyright © 2019 Mert. All rights reserved.
//

import UIKit

class TabbarViewController: UITabBarController, UITabBarControllerDelegate {
    
    var courseViewController: UIViewController!
    var chatViewController: UIViewController!
    var settingViewController: UIViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        courseViewController = UIStoryboard.courses.instantiateInitialViewController()!
        chatViewController = UIStoryboard.chats.instantiateInitialViewController()!
        settingViewController = UIStoryboard.settings.instantiateInitialViewController()!
        
        courseViewController.tabBarItem.image = UIImage(named: "") // TODO: tabbar image
        courseViewController.tabBarItem.selectedImage = UIImage(named: "") // TODO:
        courseViewController.tabBarItem.title = "Courses"
        
        chatViewController.tabBarItem.image = UIImage(named: "") // TODO: tabbar image
        chatViewController.tabBarItem.selectedImage = UIImage(named: "") // TODO:
        chatViewController.tabBarItem.title = "Chats"
        
        settingViewController.tabBarItem.image = UIImage(named: "") // TODO: tabbar image
        settingViewController.tabBarItem.selectedImage = UIImage(named: "") // TODO:
        settingViewController.tabBarItem.title = "Settings"
        
        viewControllers = [courseViewController, chatViewController, settingViewController]
        
        for tabBarItem in tabBar.items! {
            tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.montserratMedium(ofsize: 11)], for: .normal)
            tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)
            tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.flatBlueColorDark], for: .selected)
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
