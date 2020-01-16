//
//  BoardViewController.swift
//  Cram
//
//  Created by Mert on 15.01.2020.
//  Copyright © 2020 Mert. All rights reserved.
//

import UIKit

class BoardViewController: BaseViewController {
    
    @IBOutlet weak var announceTableView: UITableView!
    @IBOutlet weak var quizTableView: UITableView!
    @IBOutlet weak var examTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initUI()
    }
    
    func initUI() {
        initialUI(navigationTitle: .hidden, navigationBarLeft: .whiteBack, navigationBarRight: .hidden, navigationBackground: .blue)
        self.title = "Board"
        
        announceTableView.register(UINib(nibName: BoardTableViewCell.reuseIdentifier, bundle: .main), forCellReuseIdentifier: BoardTableViewCell.reuseIdentifier)
        announceTableView.rowHeight = UITableView.automaticDimension
        announceTableView.estimatedRowHeight = announceTableView.rowHeight
        announceTableView.tableFooterView = UIView(frame: .zero)
        
        quizTableView.register(UINib(nibName: BoardTableViewCell.reuseIdentifier, bundle: .main), forCellReuseIdentifier: BoardTableViewCell.reuseIdentifier)
        quizTableView.rowHeight = UITableView.automaticDimension
        quizTableView.estimatedRowHeight = quizTableView.rowHeight
        quizTableView.tableFooterView = UIView(frame: .zero)
        
        examTableView.register(UINib(nibName: BoardTableViewCell.reuseIdentifier, bundle: .main), forCellReuseIdentifier: BoardTableViewCell.reuseIdentifier)
        examTableView.rowHeight = UITableView.automaticDimension
        examTableView.estimatedRowHeight = examTableView.rowHeight
        examTableView.tableFooterView = UIView(frame: .zero)
    }
}

extension BoardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == announceTableView {
            return 1
        } else if tableView == quizTableView {
            return 2
        } else {
            return 3
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == announceTableView {
            let cell = announceTableView.dequeueReusableCell(withIdentifier: BoardTableViewCell.reuseIdentifier, for: indexPath) as! BoardTableViewCell
            
            return cell
        } else if tableView == quizTableView {
            let cell = quizTableView.dequeueReusableCell(withIdentifier: BoardTableViewCell.reuseIdentifier, for: indexPath) as! BoardTableViewCell
            
            return cell
        } else {
            let cell = examTableView.dequeueReusableCell(withIdentifier: BoardTableViewCell.reuseIdentifier, for: indexPath) as! BoardTableViewCell
            
            return cell
        }
        
        
    }
    
}
