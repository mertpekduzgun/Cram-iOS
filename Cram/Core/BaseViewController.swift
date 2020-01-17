//
//  BaseViewController.swift
//  Cram
//
//  Created by Mert on 2.11.2019.
//  Copyright © 2019 Mert. All rights reserved.
//

import UIKit

enum NavigationLeft {
    case whiteBack
    case close
    case hidden
}

enum NavigationTitle {
    case logo
    case hidden
}

enum NavigationBackground {
    case white
    case blue
    case gray
    case transparent
}

enum NavigationRight {
    case white
    case hidden
    case board
}

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
            navigationBarLeftButton.action = #selector(closedPressed(animated:))
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
            navigationBarRightButton.action = #selector(addButtonPressed(animated:))
        case .board:
            navigationBarRightButton.image = UIImage(named: "chalkboard")
            self.navigationItem.rightBarButtonItem = navigationBarRightButton
            self.navigationItem.rightBarButtonItem?.target = self
            navigationBarRightButton.action = #selector(boardPressed(animated:))
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
        
        statusBarStyle = UIStatusBarStyle.lightContent
    }
    
    @objc open func closedPressed(animated: Bool = true) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc open func navigationBarBackButtonPressed(animated: Bool = true) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc open func addButtonPressed(animated: Bool = true) {
        let vc = UIStoryboard.courses.instantiateViewController(withIdentifier: AddClassViewController.reuseIdentifier) as! AddClassViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc open func boardPressed(animated: Bool = true) {
        let vc = UIStoryboard.courses.instantiateViewController(withIdentifier: BoardViewController.reuseIdentifier) as! BoardViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)

    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard gestureRecognizer.isEqual(self.navigationController?.interactivePopGestureRecognizer) else { return true }
        let pointOfTouch = gestureRecognizer.location(in: self.view)
        let isTouchInBottomHalf = (pointOfTouch.y >= self.view.bounds.height / 2)
        return !isTouchInBottomHalf
    }
    
    
}
