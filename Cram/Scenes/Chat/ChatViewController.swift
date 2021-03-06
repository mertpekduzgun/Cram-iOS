//
//  ChatViewController.swift
//  Cram
//
//  Created by Mert on 17.11.2019.
//  Copyright © 2019 Mert. All rights reserved.
//

import UIKit
import Firebase
import MessageKit
import InputBarAccessoryView
import SDWebImage

class ChatViewController: MessagesViewController {
    
    //    MARK: Properties
    internal var currentUser = Auth.auth().currentUser!
    let firestoreDatabase = Firestore.firestore()
    private var ref: DocumentReference?
    internal var messages: [Message] = []
    internal var userArray: [String] = []
    internal var currentChatRoom: String = ""
    internal var userName: String = ""
    internal var senderImageView: UIImageView = UIImageView(image: UIImage(named: "user"))
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        setupCollectionViewUI()
        hideKeyboardWhenTappedAround()
        getUserName()
        getProfilePicture()
        loadChat()
    }
    
    //    MARK: Setup UI
    func initUI() {
        initialUI(navigationTitle: .hidden, navigationBarLeft: .whiteBack, navigationBarRight: .hidden, navigationBackground: .blue)
        self.title = self.currentChatRoom
    }
    
    //    MARK: Setup Message Collection View
    func setupCollectionViewUI() {
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messagesLayoutDelegate = self
        messageInputBar.delegate = self
        
        messageInputBar.inputTextView.tintColor = .black
        messageInputBar.sendButton.setTitleColor(UIColor.flatSkyBlueColorDark(), for: .normal)
        maintainPositionOnKeyboardFrameChanged = true
        navigationItem.largeTitleDisplayMode = .never
    }
    
    //    MARK: Get User Name
    func getUserName() {
        let firestoreDatabase = Firestore.firestore().collection("users").whereField("userID", isEqualTo: self.currentUser.uid)
        
        firestoreDatabase.getDocuments { (snapshot, error) in
            if let error = error {
                print("Error: \(error)")
                return
            } else {
                if snapshot?.documents == nil {
                    print("Empty")
                } else {
                    for document in snapshot!.documents {
                        if let userDisplayName = document.get("name") as? String {
                            self.userName = userDisplayName
                            
                        }
                    }
                }
            }
        }
    }
    
    func getProfilePicture() {
        let firestoreDatabase = Firestore.firestore().collection("images").whereField("imageOwner", isEqualTo: self.currentUser.uid)
        firestoreDatabase.getDocuments { (snapshot, error) in
            if let error = error {
                print("Error: \(error)")
                return
            } else {
                if snapshot?.documents == nil {
                    print(error)
                } else {
                    for document in snapshot!.documents {
                        if let imageUrl = document.get("imageUrl") as? String {
                            self.senderImageView.sd_setImage(with: URL(string: imageUrl))
                        }
                    }
                }
            }
        }
    }
    
    
    //    MARK: Load Chat
    func loadChat() {
        
        let firestoreDatabase = Firestore.firestore().collection("classes").whereField("users", arrayContains: self.currentUser.uid)
        
        firestoreDatabase.getDocuments { (snapshot, error) in
            if let error = error {
                print("Error: \(error)")
                return
                
            } else {
                guard let queryCount = snapshot?.documents.count else {
                    return
                }
                if queryCount == 0 {
                    print("There is no User!")
                } else if queryCount >= 1 {
                    for doc in snapshot!.documents {
                        self.userArray = doc.get("users") as! [String]
                        
                        let chat = Chat(dictionary: doc.data())
                        print("chat: ", chat)
                        
                        self.ref = doc.reference
                        
                        doc.reference.collection(self.currentChatRoom).order(by: "created", descending: false).addSnapshotListener(includeMetadataChanges: true, listener: { (threadQuery, error) in
                            if let error = error {
                                print("Error: \(error)")
                                return
                            } else {
                                self.messages.removeAll()
                                for message in threadQuery!.documents {
                                    let msg = Message(dictionary: message.data())
                                    self.messages.append(msg!)
                                    print("Data: \(msg?.content ?? "No Messages")")
                                }
                                self.messagesCollectionView.reloadData()
                                self.messagesCollectionView.scrollToBottom(animated: true)
                            }
                        })
                        return
                        
                    }
                }
            }
        }
    }
    
    //    MARK: Insert Message
    private func insertNewMessage(_ message: Message) {
        messages.append(message)
        messagesCollectionView.reloadData()
        DispatchQueue.main.async {
            self.messagesCollectionView.scrollToBottom(animated: true)
        }
    }
    
    //    MARK: Save Action
    private func save(_ message: Message) {
        let data: [String: Any] = [
            "content": message.content,
            "created": message.created,
            "id": message.id,
            "senderID": message.senderID,
            "senderName": message.senderName
        ]
        
        ref?.collection(self.currentChatRoom).addDocument(data: data, completion: { (error) in
            if let error = error {
                print("Error Sending message: \(error)")
                return
            }
            self.messagesCollectionView.scrollToBottom()
        })
        
    }
}

