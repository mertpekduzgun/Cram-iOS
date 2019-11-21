//
//  RegisterViewController.swift
//  Cram
//
//  Created by Mert on 2.11.2019.
//  Copyright © 2019 Mert. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: BaseViewController {
    
    @IBOutlet weak var topView: TopView!
    @IBOutlet weak var nameTextField: TextFieldView!
    @IBOutlet weak var emailTextField: TextFieldView!
    @IBOutlet weak var passwordTextField: TextFieldView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topView.topViewType = .register
        hideKeyboardWhenTappedAround()
        initialUI(navigationTitle: .hidden, navigationBarLeft: .hidden, navigationBackground: .blue)
        nameTextField.textFieldType = .name
        emailTextField.textFieldType = .email
        passwordTextField.textFieldType = .password
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func tappedSignUp(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailTextField.textField.text!, password: passwordTextField.textField.text!) { (user, error) in
            if error != nil {
                print(error!) // TODO: ALERT
            } else {
                print("Registeration Successful!") // TODO: ALERT -> GO TO COURSES VC
                if let vc = UIStoryboard(name: "Tabbar", bundle: nil).instantiateInitialViewController() {
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func tappedSignIn(_ sender: Any) {
        let vc = UIStoryboard.auth.instantiateViewController(withIdentifier: LoginViewController.reuseIdentifier) as! LoginViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
