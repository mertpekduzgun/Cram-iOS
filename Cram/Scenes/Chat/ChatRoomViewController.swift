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
    internal var currentClassSection: String = ""
    internal var currentIndex = 0
    internal var classSectionArray: [String] = []
    internal var ImagesArray: [UIImage] = []
    
    
    
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
        let notificationCenter: NotificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(currentClassInfo), name: .notificationClassInfo, object: nil)
        getChatRooms()
        print(self.classSectionArray)
    }
    
    @objc
    func currentClassInfo() {
        
    }
    
    func getSectionNumber() {
        LoadingScreen.show("Loading...")
        let firestoreDatabase = Firestore.firestore()
            .collection("classes")
            .whereField("courseName", isEqualTo: self.currentClassName)
        firestoreDatabase.getDocuments() { (snapshot, error) in
            if let error = error {
                print("Error: \(error)")
                return
            } else {
                if snapshot?.documents == nil {
                    print("Empty")
                } else {
                    for document in snapshot!.documents {
                        self.currentClassSection = document.get("section") as! String
                        LoadingScreen.hide()
                    }
                }
            }
        }
        
    }
    
    
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
        cell.chatRoomLabel.text = self.chatRooms[indexPath.row]
//        cell.chatRoomImageView.image = self.ImagesArray[indexPath.row]
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

extension Notification.Name {
    static let notificationClassInfo = Notification.Name("NotificationClassInfo")
}
