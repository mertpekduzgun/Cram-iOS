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
    

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var sectionTextField: UITextField!
    
    internal var ref: DatabaseReference! = Database.database().reference()

    
    //    MARK: LifeCycle
     override func viewDidLoad() {
         super.viewDidLoad()
        initialUI(navigationTitle: .hidden, navigationBarLeft: .whiteBack, navigationBarRight: .hidden, navigationBackground: .blue)
        
     }
    
    
    @IBAction func saveButton(_ sender: Any) {
        self.ref.child("course").childByAutoId().setValue(["displayName": nameTextField.text, "section": sectionTextField.text])
        let vc = UIStoryboard.courses.instantiateViewController(withIdentifier: ClassViewController.reuseIdentifier) as! ClassViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}
