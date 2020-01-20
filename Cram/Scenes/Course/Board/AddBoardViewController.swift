//
//  AddBoardViewController.swift
//  Cram
//
//  Created by Mert on 17.01.2020.
//  Copyright © 2020 Mert. All rights reserved.
//

import UIKit
import Firebase

class AddBoardViewController: BaseViewController {
    
//    MARK: Outlets
    @IBOutlet weak var addTextField: UITextField!
    @IBOutlet weak var boardSectionPicker: UIPickerView!
    @IBOutlet weak var closeImageView: UIImageView!
    
//    MARK: Properties
    internal var pickerData = ["Announcements", "Quiz Dates", "Exam Dates"]
    internal var currentClassName = ""
    internal var boardSection = ""
    internal var announcementArray: [String] = []
    internal var quizDateArray: [String] = []
    internal var examDateArray: [String] = []
    
//    MARK: Outlets
    override func viewDidLoad() {
        super.viewDidLoad()
        createBoard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.closeImageView.isUserInteractionEnabled = true
        self.closeImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closedPressed(animated:))))
        
    }
    
//    MARK: Save Button
    @IBAction func saveButtonPressed(_ sender: Any) {
        let firestore = Firestore.firestore()
        if boardSection == "Announcements" {
            self.announcementArray.append(self.addTextField.text ?? "")
            let ref = firestore.collection("boards").document(self.currentClassName)
            ref.updateData(["announcements": FieldValue.arrayUnion([self.addTextField.text ?? ""])])
            self.dismiss(animated: true, completion: nil)
        } else if boardSection == "Quiz Dates" {
            self.quizDateArray.append(self.addTextField.text ?? "")
            let ref = firestore.collection("boards").document(self.currentClassName)
            ref.updateData(["quizDates": FieldValue.arrayUnion([self.addTextField.text ?? ""])])
            self.dismiss(animated: true, completion: nil)
        } else {
            self.examDateArray.append(self.addTextField.text ?? "")
            let ref = firestore.collection("boards").document(self.currentClassName)
            ref.updateData(["examDates": FieldValue.arrayUnion([self.addTextField.text ?? ""])])
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
//    MARK: Create Board
    func createBoard() {
        let firestore = Firestore.firestore()
        
        let firestoreDatabase = Firestore.firestore().collection("boards").whereField("className", isEqualTo:self.currentClassName)
        
        firestoreDatabase.getDocuments { (snapshot, error) in
            
            if let error = error {
                print(error)
                return
            } else {
                guard let queryCount = snapshot?.documents.count else {
                    return
                }
                if queryCount == 0 {
                    let boardDictionary = ["announcements": self.announcementArray, "quizDates": self.quizDateArray, "examDates": self.examDateArray, "className": self.currentClassName, "created": FieldValue.serverTimestamp()] as [String : Any]
                    
                    firestore.collection("boards").document(self.currentClassName).setData(boardDictionary) { (error) in
                        if error != nil {
                            print(error)
                        }
                    }
                }
            }
        }
    }
}

// MARK: Picker
extension AddBoardViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
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
        boardSection = pickerData[row]
    }
}
