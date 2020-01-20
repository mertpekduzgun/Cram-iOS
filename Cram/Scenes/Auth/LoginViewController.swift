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
    
//    MARK: Outlets
    @IBOutlet weak var topView: TopView!
    @IBOutlet weak var emailTextField: TextFieldView!
    @IBOutlet weak var passwordTextField: TextFieldView!
        
//    MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        setupTextFieldUI()
        hideKeyboardWhenTappedAround()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    MARK: Setup UI
    func initUI() {
        initialUI(navigationTitle: .hidden, navigationBarLeft: .hidden, navigationBarRight: .hidden, navigationBackground: .blue)
        topView.topViewType = .login
    }
    
//    MARK: Setup Text Field
    func setupTextFieldUI() {
        emailTextField.textFieldType = .email
        passwordTextField.textFieldType = .password
    }
    
//    MARK: Sign In
    @IBAction func tappedSignIn(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.textField.text!, password: passwordTextField.textField.text!) { (User, error) in
            if error != nil {
                Helper.showAlert(title: "Error!", message: "Email or password is wrong.", style: .warning, position: .top)
            } else {
                if let vc = UIStoryboard.tabbar.instantiateInitialViewController() {
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }
                
            }
            
        }
    }
    
//    MARK: Go To Sign Up
    @IBAction func tappedSignUp(_ sender: Any) {
        let vc = UIStoryboard.auth.instantiateViewController(withIdentifier: RegisterViewController.reuseIdentifier) as! RegisterViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
