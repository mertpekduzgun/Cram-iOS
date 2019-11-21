//
//  LoginViewController.swift
//  Cram
//
//  Created by Mert on 2.11.2019.
//  Copyright © 2019 Mert. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var topView: TopView!
    @IBOutlet weak var emailTextField: TextFieldView!
    @IBOutlet weak var passwordTextField: TextFieldView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topView.topViewType = .login
        hideKeyboardWhenTappedAround()
        initialUI(navigationTitle: .hidden, navigationBarLeft: .hidden, navigationBackground: .blue)
        emailTextField.textFieldType = .email
        passwordTextField.textFieldType = .password
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func tappedSignIn(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.textField.text!, password: passwordTextField.textField.text!) { (User, error) in
            
            if error != nil {
                print("Login Error") // TODO: ALERT
            } else {
                print("Success") // TODO: Go to Courses VC
                if let vc = UIStoryboard(name: "Tabbar", bundle: nil).instantiateInitialViewController() {
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }
                
            }
            
        }
    }
    
    @IBAction func tappedSignUp(_ sender: Any) {
        let vc = UIStoryboard.auth.instantiateViewController(withIdentifier: RegisterViewController.reuseIdentifier) as! RegisterViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
