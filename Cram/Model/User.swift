//
//  User.swift
//  Cram
//
//  Created by Mert on 23.11.2019.
//  Copyright © 2019 Mert. All rights reserved.
//

import UIKit
import Firebase

struct User {
    
    var uid: String
    var name: String
    var email: String
    let imageURL: String?
    
    var dictionary: [String: Any] {
        
        return [
            "uid": uid,
            "name": name,
            "email": email,
            "imageURL": imageURL ?? ""
        ]
        
    }
}

extension User {
    
    init?(dictionary: [String: Any]) {
        guard let uid = dictionary["uid"] as? String,
            let name = dictionary["name"] as? String,
            let email = dictionary["email"] as? String,
            let imageURL = dictionary["imageURL"] as? String?
         
            
            
            else {
                return nil
        }
        
        self.init(uid: uid, name: name, email: email, imageURL: imageURL)
        
    }
}


