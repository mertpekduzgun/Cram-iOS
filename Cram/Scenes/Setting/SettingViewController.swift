//
//  SettingViewController.swift
//  Cram
//
//  Created by Mert on 17.11.2019.
//  Copyright © 2019 Mert. All rights reserved.
//

import UIKit
import Firebase
import CFAlertViewController
import SDWebImage

class SettingViewController: BaseViewController {
    
    //    MARK: Outlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    //    MARK: Properties
    private lazy var imagePicker: UIImagePickerController? = UIImagePickerController()
    internal var image = UIImage()
    internal var currentUser = Auth.auth().currentUser
    
    internal var userName: String = ""
    internal var userEmail: String = ""
    
    //    MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUser()
        initUI()
        getProfilePicture()
        
    }
    
    func initUI() {
        initialUI(navigationTitle: .hidden, navigationBarLeft: .hidden, navigationBarRight: .hidden, navigationBackground: .blue)
        self.profileImageView.isUserInteractionEnabled = true
        navigationController!.navigationBar.barTintColor = UIColor.flatSkyBlueColorDark()
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationItem.title = "Settings"
        self.profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
    }
    
    @objc
    func imageTapped(recognizer: UITapGestureRecognizer) {
        openAlert()
    }
    
    //    MARK: Get User Name and Email
    func getUser() {
        LoadingScreen.show("Loading...")
        
        let firestoreDatabase = Firestore.firestore().collection("users").whereField("userID", isEqualTo: self.currentUser?.uid)
        
        firestoreDatabase.getDocuments() { (snapshot, error) in
            if let error = error {
                print("Error: \(error)")
                return
            } else {
                if snapshot?.documents == nil {
                    print("Empty")
                } else {
                    for document in snapshot!.documents {
                        self.userEmail = document.get("email") as! String
                        self.userName = document.get("name") as! String
                        self.nameLabel.text = self.userName
                        LoadingScreen.hide()
                        
                    }
                }
            }
        }
    }
    
    //    MARK: Logout
    @IBAction func logoutAction(_ sender: Any) {
        do {
            
            let alert = UIAlertController(title: "Logout!", message: "Are you sure you want to sign out?", preferredStyle: .alert)
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { (alert) in
                self.dismiss(animated: false, completion: nil)
            })
            cancel.setValue(UIColor.flatSkyBlueColorDark(), forKey: "titleTextColor")
            alert.addAction(cancel)
            
            let logout = UIAlertAction(title: "Logout", style: .default, handler: { (alert) in
                if let vc = UIStoryboard.auth.instantiateViewController(withIdentifier: LoginViewController.reuseIdentifier) as? LoginViewController {
                    let nc = UINavigationController(rootViewController: vc)
                    nc.modalPresentationStyle = .fullScreen
                    self.present(nc, animated: false, completion: nil) // TODO: cancel button
                    
                }
            })
            
            logout.setValue(UIColor.flatBlackColorDark(), forKey: "titleTextColor")
            alert.addAction(logout)
            
            
            self.present(alert, animated: false)
            try Auth.auth().signOut()
        } catch {
            
        }
    }
}

//  MARK: ImagePicker
extension SettingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func openAlert() {
        let alertController = CFAlertViewController(title: "Choose an Image",
                                                    message: "",
                                                    textAlignment: .center,
                                                    preferredStyle: .actionSheet,
                                                    didDismissAlertHandler: {(dismiss) in
        })
        
        let cameraAction = CFAlertAction(title: "Camera",
                                         style: .Default,
                                         alignment: .justified,
                                         backgroundColor: UIColor.flatSkyBlueColorDark(),
                                         textColor: .white,
                                         handler: { (action) in
                                            self.openCamera()
        })
        
        let galleryAction = CFAlertAction(title: "Gallery",
                                          style: .Default,
                                          alignment: .justified,
                                          backgroundColor: UIColor.white,
                                          textColor: UIColor.flatSkyBlueColorDark(),
                                          handler: { (action) in
                                            self.openGallery()
        })
        
        imagePicker?.delegate = self
        
        alertController.addAction(cameraAction)
        alertController.addAction(galleryAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    //    MARK: Get Profil Photo
    func getProfilePicture() {
        //        Helper.showLoading(self.profileImageView)
        let firestoreDatabase = Firestore.firestore().collection("images").whereField("imageOwner", isEqualTo: self.currentUser?.uid)
        firestoreDatabase.getDocuments { (snapshot, error) in
            if let error = error {
                print("Error: \(error)")
                
                return
            } else {
                if snapshot?.documents == nil {
                    self.profileImageView.image = UIImage(named: "user")
                    Helper.hideLoading(self.profileImageView)
                } else {
                    for document in snapshot!.documents {
                        if let imageUrl = document.get("imageUrl") as? String {
                            self.profileImageView.sd_setImage(with: URL(string: imageUrl))
                            //                            Helper.hideLoading(self.profileImageView)
                        }
                    }
                }
            }
        }
    }
    
    func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            imagePicker!.sourceType = UIImagePickerController.SourceType.camera
            imagePicker!.allowsEditing = true
            self.present(imagePicker!, animated: true, completion: nil)
        }
        else {
            let alert  = UIAlertController(title: "Error", message: "Error", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallery() {
        imagePicker!.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker!.allowsEditing = true
        self.present(imagePicker!, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        profileImageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        
        if let data = profileImageView.image?.jpegData(compressionQuality: 0.5) {
            let uuid = UUID().uuidString
            let imageReference = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data, metadata: nil) { (metadata, error) in
                if error != nil {
                    Helper.showAlert(title: "Error!", message: error?.localizedDescription ?? "Error")
                } else {
                    imageReference.downloadURL { (url, error) in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            let firestore = Firestore.firestore()
                            let snap = ["imageUrl": imageUrl!, "imageOwner": self.currentUser?.uid, "created": FieldValue.serverTimestamp()] as [String: Any]
                            firestore.collection("images").document(self.currentUser!.uid).setData(snap) { (error) in
                                if error != nil {
                                    Helper.showAlert(title: "Error!", message: error?.localizedDescription ?? "Error")
                                } else {
                                    Helper.showAlert(title: "Success!", message: "Your profile picture has changed.", style: .success, position: .top)
                                    self.getProfilePicture()
                                    Helper.hideLoading(self.profileImageView)
                                    
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
