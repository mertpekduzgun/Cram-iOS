//
//  TopView.swift
//  Cram
//
//  Created by Mert on 7.11.2019.
//  Copyright © 2019 Mert. All rights reserved.
//

import UIKit

enum topViewType {
    case login
    case register
    case faculty
    case department
    case classroom
}

class TopView: BaseView {
    
    @IBOutlet weak var headLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    
    internal var topViewType: topViewType! {
        didSet {
            initUI()
        }
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func initUI() {
        switch topViewType {
        case .login:
            headLabel.text = "Login"
            subLabel.text = "Enter your Işık mail and password."
        case .register:
            headLabel.text = "Register"
            subLabel.text = "Create a new account."
        case .faculty:
            headLabel.text = "Faculty"
            subLabel.text = "Select your faculty."
        case .department:
            headLabel.text = "Department"
            subLabel.text = "Select your department."
        case .classroom:
            headLabel.text = "Class"
            subLabel.text = "Select your class"
            
        default:
            break
        }
        
    }
    
}
