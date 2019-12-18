//
//  Message.swift
//  Cram
//
//  Created by Mert on 23.11.2019.
//  Copyright © 2019 Mert. All rights reserved.
//

import UIKit
import Firebase
import MessageKit

struct Message {
    
    var id: String
    var senderID: String
    var senderName: String
    var content: String
    var created: Timestamp
    
    var dictionary: [String: Any] {
        
        return [
            "id": id,
            "senderID": senderID,
            "senderName": senderName,
            "content": content,
            "created": created
        ]
    }
}

extension Message {
    
    init?(dictionary: [String: Any]) {
        guard let id = dictionary["id"] as? String,
            let content = dictionary["content"] as? String,
            let senderID = dictionary["senderID"] as? String,
            let senderName = dictionary["senderName"] as? String,
            let created = dictionary["created"] as? Timestamp
            
            
            else {
                return nil
        }
        
        self.init(id: id, senderID: senderID, senderName: senderName, content: content, created: created)
        
    }
    
}

extension Message: MessageType {
    
    var sender: SenderType {
        return Sender(id: senderID, displayName: senderName)
        
    }
    
    var messageId: String {
        return id
    }
    
    var sentDate: Date {
        return created.dateValue()
    }
    
    var kind: MessageKind {
        return .text(content)
    }
    
    
    
}
