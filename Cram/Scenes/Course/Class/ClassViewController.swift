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
    internal var ref: DatabaseReference! = Database.database().reference()
    internal var databaseHandle: DatabaseHandle?
    
    internal var classData = [String]() {
        didSet {
            tableView.reloadData()
        }
    }
    
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
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func addButtonPressed(animated: Bool = true) {
        let vc = UIStoryboard.courses.instantiateViewController(withIdentifier: AddClassViewController.reuseIdentifier) as! AddClassViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func getClasses() {
         ref.child("course").observeSingleEvent(of: .childAdded) { (snapshot) in
            let post = snapshot.value as? String
            print(snapshot.key)
            if let actualPost = post {
                self.classData.append(actualPost)
            }
        }
    }
    
}

//  MARK: TableView
extension ClassViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ClassTableViewCell.reuseIdentifier, for: indexPath) as! ClassTableViewCell
        //        ref.child("departments/0/engineering/0/courses/\(indexPath.row)/displayName").observeSingleEvent(of: .value) { (snaphot) in
        //            let className = snaphot.value as? String
        //            cell.classNameLabel.text = className
        //        }
        
        ref.child("courses")
        
        return cell
    }
    
    
    
    
    
}