// MARK: Messages
extension ChatViewController: MessagesDataSource, MessagesDisplayDelegate, MessagesLayoutDelegate, InputBarAccessoryViewDelegate {
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        
        let message = Message(id: UUID().uuidString, senderID: currentUser.uid, senderName: self.userName , content: text, created: Timestamp())
        insertNewMessage(message)
        save(message)
        
        inputBar.inputTextView.text = ""
        messagesCollectionView.reloadData()
        messagesCollectionView.scrollToBottom(animated: true)
    }
    
    func currentSender() -> SenderType {
        return Sender(id: Auth.auth().currentUser?.uid ?? "", displayName: self.userName )
        
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        if messages.count == 0 {
            print("There are no messages")
            return 0
        } else {
            return messages.count
        }
    }
    
    func avatarSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return .zero
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        if message.sender.senderId == currentUser.uid {
            SDWebImageManager.shared.loadImage(with: currentUser.photoURL, options: .highPriority, progress: nil) { (image, data, error, cacheType, isFinished, imageUrl) in
                
                avatarView.image = self.senderImageView.image
            }
        } else {
            SDWebImageManager.shared.loadImage(with: currentUser.photoURL, options: .highPriority, progress: nil) { (image, data, error, cacheType, isFinished, imageUrl) in
                avatarView.image = image
            }
        }
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight: .bottomLeft
        
        return .bubbleTail(corner, .curved)
    }
    
    func cellTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 10
    }
    
    func isTimeLabelVisible(at indexPath: IndexPath) -> Bool {
        return indexPath.section % 3 == 0 && !isPreviousMessageSameSender(at: indexPath)
    }
    
    func isPreviousMessageSameSender(at indexPath: IndexPath) -> Bool {
        guard indexPath.section - 1 >= 0 else { return false }
        return messages[indexPath.section].senderName == messages[indexPath.section - 1].senderName
    }
    
    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        if isTimeLabelVisible(at: indexPath) {
            return NSAttributedString(string: MessageKitDateFormatter.shared.string(from: message.sentDate), attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10), NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        }
        return nil
    }
    
    func cellBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 10
    }
    
    func cellBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let name = message.sender.displayName
        return NSAttributedString(
            string: name,
            attributes: [
                .font: UIFont.montserratMedium(ofsize: 10),
                .foregroundColor: UIColor(white: 0.3, alpha: 1)
            ]
        )
    }   
}

extension ChatViewController {
    
    class var reuseIdentifier: String {
        get {
            return String(describing: self.classForCoder())
        }
    }
    
    @objc open func navigationBarBackButtonPressed(animated: Bool = true) {
        navigationController?.popViewController(animated: true)
    }
    
    func initialUI(navigationTitle: NavigationTitle, navigationBarLeft: NavigationLeft, navigationBarRight: NavigationRight, navigationBackground: NavigationBackground) {
        let navigationBarLeftButton = UIBarButtonItem()
        switch navigationBarLeft {
        case .whiteBack:
            navigationBarLeftButton.image = UIImage(named: "back")
            self.navigationItem.leftBarButtonItem = navigationBarLeftButton
            self.navigationItem.leftBarButtonItem?.target = self
            navigationBarLeftButton.action = #selector(navigationBarBackButtonPressed(animated:))
        case .close:
            navigationBarLeftButton.image = UIImage(named: "closeWhite")
            self.navigationItem.leftBarButtonItem = navigationBarLeftButton
            self.navigationItem.leftBarButtonItem?.target = self
        case .hidden:
            self.navigationItem.leftBarButtonItem = nil
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIView(frame: .zero))
        }
        
        switch navigationTitle {
        case .logo:
            let titleImageView = UIImageView(image: UIImage(named: "isik"))
            self.navigationItem.titleView = titleImageView
        case .hidden:
            self.navigationItem.titleView = nil
            
        }
        let navigationBarRightButton = UIBarButtonItem()
        switch navigationBarRight {
        case .white:
            navigationBarRightButton.image = UIImage(named: "add")
            self.navigationItem.rightBarButtonItem = navigationBarRightButton
            self.navigationItem.rightBarButtonItem?.target = self
        case .board:
            navigationBarRightButton.image = UIImage(named: "chalkboard")
            self.navigationItem.rightBarButtonItem = navigationBarRightButton
            self.navigationItem.rightBarButtonItem?.target = self
        case .hidden:
            self.navigationItem.rightBarButtonItem = nil
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: UIView(frame: .zero))
        }
        
        switch navigationBackground {
        case .blue:
            self.navigationController?.navigationBar.barTintColor = UIColor.flatSkyBlueColorDark()
            self.navigationController?.navigationBar.backgroundColor = UIColor.flatSkyBlueColorDark()
        case .white:
            self.navigationController?.navigationBar.barTintColor = UIColor.white
            self.navigationController?.navigationBar.backgroundColor = UIColor.white
        case .gray:
            self.navigationController?.navigationBar.barTintColor = UIColor.darkGray
            self.navigationController?.navigationBar.backgroundColor = UIColor.darkGray
        case .transparent:
            self.navigationController?.navigationBar.makeTransparent()
        }
    }
}
