//
//  FacultyViewController.swift
//  Cram
//
//  Created by Mert on 5.11.2019.
//  Copyright © 2019 Mert. All rights reserved.
//

import UIKit
import FirebaseDatabase

enum facultyType {
    case engineering
    case fineArts
    case architecture
    case economics
}

class FacultyViewController: BaseViewController {
    
    @IBOutlet weak var topView: TopView!
    @IBOutlet weak var tableView: UITableView!
    
    internal var facultyNames = ["Engineering", "Arts and Sciences", "Architecture and Design", "Economics and Administrative Sciences"]
    internal var facultyImageNames = ["eng", "art", "arc", "eco"]
    
    internal var type: facultyType = .engineering
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topView.topViewType = .faculty
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
        
        let cell = Bundle.main.loadNibNamed(FacultyTableViewCell.reuseIdentifier, owner: self, options: nil)?.first as! FacultyTableViewCell
        cell.facultyNameLabel.text = self.facultyNames[indexPath.row]
        cell.facultyImageView.image = UIImage(named: self.facultyImageNames[indexPath.row])
        cell.tapped = {
            switch indexPath.row {
            case 0:
                if let vc = UIStoryboard.courses.instantiateViewController(withIdentifier: DepartmentViewController.reuseIdentifier) as? DepartmentViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                    self.type = .engineering
                }
                
            case 1:
                if let vc = UIStoryboard.courses.instantiateViewController(withIdentifier: DepartmentViewController.reuseIdentifier) as? DepartmentViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                    self.type = .fineArts

                }
                
            case 2:
                if let vc = UIStoryboard.courses.instantiateViewController(withIdentifier: DepartmentViewController.reuseIdentifier) as? DepartmentViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                    self.type = .architecture

                }
                
            case 3:
                if let vc = UIStoryboard.courses.instantiateViewController(withIdentifier: DepartmentViewController.reuseIdentifier) as? DepartmentViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                    self.type = .economics

                }
                
            default:
                break
            }
            
        }
        return cell
    }
}


