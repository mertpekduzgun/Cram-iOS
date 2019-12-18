//
//  ChatRoomViewController.swift
//  Cram
//
//  Created by Mert on 1.12.2019.
//  Copyright © 2019 Mert. All rights reserved.
//

import UIKit

class ChatRoomViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialUI(navigationTitle: .hidden, navigationBarLeft: .hidden, navigationBarRight: .hidden, navigationBackground: .blue)
        tableView.register(UINib(nibName: ChatRoomTableViewCell.reuseIdentifier, bundle: .main), forCellReuseIdentifier: ChatRoomTableViewCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.tableFooterView = UIView(frame: .zero)

    }
    

    
   
}

extension ChatRoomViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatRoomTableViewCell.reuseIdentifier, for: indexPath) as! ChatRoomTableViewCell
        
        return cell
        
    }
    
    
    
    
}
