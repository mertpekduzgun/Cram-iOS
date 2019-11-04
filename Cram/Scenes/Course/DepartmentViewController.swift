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

    override func viewDidLoad() {
        super.viewDidLoad()
        initialUI(navigationTitle: .hidden, navigationBarLeft: .hidden, navigationBackground: .blue)
    
    }
    
    

}

//extension DepartmentViewController: UITableViewDelegate, UITableViewDataSource {
//
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: DepartmentTableViewCell.reuseIdentifier, for: indexPath) as! DepartmentTableViewCell
//
//            cell.tapped = {
//                let vc = UIStoryboard(name: "Course", bundle: nil).instantiateViewController(withIdentifier: ClassViewController.reuseIdentifier) as! ClassViewController
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
//        }
//    return cell
//}

