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
    @IBOutlet weak var departmentNamePicker: UIPickerView!
    
    internal var userArray: [String] = []
    internal var pickerData = ["Civil Engineering", "Computer Engineering", "Electrical and Electronics Engineering", "Industrial Engineering", "Mechanical Engineering", "Humanities and Social Sciences", "Information Technologies", "Mathematics", "Physics", "Psychology", "Architecture", "Industrial Design", "Interior Architecture and Environmental Design", "Economics", "International Relations", "Management"]
    internal var departmentName = ""
    
    
    //    MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialUI(navigationTitle: .hidden, navigationBarLeft: .whiteBack, navigationBarRight: .hidden, navigationBackground: .blue)
        
    }
    
//    MARK: SaveClasses
    @IBAction func saveButton(_ sender: Any) {
        
        let firestore = Firestore.firestore()

        let classDictionary = ["courseName": self.nameTextField.text!, "section": self.sectionTextField.text!, "departmentName": self.departmentName, "date": FieldValue.serverTimestamp(), "users": self.userArray] as [String : Any]
        firestore.collection("classes").document(self.nameTextField.text!).setData(classDictionary) { (error) in
            if error == nil {
                
                let classDict = Class(name: self.nameTextField.text!, section: self.sectionTextField.text!, departmentName: self.departmentName)
                let vc = UIStoryboard.courses.instantiateViewController(withIdentifier: ClassViewController.reuseIdentifier) as! ClassViewController
                vc.classArray.append(classDict)
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                print(error)
            }
        }
        
    }
}

extension AddClassViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        departmentName = pickerData[row]
    }
    
    
    
    
}
