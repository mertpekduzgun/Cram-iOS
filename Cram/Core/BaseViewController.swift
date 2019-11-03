//
//  BaseViewController.swift
//  Cram
//
//  Created by Mert on 2.11.2019.
//  Copyright © 2019 Mert. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, UIGestureRecognizerDelegate {
    
    class var reuseIdentifier: String {
        get {
            return String(describing: self.classForCoder())
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.statusBarStyle
    }
    
    var statusBarStyle: UIStatusBarStyle = .lightContent {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            isModalInPresentation = true
        }
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil

    }
    
    func initialUI(navigationBarTitleIsImage: Bool = false, navigationBarLeft: String?, navigationBarRight: String? = nil) {
        if navigationBarTitleIsImage {
            let titleImage = UIImage(named: "") // TODO: Logo Yükle
            let titleImageView = UIImageView(image: titleImage)
            self.navigationItem.titleView = titleImageView
        } else {
            self.navigationItem.title = title
        }
        
        let navigationBarLeftButton = UIBarButtonItem()
        if navigationBarLeft != nil {
            navigationBarLeftButton.image = UIImage(named: navigationBarLeft!)
            self.navigationItem.leftBarButtonItem = navigationBarLeftButton
            self.navigationItem.leftBarButtonItem?.target =  self
            navigationBarLeftButton.action = #selector(navigationBarBackButtonPressed)
        } else {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIView(frame: .zero))
        }
        
        
        self.view.backgroundColor = .white
        navigationController?.navigationBar.backgroundColor = UIColor.red
        navigationController?.navigationBar.barTintColor = UIColor.red
        navigationController?.navigationBar.tintColor = UIColor.red
        self.view.backgroundColor = UIColor.red
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white,
                                                                   NSAttributedString.Key.font : UIFont.montserratMedium(ofsize: 18)]
        statusBarStyle = UIStatusBarStyle.lightContent
    }
    
    @objc open func navigationBarBackButtonPressed(animated: Bool = true) {
        navigationController?.popViewController(animated: true)
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard gestureRecognizer.isEqual(self.navigationController?.interactivePopGestureRecognizer) else { return true }
        let pointOfTouch = gestureRecognizer.location(in: self.view)
        let isTouchInBottomHalf = (pointOfTouch.y >= self.view.bounds.height / 2)
        return !isTouchInBottomHalf
    }
        
    
}
