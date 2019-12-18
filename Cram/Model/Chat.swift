//
//  Chat.swift
//  Cram
//
//  Created by Mert on 1.12.2019.
//  Copyright © 2019 Mert. All rights reserved.
//

import UIKit

struct Chat {
    
    var users: [String]
    
    var dictionary: [String: Any] {
        return ["users": users]
    
    }
}

extension Chat {
    
    init?(dictionary: [String:Any]) {
        guard let chatUsers = dictionary["users"] as? [String] else {return nil}
        self.init(users: chatUsers)
    }
    
}
