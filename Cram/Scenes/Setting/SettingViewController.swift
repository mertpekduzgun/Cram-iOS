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
import Kingfisher

class SettingViewController: BaseViewController {
    
//    MARK: Outlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
//    MARK: Properties
    private lazy var imagePicker: UIImagePickerController? = UIImagePickerController()
    internal var image = UIImage()
    internal var currentUserName = App.shared.user?.name
    
    private var user: User!

//    MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        
    }
    
    func initUI() {
        initialUI(navigationTitle: .hidden, navigationBarLeft: .hidden, navigationBarRight: .hidden, navigationBackground: .blue)
        self.profileImageView.isUserInteractionEnabled = true
        navigationController!.navigationBar.barTintColor = UIColor.flatSkyBlueColorDark()
        navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationItem.title = "Settings"
        self.profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
        self.nameLabel.text = currentUserName
    }
    
    @objc
    func imageTapped(recognizer: UITapGestureRecognizer) {
        openAlert()
    }
    
    private func loadData(data: User) {
        if let url = data.imageURL {
            Helper.setImageWithLoading(url: url, self.profileImageView)
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
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
