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
    
//    MARK: Outlet
    @IBOutlet weak var topView: TopView!
    @IBOutlet weak var nameTextField: TextFieldView!
    @IBOutlet weak var emailTextField: TextFieldView!
    @IBOutlet weak var passwordTextField: TextFieldView!
    
//    MARK: Variables
    internal var ref: DatabaseReference! = Database.database().reference()
    internal var uid = Auth.auth().currentUser?.uid
    
//    MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        topView.topViewType = .register
        hideKeyboardWhenTappedAround()
        initialUI(navigationTitle: .hidden, navigationBarLeft: .hidden, navigationBarRight: .hidden, navigationBackground: .blue)
        nameTextField.textFieldType = .name
        emailTextField.textFieldType = .email
        passwordTextField.textFieldType = .password
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    MARK: Sign Up
    @IBAction func tappedSignUp(_ sender: Any) {
        Auth.auth().signInAnonymously(completion: nil)
        Auth.auth().createUser(withEmail: emailTextField.textField.text!, password: passwordTextField.textField.text!) { (user, error) in
            if error != nil {
                print(error!) // TODO: ALERT
            } else {
//                self.ref.child("users").child(self.uid!).setValue(["name": self.nameTextField.textField.text, "email": self.emailTextField.textField.text])
                
                let fireStore = Firestore.firestore()
                let userDict = ["email": self.emailTextField.textField.text!, "name": self.nameTextField.textField.text!] as [String: Any]
                fireStore.collection("User").addDocument(data: userDict)
                if let vc = UIStoryboard.tabbar.instantiateInitialViewController() {
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }
            }
        }
    }
    
//    MARK: Sign In
    @IBAction func tappedSignIn(_ sender: Any) {
        let vc = UIStoryboard.auth.instantiateViewController(withIdentifier: LoginViewController.reuseIdentifier) as! LoginViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
