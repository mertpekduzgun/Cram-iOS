//
//  DepartmentViewController.swift
//  Cram
//
//  Created by Mert on 3.11.2019.
//  Copyright © 2019 Mert. All rights reserved.
//

import UIKit
import Firebase

enum facultyType {
    case engineering
    case artsScience
    case architecture
    case economics
}

class DepartmentViewController: BaseViewController {
    
    //    MARK: Outlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: TopView!
    
    //    MARK: Variables
    internal var departmentArray = [Department]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    internal var firestoreDatabase = Firestore.firestore()
    internal var type: facultyType = .engineering
    internal var imageName: String = ""
    
    //    MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        topView.topViewType = .department
        initialUI(navigationTitle: .hidden, navigationBarLeft: .whiteBack, navigationBarRight: .hidden, navigationBackground: .blue)
        tableView.register(UINib(nibName: DepartmentTableViewCell.reuseIdentifier, bundle: .main), forCellReuseIdentifier: DepartmentTableViewCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDepartments()
        
    }
    
    //    MARK: GetDepartmemts
    func getDepartments() {
        switch type {
        case .engineering:
            firestoreDatabase.collection("departments").whereField("facultyName", isEqualTo: "Engineering").order(by: "name", descending: false).addSnapshotListener { (snapshot, error) in
                if error != nil {
                    print("error") // TODO: Alert
                } else {
                    if snapshot?.isEmpty == false && snapshot != nil {
                        self.departmentArray.removeAll()
                        for document in snapshot!.documents {
                            if let departmentName = document.get("name") as? String{
                                if let facultyName = document.get("facultyName") as? String {
                                    let snap = Department(departmentName: departmentName, facultyName: facultyName)
                                    self.departmentArray.append(snap)
                                }
                            }
                        }
                    }
                }
            }
        case .artsScience:
            firestoreDatabase.collection("departments").whereField("facultyName", isEqualTo: "ArtsScience").order(by: "name", descending: false).addSnapshotListener { (snapshot, error) in
                if error != nil {
                    print("error") // TODO: Alert
                } else {
                    if snapshot?.isEmpty == false && snapshot != nil {
                        self.departmentArray.removeAll()
                        for document in snapshot!.documents {
                            if let departmentName = document.get("name") as? String{
                                if let facultyName = document.get("facultyName") as? String {
                                    let snap = Department(departmentName: departmentName, facultyName: facultyName)
                                    self.departmentArray.append(snap)
                                }
                            }
                        }
                    }
                }
            }
            
            
        case .architecture:
            firestoreDatabase.collection("departments").whereField("facultyName", isEqualTo: "Architecture").order(by: "name", descending: false).addSnapshotListener { (snapshot, error) in
                if error != nil {
                    print("error") // TODO: Alert
                } else {
                    if snapshot?.isEmpty == false && snapshot != nil {
                        self.departmentArray.removeAll()
                        for document in snapshot!.documents {
                            if let departmentName = document.get("name") as? String{
                                if let facultyName = document.get("facultyName") as? String {
                                    let snap = Department(departmentName: departmentName, facultyName: facultyName)
                                    self.departmentArray.append(snap)
                                }
                            }
                        }
                    }
                }
            }
            
            
        case .economics:
            firestoreDatabase.collection("departments").whereField("facultyName", isEqualTo: "Economics").order(by: "name", descending: false).addSnapshotListener { (snapshot, error) in
                if error != nil {
                    print("error") // TODO: Alert
                } else {
                    if snapshot?.isEmpty == false && snapshot != nil {
                        self.departmentArray.removeAll()
                        for document in snapshot!.documents {
                            if let departmentName = document.get("name") as? String{
                                if let facultyName = document.get("facultyName") as? String {
                                    let snap = Department(departmentName: departmentName, facultyName: facultyName)
                                    self.departmentArray.append(snap)
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
extension DepartmentViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return departmentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DepartmentTableViewCell.reuseIdentifier, for: indexPath) as! DepartmentTableViewCell
        cell.departmentLabel.text = self.departmentArray[indexPath.row].departmentName
        cell.departmentImageView.image = UIImage(named: self.imageName)
        LoadingScreen.hide()
        cell.tapped = {
            LoadingScreen.show("Loading...")
            if self.type == .engineering {
                switch indexPath.row {
                case 0:
                    if let vc = UIStoryboard.courses.instantiateViewController(withIdentifier: ClassViewController.reuseIdentifier) as? ClassViewController {
                        self.navigationController?.pushViewController(vc, animated: true)
                        vc.type = .civil
                        
                    }
                case 1:
                    if let vc = UIStoryboard.courses.instantiateViewController(withIdentifier: ClassViewController.reuseIdentifier) as? ClassViewController {
                        self.navigationController?.pushViewController(vc, animated: true)
                        vc.type = .computer
                        
                    }
                    
                case 2:
                    if let vc = UIStoryboard.courses.instantiateViewController(withIdentifier: ClassViewController.reuseIdentifier) as? ClassViewController {
                        self.navigationController?.pushViewController(vc, animated: true)
                        vc.type = .electrical
                        
                    }
                    
                case 3:
                    if let vc = UIStoryboard.courses.instantiateViewController(withIdentifier: ClassViewController.reuseIdentifier) as? ClassViewController {
                        self.navigationController?.pushViewController(vc, animated: true)
                        vc.type = .industrial
                        
                    }
                    
                case 4:
                    if let vc = UIStoryboard.courses.instantiateViewController(withIdentifier: ClassViewController.reuseIdentifier) as? ClassViewController {
                        self.navigationController?.pushViewController(vc, animated: true)
                        vc.type = .mechanical
                        
                    }
                    
                default:
                    break
                }
            }
            if self.type == .artsScience {
                switch indexPath.row {
                case 0:
                    if let vc = UIStoryboard.courses.instantiateViewController(withIdentifier: ClassViewController.reuseIdentifier) as? ClassViewController {
                        self.navigationController?.pushViewController(vc, animated: true)
                        vc.type = .humanities
                        
                    }
                    
                case 1:
                    if let vc = UIStoryboard.courses.instantiateViewController(withIdentifier: ClassViewController.reuseIdentifier) as? ClassViewController {
                        self.navigationController?.pushViewController(vc, animated: true)
                        vc.type = .information
                        
                    }
                    
                case 2:
                    if let vc = UIStoryboard.courses.instantiateViewController(withIdentifier: ClassViewController.reuseIdentifier) as? ClassViewController {
                        self.navigationController?.pushViewController(vc, animated: true)
                        vc.type = .math
                        
                    }
                    
                case 3:
                    if let vc = UIStoryboard.courses.instantiateViewController(withIdentifier: ClassViewController.reuseIdentifier) as? ClassViewController {
                        self.navigationController?.pushViewController(vc, animated: true)
                        vc.type = .physics
                        
                    }
                    
                case 4:
                    if let vc = UIStoryboard.courses.instantiateViewController(withIdentifier: ClassViewController.reuseIdentifier) as? ClassViewController {
                        self.navigationController?.pushViewController(vc, animated: true)
                        vc.type = .psychology
                        
                    }
                default:
                    break
                }
            }
            
            if self.type == .architecture {
                switch indexPath.row {
                case 0:
                    if let vc = UIStoryboard.courses.instantiateViewController(withIdentifier: ClassViewController.reuseIdentifier) as? ClassViewController {
                        self.navigationController?.pushViewController(vc, animated: true)
                        vc.type = .arch
                        
                    }
                    
                case 1:
                    if let vc = UIStoryboard.courses.instantiateViewController(withIdentifier: ClassViewController.reuseIdentifier) as? ClassViewController {
                        self.navigationController?.pushViewController(vc, animated: true)
                        vc.type = .industrialDesign
                        
                    }
                    
                case 2:
                    if let vc = UIStoryboard.courses.instantiateViewController(withIdentifier: ClassViewController.reuseIdentifier) as? ClassViewController {
                        self.navigationController?.pushViewController(vc, animated: true)
                        vc.type = .interiorArch
                        
                    }
                default:
                    break
                }
            }
            
            if self.type == .economics {
                switch indexPath.row {
                case 0:
                    if let vc = UIStoryboard.courses.instantiateViewController(withIdentifier: ClassViewController.reuseIdentifier) as? ClassViewController {
                        self.navigationController?.pushViewController(vc, animated: true)
                        vc.type = .eco
                        
                    }
                    
                case 1:
                    if let vc = UIStoryboard.courses.instantiateViewController(withIdentifier: ClassViewController.reuseIdentifier) as? ClassViewController {
                        self.navigationController?.pushViewController(vc, animated: true)
                        vc.type = .internationalRelations
                        
                    }
                    
                case 2:
                    if let vc = UIStoryboard.courses.instantiateViewController(withIdentifier: ClassViewController.reuseIdentifier) as? ClassViewController {
                        self.navigationController?.pushViewController(vc, animated: true)
                        vc.type = .management
                        
                    }
                default:
                    break
                }
            }
        }
        return cell
    }
}

