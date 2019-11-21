//
//  DepartmentViewController.swift
//  Cram
//
//  Created by Mert on 3.11.2019.
//  Copyright © 2019 Mert. All rights reserved.
//

import UIKit
import FirebaseDatabase

class DepartmentViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topView: TopView!
    
    internal var departmentData = [String]()
    private let ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topView.topViewType = .department
        initialUI(navigationTitle: .hidden, navigationBarLeft: .whiteBack, navigationBackground: .blue)
        tableView.register(UINib(nibName: DepartmentTableViewCell.reuseIdentifier, bundle: .main), forCellReuseIdentifier: DepartmentTableViewCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
}

extension DepartmentViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ref.child("departments/0/engineering/0/displayName").observe(.childAdded) { (snapshot) in
            let post = snapshot.value as? String
            if let actualPost = post {
                self.departmentData.append(actualPost)
            }
        }

        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DepartmentTableViewCell.reuseIdentifier, for: indexPath) as! DepartmentTableViewCell
        
        let vc = UIStoryboard.courses.instantiateViewController(withIdentifier: FacultyViewController.reuseIdentifier) as! FacultyViewController
        
        if vc.type == .engineering {
            
            cell.departmentImageView.image = UIImage(named: "eng")
            
            ref.child("departments/0/engineering/0/displayName").observeSingleEvent(of: .value) { (snaphot) in
//                let departmentName = snaphot.value as? String
//                cell.departmentLabel.text = departmentName
               for item in listNames {
                    let itemRef = shoppingListsRef.child(item)
                    itemRef.observe(.value, with: { (snapshot) in
                        if let value = snapshot.value as? [String: Any] {
                            let name = value["name"] as? String ?? ""
                            let owner = value["owner"] as? String ?? ""
                            print(name, owner)
                        }
                    })
                }
                
            }
        }
        
        if vc.type == .fineArts {
            
            cell.departmentImageView.image = UIImage(named: "eng")
            let ref = Database.database().reference()
            
            ref.child("departments/0/engineering/0/displayName").observeSingleEvent(of: .value) { (snaphot) in
                let departmentName = snaphot.value as? String
                cell.departmentLabel.text = departmentName
            }
        }
        
        if vc.type == .architecture {
            
            cell.departmentImageView.image = UIImage(named: "eng")
            let ref = Database.database().reference()
            
            ref.child("departments/0/engineering/0/displayName").observeSingleEvent(of: .value) { (snaphot) in
                let departmentName = snaphot.value as? String
                cell.departmentLabel.text = departmentName
            }
        }
        
        if vc.type == .economics {
            
            cell.departmentImageView.image = UIImage(named: "eng")
            let ref = Database.database().reference()
            
            ref.child("departments/0/engineering/0/displayName").observeSingleEvent(of: .value) { (snaphot) in
                let departmentName = snaphot.value as? String
                cell.departmentLabel.text = departmentName
            }
        }
        
        
        cell.tapped = {
            let vc = UIStoryboard.courses.instantiateViewController(withIdentifier: ClassViewController.reuseIdentifier) as! ClassViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
    }
    
}

