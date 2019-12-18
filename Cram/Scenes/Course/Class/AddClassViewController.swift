//
//  AddClassViewController.swift
//  Cram
//
//  Created by Mert on 26.11.2019.
//  Copyright © 2019 Mert. All rights reserved.
//

import UIKit
import Firebase

class AddClassViewController: BaseViewController {
    
//    MARK: Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var sectionTextField: UITextField!
    @IBOutlet weak var departmentNameTextField: UITextField!
    
    
    //    MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialUI(navigationTitle: .hidden, navigationBarLeft: .whiteBack, navigationBarRight: .hidden, navigationBackground: .blue)
        
    }
    
//    MARK: SaveClasses
    @IBAction func saveButton(_ sender: Any) {
        
        let firestore = Firestore.firestore()
        
        
        
        let classDictionary = ["courseName": self.nameTextField.text!, "section": self.sectionTextField.text!, "departmentName": self.departmentNameTextField.text!, "date": FieldValue.serverTimestamp()] as [String : Any]
        firestore.collection("classes").addDocument(data: classDictionary) { (error) in
            if error == nil {
                
                let classDict = Class(name: self.nameTextField.text!, section: self.sectionTextField.text!, departmentName: self.departmentNameTextField.text!)
                let vc = UIStoryboard.courses.instantiateViewController(withIdentifier: ClassViewController.reuseIdentifier) as! ClassViewController
                vc.classArray.append(classDict)
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                print(error)
            }
        }
        
    }
    
}
