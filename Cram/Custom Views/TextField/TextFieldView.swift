//
//  TextFieldView.swift
//  Cram
//
//  Created by Mert on 2.11.2019.
//  Copyright © 2019 Mert. All rights reserved.
//

import UIKit

enum TextFieldsViewType {
    case name
    case email
    case password
    case newPassword
    
}

class TextFieldView: BaseView {
    
    @IBOutlet weak var textField: UITextField!
    private let defaultUnderlineColor = UIColor.black
    private let bottomLine = UIView()
    internal var textFieldType: TextFieldsViewType! {
        didSet {
            setupType()
        }
    }
    
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
    
    public func setUnderlineColor(color: UIColor = .cramBlue) {
        bottomLine.backgroundColor = color
    }
    
    public func setDefaultUnderlineColor() {
        bottomLine.backgroundColor = defaultUnderlineColor
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
            self.bottomLine.backgroundColor = UIColor.blue
            self.bottomLine.alpha = 0.50
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.bottomLine.backgroundColor = UIColor.black
        self.bottomLine.alpha = 0.50
    }
}

