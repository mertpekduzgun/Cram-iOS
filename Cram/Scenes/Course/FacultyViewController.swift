//
//  FacultyViewController.swift
//  Cram
//
//  Created by Mert on 5.11.2019.
//  Copyright © 2019 Mert. All rights reserved.
//

import UIKit

class FacultyViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    internal var facultyNames = ["Engineering, Arts and Sciences, Architecture and Design, Economics and Administrative Sciences"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialUI(navigationTitle: .hidden, navigationBarLeft: .hidden, navigationBackground: .blue)
        tableView.register(UINib(nibName: FacultyTableViewCell.reuseIdentifier, bundle: .main), forCellReuseIdentifier: FacultyTableViewCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
}

extension FacultyViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return facultyNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FacultyTableViewCell.reuseIdentifier, for: indexPath) as! FacultyTableViewCell
        
        switch indexPath.row {
        case 0:
            let vc = UIStoryboard(name: "Course", bundle: .main).instantiateViewController(withIdentifier: DepartmentViewController.reuseIdentifier) as! DepartmentViewController
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = UIStoryboard(name: "Course", bundle: .main).instantiateViewController(withIdentifier: DepartmentViewController.reuseIdentifier) as! DepartmentViewController
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = UIStoryboard(name: "Course", bundle: .main).instantiateViewController(withIdentifier: DepartmentViewController.reuseIdentifier) as! DepartmentViewController
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = UIStoryboard(name: "Course", bundle: .main).instantiateViewController(withIdentifier: DepartmentViewController.reuseIdentifier) as! DepartmentViewController
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
        
        return cell
    }
}

