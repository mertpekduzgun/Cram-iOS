//
//  SettingViewController.swift
//  Cram
//
//  Created by Mert on 17.11.2019.
//  Copyright © 2019 Mert. All rights reserved.
//

import UIKit
import Firebase

class SettingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func logoutAction(_ sender: Any) {
        do {
            
            let alert = UIAlertController(title: "Logout!", message: "Are you sure you want to sign out?", preferredStyle: .alert)
            
             let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { (alert) in
                self.dismiss(animated: false, completion: nil)
            })
            cancel.setValue(UIColor.flatBlueColorDark(), forKey: "titleTextColor")
            alert.addAction(cancel)
            
            let logout = UIAlertAction(title: "Logout", style: .default, handler: { (alert) in
                if let vc = UIStoryboard.auth.instantiateViewController(withIdentifier: LoginViewController.reuseIdentifier) as? LoginViewController {
                    let nc = UINavigationController(rootViewController: vc)
                    nc.modalPresentationStyle = .fullScreen
                    self.present(nc, animated: false, completion: nil) // TODO: cancel button
                    
                }
            })
            
            logout.setValue(UIColor.flatBlackColorDark(), forKey: "titleTextColor")
            alert.addAction(logout)

            
            self.present(alert, animated: false)
            try Auth.auth().signOut()
        } catch {
            
        }
    }
    
    
    
}
