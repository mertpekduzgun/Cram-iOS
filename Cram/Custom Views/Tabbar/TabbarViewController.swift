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
        
//        courseViewController = UIStoryboard(name: "Courses", bundle: .main)
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
