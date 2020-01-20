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
        initUI()
        setupTableView()
        
    }
    
    //    MARK: Setup UI
    func initUI() {
        initialUI(navigationTitle: .hidden, navigationBarLeft: .hidden, navigationBarRight: .hidden, navigationBackground: .blue)
        topView.topViewType = .faculty
        self.navigationItem.title = "Courses"
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
    }
    
    //   MARK: Setup TableView
    func setupTableView() {
        tableView.register(UINib(nibName: FacultyTableViewCell.reuseIdentifier, bundle: .main), forCellReuseIdentifier: FacultyTableViewCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.tableFooterView = UIView(frame: .zero)
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
                    vc.imageName = "eng"
                    LoadingScreen.hide()
                }
            case 1:
                if let vc = UIStoryboard.courses.instantiateViewController(withIdentifier: DepartmentViewController.reuseIdentifier) as? DepartmentViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                    vc.type = .artsScience
                    vc.imageName = "art"
                    LoadingScreen.hide()
                }
            case 2:
                if let vc = UIStoryboard.courses.instantiateViewController(withIdentifier: DepartmentViewController.reuseIdentifier) as? DepartmentViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                    vc.type = .architecture
                    vc.imageName = "arc"
                    LoadingScreen.hide()
                }
            case 3:
                if let vc = UIStoryboard.courses.instantiateViewController(withIdentifier: DepartmentViewController.reuseIdentifier) as? DepartmentViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                    vc.type = .economics
                    vc.imageName = "eco"
                    LoadingScreen.hide()
                }
            default:
                break
            }
        }
        return cell
    }
}


