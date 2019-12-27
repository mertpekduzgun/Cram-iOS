//
//  ClassViewController.swift
//  Cram
//
//  Created by Mert on 20.11.2019.
//  Copyright © 2019 Mert. All rights reserved.
//

import UIKit
import Firebase

enum departmentType {
    case civil
    case computer
    case industrial
    case electrical
    case mechanical
    case humanities
    case information
    case math
    case physics
    case psychology
    case arch
    case industrialDesign
    case interiorArch
    case eco
    case internationalRelations
    case management
}

class ClassViewController: BaseViewController {
    
    //    MARK: Outlet
    @IBOutlet weak var topView: TopView!
    @IBOutlet weak var tableView: UITableView!
    
    //    MARK: Variables
    internal var classArray = [Class]() {
        didSet {
            tableView?.reloadData()
            LoadingScreen.hide()

        }
    }
    
    internal var type: departmentType = .computer
    
    //    MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationItem.title = "Courses"
        topView.topViewType = .classroom
        initialUI(navigationTitle: .hidden, navigationBarLeft: .whiteBack, navigationBarRight: .white, navigationBackground: .blue)
        tableView.register(UINib(nibName: ClassTableViewCell.reuseIdentifier, bundle: .main), forCellReuseIdentifier: ClassTableViewCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.tableFooterView = UIView(frame: .zero)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        
        switch type {
        case .civil:
            let firestoreDatabase = Firestore.firestore().collection("classes").whereField("departmentName", isEqualTo: "Civil Engineering")
            
            firestoreDatabase.getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error: \(error)")
                    return
                } else {
                    if snapshot?.documents == nil {
                        print("Empty")
                    } else {
                        self.classArray.removeAll()
                        for document in snapshot!.documents {
                            if let className = document.get("courseName") as? String {
                                if let departmentName = document.get("departmentName") as? String {
                                    if let classSection = document.get("section") as? String {
                                        let snap = Class(name: className, section: classSection, departmentName: departmentName)
                                        self.classArray.append(snap)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        case .computer:
            let firestoreDatabase = Firestore.firestore().collection("classes").whereField("departmentName", isEqualTo: "Computer Engineering")
            
            firestoreDatabase.getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error: \(error)")
                    return
                } else {
                    if snapshot?.documents == nil {
                        print("Empty")
                    } else {
                        self.classArray.removeAll()
                        for document in snapshot!.documents {
                            if let className = document.get("courseName") as? String {
                                if let departmentName = document.get("departmentName") as? String {
                                    if let classSection = document.get("section") as? String {
                                        let snap = Class(name: className, section: classSection, departmentName: departmentName)
                                        self.classArray.append(snap)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        case .electrical:
            let firestoreDatabase = Firestore.firestore().collection("classes").whereField("departmentName", isEqualTo: "Electrical and Electronics Engineering")
            
            firestoreDatabase.getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error: \(error)")
                    return
                } else {
                    if snapshot?.documents == nil {
                        print("Empty")
                    } else {
                        self.classArray.removeAll()
                        for document in snapshot!.documents {
                            if let className = document.get("courseName") as? String {
                                if let departmentName = document.get("departmentName") as? String {
                                    if let classSection = document.get("section") as? String {
                                        let snap = Class(name: className, section: classSection, departmentName: departmentName)
                                        self.classArray.append(snap)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        case .industrial:
            let firestoreDatabase = Firestore.firestore().collection("classes").whereField("departmentName", isEqualTo: "Industrial Engineering")
            
            firestoreDatabase.getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error: \(error)")
                    return
                } else {
                    if snapshot?.documents == nil {
                        print("Empty")
                    } else {
                        self.classArray.removeAll()
                        for document in snapshot!.documents {
                            if let className = document.get("courseName") as? String {
                                if let departmentName = document.get("departmentName") as? String {
                                    if let classSection = document.get("section") as? String {
                                        let snap = Class(name: className, section: classSection, departmentName: departmentName)
                                        self.classArray.append(snap)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        case .mechanical:
            let firestoreDatabase = Firestore.firestore().collection("classes").whereField("departmentName", isEqualTo: "Mechanical Engineering")
            
            firestoreDatabase.getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error: \(error)")
                    return
                } else {
                    if snapshot?.documents == nil {
                        print("Empty")
                    } else {
                        self.classArray.removeAll()
                        for document in snapshot!.documents {
                            if let className = document.get("courseName") as? String {
                                if let departmentName = document.get("departmentName") as? String {
                                    if let classSection = document.get("section") as? String {
                                        let snap = Class(name: className, section: classSection, departmentName: departmentName)
                                        self.classArray.append(snap)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        case .humanities:
            let firestoreDatabase = Firestore.firestore().collection("classes").whereField("departmentName", isEqualTo: "Humanities and Social Sciences")
            
            firestoreDatabase.getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error: \(error)")
                    return
                } else {
                    if snapshot?.documents == nil {
                        print("Empty")
                    } else {
                        self.classArray.removeAll()
                        for document in snapshot!.documents {
                            if let className = document.get("courseName") as? String {
                                if let departmentName = document.get("departmentName") as? String {
                                    if let classSection = document.get("section") as? String {
                                        let snap = Class(name: className, section: classSection, departmentName: departmentName)
                                        self.classArray.append(snap)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        case .information:
            let firestoreDatabase = Firestore.firestore().collection("classes").whereField("departmentName", isEqualTo: "Information Technologies")
            
            firestoreDatabase.getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error: \(error)")
                    return
                } else {
                    if snapshot?.documents == nil {
                        print("Empty")
                    } else {
                        self.classArray.removeAll()
                        for document in snapshot!.documents {
                            if let className = document.get("courseName") as? String {
                                if let departmentName = document.get("departmentName") as? String {
                                    if let classSection = document.get("section") as? String {
                                        let snap = Class(name: className, section: classSection, departmentName: departmentName)
                                        self.classArray.append(snap)
                                    }
                                }
                            }
                        }
                    }
                }
                
            }
        case .math:
            let firestoreDatabase = Firestore.firestore().collection("classes").whereField("departmentName", isEqualTo: "Mathematics")
            
            firestoreDatabase.getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error: \(error)")
                    return
                } else {
                    if snapshot?.documents == nil {
                        print("Empty")
                    } else {
                        self.classArray.removeAll()
                        for document in snapshot!.documents {
                            if let className = document.get("courseName") as? String {
                                if let departmentName = document.get("departmentName") as? String {
                                    if let classSection = document.get("section") as? String {
                                        let snap = Class(name: className, section: classSection, departmentName: departmentName)
                                        self.classArray.append(snap)
                                    }
                                }
                            }
                        }
                    }
                }
                
            }
        case .physics:
            let firestoreDatabase = Firestore.firestore().collection("classes").whereField("departmentName", isEqualTo: "Physics")
            
            firestoreDatabase.getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error: \(error)")
                    return
                } else {
                    if snapshot?.documents == nil {
                        print("Empty")
                    } else {
                        self.classArray.removeAll()
                        for document in snapshot!.documents {
                            if let className = document.get("courseName") as? String {
                                if let departmentName = document.get("departmentName") as? String {
                                    if let classSection = document.get("section") as? String {
                                        let snap = Class(name: className, section: classSection, departmentName: departmentName)
                                        self.classArray.append(snap)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        case .psychology:
            let firestoreDatabase = Firestore.firestore().collection("classes").whereField("departmentName", isEqualTo: "Psychology")
            
            firestoreDatabase.getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error: \(error)")
                    return
                } else {
                    if snapshot?.documents == nil {
                        print("Empty")
                    } else {
                        self.classArray.removeAll()
                        for document in snapshot!.documents {
                            if let className = document.get("courseName") as? String {
                                if let departmentName = document.get("departmentName") as? String {
                                    if let classSection = document.get("section") as? String {
                                        let snap = Class(name: className, section: classSection, departmentName: departmentName)
                                        self.classArray.append(snap)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        case .arch:
            let firestoreDatabase = Firestore.firestore().collection("classes").whereField("departmentName", isEqualTo: "Architecture")
            
            firestoreDatabase.getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error: \(error)")
                    return
                } else {
                    if snapshot?.documents == nil {
                        print("Empty")
                    } else {
                        self.classArray.removeAll()
                        for document in snapshot!.documents {
                            if let className = document.get("courseName") as? String {
                                if let departmentName = document.get("departmentName") as? String {
                                    if let classSection = document.get("section") as? String {
                                        let snap = Class(name: className, section: classSection, departmentName: departmentName)
                                        self.classArray.append(snap)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        case .industrialDesign:
            let firestoreDatabase = Firestore.firestore().collection("classes").whereField("departmentName", isEqualTo: "Industrial Design")
            
            firestoreDatabase.getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error: \(error)")
                    return
                } else {
                    if snapshot?.documents == nil {
                        print("Empty")
                    } else {
                        self.classArray.removeAll()
                        for document in snapshot!.documents {
                            if let className = document.get("courseName") as? String {
                                if let departmentName = document.get("departmentName") as? String {
                                    if let classSection = document.get("section") as? String {
                                        let snap = Class(name: className, section: classSection, departmentName: departmentName)
                                        self.classArray.append(snap)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        case .interiorArch:
            let firestoreDatabase = Firestore.firestore().collection("classes").whereField("departmentName", isEqualTo: "Interior Architecture and Environmental Design")
            
            firestoreDatabase.getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error: \(error)")
                    return
                } else {
                    if snapshot?.documents == nil {
                        print("Empty")
                    } else {
                        self.classArray.removeAll()
                        for document in snapshot!.documents {
                            if let className = document.get("courseName") as? String {
                                if let departmentName = document.get("departmentName") as? String {
                                    if let classSection = document.get("section") as? String {
                                        let snap = Class(name: className, section: classSection, departmentName: departmentName)
                                        self.classArray.append(snap)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        case .eco:
            let firestoreDatabase = Firestore.firestore().collection("classes").whereField("departmentName", isEqualTo: "Economics")
            
            firestoreDatabase.getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error: \(error)")
                    return
                } else {
                    if snapshot?.documents == nil {
                        print("Empty")
                    } else {
                        self.classArray.removeAll()
                        for document in snapshot!.documents {
                            if let className = document.get("courseName") as? String {
                                if let departmentName = document.get("departmentName") as? String {
                                    if let classSection = document.get("section") as? String {
                                        let snap = Class(name: className, section: classSection, departmentName: departmentName)
                                        self.classArray.append(snap)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        case .internationalRelations:
            let firestoreDatabase = Firestore.firestore().collection("classes").whereField("departmentName", isEqualTo: "International Relations")
            
            firestoreDatabase.getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error: \(error)")
                    return
                } else {
                    if snapshot?.documents == nil {
                        print("Empty")
                    } else {
                        self.classArray.removeAll()
                        for document in snapshot!.documents {
                            if let className = document.get("courseName") as? String {
                                if let departmentName = document.get("departmentName") as? String {
                                    if let classSection = document.get("section") as? String {
                                        let snap = Class(name: className, section: classSection, departmentName: departmentName)
                                        self.classArray.append(snap)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        case .management:
            let firestoreDatabase = Firestore.firestore().collection("classes").whereField("departmentName", isEqualTo: "Management")
            
            firestoreDatabase.getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error: \(error)")
                    return
                } else {
                    if snapshot?.documents == nil {
                        print("Empty")
                    } else {
                        self.classArray.removeAll()
                        for document in snapshot!.documents {
                            if let className = document.get("courseName") as? String {
                                if let departmentName = document.get("departmentName") as? String {
                                    if let classSection = document.get("section") as? String {
                                        let snap = Class(name: className, section: classSection, departmentName: departmentName)
                                        self.classArray.append(snap)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
        default:
            break
        }
    }
}

//  MARK: TableView
extension ClassViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ClassTableViewCell.reuseIdentifier, for: indexPath) as! ClassTableViewCell
        if type == .civil {
            cell.classImageView.image = UIImage(named: "eng")
            cell.classNameLabel.text = classArray[indexPath.row].name
            cell.classSectionLabel.text = classArray[indexPath.row].section
    
        }
        
        if type == .computer {
            cell.classImageView.image = UIImage(named: "eng")
            cell.classNameLabel.text = classArray[indexPath.row].name
            cell.classSectionLabel.text = classArray[indexPath.row].section

            
        }
        
        if type == .electrical {
            cell.classImageView.image = UIImage(named: "eng")
            cell.classNameLabel.text = classArray[indexPath.row].name
            cell.classSectionLabel.text = classArray[indexPath.row].section
            
        }
        
        if type == .industrial {
            cell.classImageView.image = UIImage(named: "eng")
            cell.classNameLabel.text = classArray[indexPath.row].name
            cell.classSectionLabel.text = classArray[indexPath.row].section
            LoadingScreen.hide()

        }
        
        if type == .mechanical {
            cell.classImageView.image = UIImage(named: "eng")
            cell.classNameLabel.text = classArray[indexPath.row].name
            cell.classSectionLabel.text = classArray[indexPath.row].section
            LoadingScreen.hide()
            
        }
        
        if type == .humanities {
            cell.classImageView.image = UIImage(named: "art")
            cell.classNameLabel.text = classArray[indexPath.row].name
            cell.classSectionLabel.text = classArray[indexPath.row].section
            LoadingScreen.hide()

        }
        
        if type == .information {
            cell.classImageView.image = UIImage(named: "art")
            cell.classNameLabel.text = classArray[indexPath.row].name
            cell.classSectionLabel.text = classArray[indexPath.row].section
            
        }
        
        if type == .math {
            cell.classImageView.image = UIImage(named: "art")
            cell.classNameLabel.text = classArray[indexPath.row].name
            cell.classSectionLabel.text = classArray[indexPath.row].section
            
        }
        
        if type == .physics {
            cell.classImageView.image = UIImage(named: "art")
            cell.classNameLabel.text = classArray[indexPath.row].name
            cell.classSectionLabel.text = classArray[indexPath.row].section
            
        }
        
        if type == .psychology {
            cell.classImageView.image = UIImage(named: "art")
            cell.classNameLabel.text = classArray[indexPath.row].name
            cell.classSectionLabel.text = classArray[indexPath.row].section
            
        }
        
        if type == .arch {
            cell.classImageView.image = UIImage(named: "art")
            cell.classNameLabel.text = classArray[indexPath.row].name
            cell.classSectionLabel.text = classArray[indexPath.row].section
            
        }
        
        if type == .industrialDesign {
            cell.classImageView.image = UIImage(named: "art")
            cell.classNameLabel.text = classArray[indexPath.row].name
            cell.classSectionLabel.text = classArray[indexPath.row].section
            
        }
        
        if type == .interiorArch {
            cell.classImageView.image = UIImage(named: "art")
            cell.classNameLabel.text = classArray[indexPath.row].name
            cell.classSectionLabel.text = classArray[indexPath.row].section
            
        }
        
        if type == .eco {
            cell.classImageView.image = UIImage(named: "art")
            cell.classNameLabel.text = classArray[indexPath.row].name
            cell.classSectionLabel.text = classArray[indexPath.row].section
            
        }
        
        if type == .internationalRelations {
            cell.classImageView.image = UIImage(named: "art")
            cell.classNameLabel.text = classArray[indexPath.row].name
            cell.classSectionLabel.text = classArray[indexPath.row].section
            
        }
        
        if type == .management {
            cell.classImageView.image = UIImage(named: "art")
            cell.classNameLabel.text = classArray[indexPath.row].name
            cell.classSectionLabel.text = classArray[indexPath.row].section
            
        }
        return cell
    }
}
