//
//  ChatRoomViewController.swift
//  Cram
//
//  Created by Mert on 1.12.2019.
//  Copyright © 2019 Mert. All rights reserved.
//

import UIKit
import Firebase

class ChatRoomViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    internal var uid = Auth.auth().currentUser?.uid
    internal var currentClassName: String = ""
    internal var currentIndex = 0
    internal var currentClassSection: String = ""
    internal var chatRoomArray = [Class]() {
        didSet {
            tableView?.reloadData()
            LoadingScreen.hide()
            
        }
    }
    
    internal var chatRooms: [String] = [] {
        didSet {
            tableView.reloadData()
            LoadingScreen.hide()
        }
    }
    
    internal var userArray: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialUI(navigationTitle: .hidden, navigationBarLeft: .hidden, navigationBarRight: .hidden, navigationBackground: .blue)
        self.navigationItem.title = "Chats"
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        tableView.register(UINib(nibName: ChatRoomTableViewCell.reuseIdentifier, bundle: .main), forCellReuseIdentifier: ChatRoomTableViewCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.tableFooterView = UIView(frame: .zero)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getChatRooms()
        
    }
    
    
    func getChatRooms() {
        LoadingScreen.show("Loading...")
        let firestoreDatabase = Firestore.firestore().collection("users").whereField("userID", isEqualTo: self.uid)
        
        firestoreDatabase.getDocuments() { (snapshot, error) in
            if let error = error {
                print("Error: \(error)")
                return
            } else {
                if snapshot?.documents == nil {
                    print("Empty")
                } else {
                    for document in snapshot!.documents {
                        self.chatRooms = document.get("chatRooms") as! [String]
                        LoadingScreen.hide()
                    }
                }
            }
        }
        
    }
}

extension ChatRoomViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatRooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatRoomTableViewCell.reuseIdentifier, for: indexPath) as! ChatRoomTableViewCell
        cell.chatRoomSectionLabel.text = currentClassSection
        cell.chatRoomLabel.text = self.chatRooms[indexPath.row]
        
        cell.tapped = {
            LoadingScreen.show("Loading...")
            let fireStoreDatabase = Firestore.firestore().collection("classes").whereField("courseName", isEqualTo: self.chatRooms[indexPath.row])
            fireStoreDatabase.getDocuments() { (snapshot, error) in
                if let error = error {
                    print("Error: \(error)")
                    return
                } else {
                    if snapshot?.documents == nil {
                        print("Empty")
                    } else {
                        for document in snapshot!.documents {
                            self.userArray = document.get("users") as! [String]
                        }
                    }
                }
            }
            if let vc = UIStoryboard.chats.instantiateViewController(withIdentifier: ChatViewController.reuseIdentifier) as? ChatViewController {
                vc.currentChatRoom = self.chatRooms[indexPath.row]
                vc.userArray = self.userArray
                self.navigationController?.pushViewController(vc, animated: true)
                LoadingScreen.hide()
            }
            
        }
        
        return cell
        
    }
    
}
