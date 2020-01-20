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
    
    //    MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //    MARK: Properties
    internal var uid = Auth.auth().currentUser?.uid
    internal var currentClassName: String = ""
    internal var currentClassSection: String = ""
    internal var currentIndex = 0
    internal var classSectionArray: [String] = []
    internal var ImagesArray: [UIImage] = []
    internal var userArray: [String] = []
    
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
    
    //    MARK: Lifecyles
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        setupTableViewUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getChatRooms()
        print(self.classSectionArray)
    }
    
    //  MARK: Setup UI
    func initUI() {
        initialUI(navigationTitle: .hidden, navigationBarLeft: .hidden, navigationBarRight: .hidden, navigationBackground: .blue)
        self.navigationItem.title = "Chats"
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    //    MARK: Setup TableView
    func setupTableViewUI() {
        tableView.register(UINib(nibName: ChatRoomTableViewCell.reuseIdentifier, bundle: .main), forCellReuseIdentifier: ChatRoomTableViewCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    
    //    MARK: Get Chat Rooms
    func getChatRooms() {
        LoadingScreen.show("Loading...")
        let firestoreDatabase = Firestore.firestore()
            .collection("users")
            .whereField("userID", isEqualTo: self.uid)
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
                    }
                }
            }
        }
        
    }
}

//  MARK: TableView
extension ChatRoomViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatRooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatRoomTableViewCell.reuseIdentifier, for: indexPath) as! ChatRoomTableViewCell
        cell.chatRoomLabel.text = self.chatRooms[indexPath.row]
        let firestoreDatabase = Firestore.firestore()
            .collection("classes")
            .whereField("courseName", isEqualTo: self.chatRooms[indexPath.row])
        firestoreDatabase.getDocuments() { (snapshot, error) in
            if let error = error {
                print("Error: \(error)")
                return
            } else {
                if snapshot?.documents == nil {
                    print("Empty")
                } else {
                    for document in snapshot!.documents {
                        let classSection = document.get("section") as! String
                        cell.chatRoomSectionLabel.text = classSection
                        LoadingScreen.hide()
                    }
                }
            }
        }
        
        
        cell.tapped = {
            LoadingScreen.show("Loading...")
            let fireStoreDatabase = Firestore.firestore()
                .collection("users")
                .whereField(self.uid!, isEqualTo: self.chatRooms[indexPath.row])
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
                vc.currentChatRoom = self.chatRooms[indexPath.row] as! String
                vc.userArray = self.userArray
                self.navigationController?.pushViewController(vc, animated: true)
                LoadingScreen.hide()
            }
            
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            
            Firestore.firestore().collection("users")
                .document(self.uid!)
                .updateData(["chatRooms": FieldValue.arrayRemove([self.chatRooms[indexPath.row]])]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        LoadingScreen.show("Loading...")
                        print("Document successfully updated")
                        print(self.chatRooms[indexPath.row])
                        self.chatRooms.remove(at: indexPath.row)
                        self.getChatRooms()
                    }
            }
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Delete"
    }
    
}

