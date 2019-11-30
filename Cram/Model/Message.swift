//
//  Message.swift
//  Cram
//
//  Created by Mert on 23.11.2019.
//  Copyright © 2019 Mert. All rights reserved.
//

import UIKit

class Message: NSObject {
    
    var fromId: String?
    var text: String?
    var toId: String?
    var timestamp: TimeInterval?
    
    init(dictionary: [String: AnyObject]) {
        
        super.init()
        
        fromId = dictionary["fromId"] as? String
        text = dictionary["text"] as? String
        timestamp = dictionary["timestamp"] as? TimeInterval
        toId = dictionary["toId"] as? String
    }
    
}
