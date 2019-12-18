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
    var chatRoomViewController: UIViewController!
    var settingViewController: UIViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        courseViewController = UIStoryboard.courses.instantiateInitialViewController()!
        chatRoomViewController = UIStoryboard.chats.instantiateInitialViewController()!
        settingViewController = UIStoryboard.settings.instantiateInitialViewController()!
        
        courseViewController.tabBarItem.image = UIImage(named: "course") // TODO: tabbar image
        courseViewController.tabBarItem.selectedImage = UIImage(named: "courseSelected") // TODO:
        courseViewController.tabBarItem.title = "Courses"
        
        chatRoomViewController.tabBarItem.image = UIImage(named: "chat") // TODO: tabbar image
        chatRoomViewController.tabBarItem.selectedImage = UIImage(named: "chatSelected") // TODO:
        chatRoomViewController.tabBarItem.title = "Chats"
        
        settingViewController.tabBarItem.image = UIImage(named: "setting") // TODO: tabbar image
        settingViewController.tabBarItem.selectedImage = UIImage(named: "settingSelected") // TODO:
        settingViewController.tabBarItem.title = "Settings"
        
        viewControllers = [courseViewController, chatRoomViewController, settingViewController]
        
        for tabBarItem in tabBar.items! {
            tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.montserratMedium(ofsize: 11)], for: .normal)
//            tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)
//            tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.flatBlueColorDark], for: .selected)
        }
        
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: self.tabBar.frame.size.width, height: 1))
        lineView.backgroundColor = UIColor.black.withAlphaComponent(0.05)
        self.tabBar.addSubview(lineView)
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = self.selectedIndex
        if self.viewControllers![tabBarIndex] == viewController{
            if tabBarController.selectedIndex == 0 {
                let vc = viewController as! UINavigationController
                if vc.viewControllers.count == 1{
                    let indexPath = NSIndexPath(row: 0, section: 0)
                    let navigVC = viewController as? UINavigationController
                    let finalVC = navigVC?.viewControllers[0] as? FacultyViewController
                    finalVC?.tableView.scrollToRow(at: indexPath as IndexPath, at: .top, animated: true)
                }
            }
        }
    }

}
