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
    case fineArts
    case architecture
    case economics
}

class DepartmentViewController: BaseViewController {
    
    //    MARK: Outlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: TopView!
    
    //    MARK: Variables
    internal var departmentArray = [[String: Any]] () {
        didSet {
            tableView.reloadData()
        }
    }
    
    internal var ref: DatabaseReference! = Database.database().reference()
    internal var firestoreDatabase = Firestore.firestore()
    internal var type: facultyType = .engineering
    
    
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
    
    func getDepartments() {
        switch type {
        case .engineering:
//            self.ref.child("departments/0/engineering").observeSingleEvent(of: .value) { (snapshot) in
//                for item in snapshot.children {
//                    let snap = item as! DataSnapshot
//                    let depDict = snap.value as! [String: Any]
//                    self.departmentArray.append(depDict)
//                }
            firestoreDatabase.collection("departments").order(by: "Date")
            
            }
        case .fineArts:
            
            
        case .architecture:
           
            
        case .economics:
            
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
        
        if type == .engineering {

            
            cell.departmentImageView.image = UIImage(named: "eng")
            ref.child("departments/0/engineering/\(indexPath.row)/displayName").observeSingleEvent(of: .value) { (snaphot) in
                let departmentName = snaphot.value as? String
                cell.departmentLabel.text = departmentName
                LoadingScreen.hide()
            }
        }
        
        if type == .fineArts {
            
            cell.departmentImageView.image = UIImage(named: "art")
            let ref = Database.database().reference()
            
            ref.child("departments/0/engineering/0/displayName").observeSingleEvent(of: .value) { (snaphot) in
                let departmentName = snaphot.value as? String
                cell.departmentLabel.text = departmentName
                LoadingScreen.hide()

            }
        }
        
        if type == .architecture {
            
            cell.departmentImageView.image = UIImage(named: "arc")
            let ref = Database.database().reference()
            
            ref.child("departments/0/engineering/0/displayName").observeSingleEvent(of: .value) { (snaphot) in
                let departmentName = snaphot.value as? String
                cell.departmentLabel.text = departmentName
                LoadingScreen.hide()

            }
        }
        
        if type == .economics {
            
            cell.departmentImageView.image = UIImage(named: "eco")
            LoadingScreen.hide()


        }
        
        
        cell.tapped = {
            let vc = UIStoryboard.courses.instantiateViewController(withIdentifier: ClassViewController.reuseIdentifier) as! ClassViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
    }
    
}

