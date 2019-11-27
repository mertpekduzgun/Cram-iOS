//
//  User.swift
//  Cram
//
//  Created by Mert on 23.11.2019.
//  Copyright © 2019 Mert. All rights reserved.
//

import UIKit

class User {
    
    static let sharedUserInfo = User()
    
    var uid = ""
    var name = ""
    var email = ""
    
    private init() {
        
    }
}
