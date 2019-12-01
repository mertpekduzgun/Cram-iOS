//
//  ClassViewController.swift
//  Cram
//
//  Created by Mert on 20.11.2019.
//  Copyright © 2019 Mert. All rights reserved.
//

import UIKit
import Firebase

class ClassViewController: BaseViewController {
    
    //    MARK: Outlet
    @IBOutlet weak var topView: TopView!
    @IBOutlet weak var tableView: UITableView!
    
    //    MARK: Variables
    let firestoreDatabase = Firestore.firestore()
    
    internal var classArray = [Class]()
    
    //    MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        topView.topViewType = .classroom
        initialUI(navigationTitle: .hidden, navigationBarLeft: .whiteBack, navigationBarRight: .white, navigationBackground: .blue)
        tableView.register(UINib(nibName: ClassTableViewCell.reuseIdentifier, bundle: .main), forCellReuseIdentifier: ClassTableViewCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.tableFooterView = UIView(frame: .zero)
        
        getClasses()
    }
    
    //    MARK: BackButton
    override func navigationBarBackButtonPressed(animated: Bool = true) {
        navigationController?.popViewController(animated: true)
    }
    
    override func addButtonPressed(animated: Bool = true) {
        let vc = UIStoryboard.courses.instantiateViewController(withIdentifier: AddClassViewController.reuseIdentifier) as! AddClassViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
//    MARK: GetClasses
    func getClasses() {
        
        //        firestoreDatabase.collection("departments").whereField("courses", isEqualTo: true).getDocuments { (snapshot, error) in
        //            if let error = error {
        //                print("error")
        //            } else {
        //                for document in snapshot!.documents {
        //                    print("\(document.documentID) => \(document.data())")
        //                }
        //            }
        //        }
        //    }
        
        //        firestoreDatabase.collection("classes").whereField("departmentName", isEqualTo: "management").getDocuments { (snapshot, error) in
        //            if let error = error {
        //                print(error)
        //            } else {
        //                if snapshot?.documents == nil {
        //                    print("boş")
        //                } else {
        //                    for document in snapshot!.documents {
        //                        print("\(document.documentID) => \(document.data())")
        //                    }
        //                }
        //            }
        //        }
        
        
        firestoreDatabase.collection("departments").whereField("facultyName", isEqualTo: "Engineering").whereField("courses", isEqualTo: "name").getDocuments { (snapshot, error) in
            if let error = error {
                print(error)
            } else {
                if snapshot?.documents == nil {
                    print("boş")
                } else {
                    for document in snapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                    }
                }
            }
        }
        
    }
    
    
    //        firestoreDatabase.collection("classes").whereField("departmentName", isEqualTo: "Computer Engineering").order(by: "name", descending: false).addSnapshotListener { (snapshot, error) in
    //            if error != nil {
    //                print("error") // TODO: Alert
    //            } else {
    //                if snapshot?.isEmpty == false && snapshot != nil {
    //                    self.classArray.removeAll()
    //                    for document in snapshot!.documents {
    //                        if let departmentName = document.get("departmentName") as? String{
    //                            if let name = document.get("name") as? String {
    //                                if let section = document.get("section") {
    //                                    let snap = Class(name: name, section: section as! String, departmentName: departmentName)
    //                                self.classArray.append(snap)
    //                                }
    //                            }
    //                        }
    //                    }
    //                }
    //            }
    //        }
    //    }
    
}

//  MARK: TableView
extension ClassViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ClassTableViewCell.reuseIdentifier, for: indexPath) as! ClassTableViewCell
        
        cell.classImageView.image = UIImage(named: "eng")
        cell.classNameLabel.text = classArray[indexPath.row].name
        cell.classSectionLabel.text = classArray[indexPath.row].section
        
        return cell
    }
    
    
    
    
    
}
