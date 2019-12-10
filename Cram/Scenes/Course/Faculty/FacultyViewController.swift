//
//  FacultyViewController.swift
//  Cram
//
//  Created by Mert on 5.11.2019.
//  Copyright © 2019 Mert. All rights reserved.
//

import UIKit
import Firebase

class FacultyViewController: BaseViewController {
    
//    MARK: Outlet
    @IBOutlet weak var topView: TopView!
    @IBOutlet weak var tableView: UITableView!
    
//    MARK: Variables
    internal var facultyNames = ["Engineering", "Arts and Sciences", "Architecture and Design", "Economics and Administrative Sciences"]
    internal var facultyImageNames = ["eng", "art", "arc", "eco"]
    
    let firestoreDatabase = Firestore.firestore()
    let currentUser = Auth.auth().currentUser
        
//    MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        topView.topViewType = .faculty
        initialUI(navigationTitle: .hidden, navigationBarLeft: .hidden, navigationBarRight: .hidden, navigationBackground: .blue)
        tableView.register(UINib(nibName: FacultyTableViewCell.reuseIdentifier, bundle: .main), forCellReuseIdentifier: FacultyTableViewCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.tableFooterView = UIView(frame: .zero)
        
    }
//    MARK: GetUserInfo
    func getUserInfo() {
        firestoreDatabase.collection("Users").whereField("email", isEqualTo: currentUser!.email!).getDocuments { (snapshot, error) in
            if error != nil {
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
            } else {
                if snapshot?.isEmpty == false && snapshot != nil {
                    for document in snapshot!.documents {
                        let userEmail = document.get("email") as? String
                        let userName = document.get("name") as? String
                        User(uid: self.currentUser!.uid, name: userName!, email: userEmail!)
                            
                        
                    }
                }
            }
        }
    }
    
    func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}

//  MARK: TableView
extension FacultyViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return facultyNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed(FacultyTableViewCell.reuseIdentifier, owner: self, options: nil)?.first as! FacultyTableViewCell
        cell.facultyNameLabel.text = self.facultyNames[indexPath.row]
        cell.facultyImageView.image = UIImage(named: self.facultyImageNames[indexPath.row])
        cell.tapped = {
            LoadingScreen.show("Loading...")
            switch indexPath.row {
            case 0:
                
                if let vc = UIStoryboard.courses.instantiateViewController(withIdentifier: DepartmentViewController.reuseIdentifier) as? DepartmentViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                    vc.type = .engineering

                }
                
            case 1:
                if let vc = UIStoryboard.courses.instantiateViewController(withIdentifier: DepartmentViewController.reuseIdentifier) as? DepartmentViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                    vc.type = .artsScience

                }
                
            case 2:
                if let vc = UIStoryboard.courses.instantiateViewController(withIdentifier: DepartmentViewController.reuseIdentifier) as? DepartmentViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                    vc.type = .architecture
                }
                
            case 3:
                if let vc = UIStoryboard.courses.instantiateViewController(withIdentifier: DepartmentViewController.reuseIdentifier) as? DepartmentViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                    vc.type = .economics
                }
                
            default:
                break
            }
            
        }
        return cell
    }
}


