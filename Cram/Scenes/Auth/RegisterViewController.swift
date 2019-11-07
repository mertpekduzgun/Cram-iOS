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
    
    @IBOutlet weak var nameTextField: TextFieldView!
    @IBOutlet weak var emailTextField: TextFieldView!
    @IBOutlet weak var passwordTextField: TextFieldView!
    @IBOutlet weak var profileImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            }
        }
    }
    
    @IBAction func tappedSignIn(_ sender: Any) {
        navigationController?.pushViewController(UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(identifier: LoginViewController.reuseIdentifier), animated: true)
        
    }
    
}
