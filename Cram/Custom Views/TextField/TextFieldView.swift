//
//  TextFieldView.swift
//  Cram
//
//  Created by Mert on 2.11.2019.
//  Copyright © 2019 Mert. All rights reserved.
//

import UIKit
import ChameleonFramework

enum TextFieldsViewType {
    case name
    case email
    case password
    case newPassword
    
}

class TextFieldView: BaseView {
    
    @IBOutlet weak var textField: UITextField! {
        didSet {
            textChange()
            
        }
    }
    private let defaultUnderlineColor = UIColor.black
    private let bottomLine = UIView()
    internal var textFieldType: TextFieldsViewType! {
        didSet {
            setupType()
        }
    }
    
    internal var text: String = "" {
        didSet{
            textField.text = text
            textChange()
        }
    }
    
    internal var isValid = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
        
        textField.borderStyle = .none
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        bottomLine.backgroundColor = defaultUnderlineColor
        bottomLine.alpha = 0.50
        self.addSubview(bottomLine)
        bottomLine.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 1).isActive = true
        bottomLine.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        bottomLine.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        bottomLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    public func setUnderlineColor(color: UIColor = UIColor.flatSkyBlueColorDark()) {
        bottomLine.backgroundColor = color
    }
    
    public func setDefaultUnderlineColor() {
        bottomLine.backgroundColor = defaultUnderlineColor
    }
    
    @objc private func textChange(){
        switch textFieldType {
        case .name:
            self.isValid = self.textField.text!.count > 1
        case .email:
            self.isValid = self.textField.text!.isValidEmail
        case .password:
            self.isValid = self.textField.text!.count > 5
        default:
            return
        }
    }
    
    private func setupType() {
        switch textFieldType! {
        case .name:
            self.textField.keyboardType = .namePhonePad
        case .email:
            self.textField.keyboardType = .emailAddress
        case .password:
            self.textField.textContentType = .password
            self.textField.isSecureTextEntry = true
        case .newPassword:
            self.textField.textContentType = .password
            self.textField.isSecureTextEntry = true
        default:
            return
        }
    }
}

extension TextFieldView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.1) {
            self.bottomLine.backgroundColor = UIColor.flatSkyBlueColorDark()
            self.bottomLine.alpha = 0.50
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.bottomLine.backgroundColor = UIColor.black
        self.bottomLine.alpha = 0.50
    }
}

