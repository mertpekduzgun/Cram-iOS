//
//  ChatRoom.swift
//  Cram
//
//  Created by Mert on 14.01.2020.
//  Copyright © 2020 Mert. All rights reserved.
//

import UIKit

struct ChatRoom {
    
    var classNames: String
    var sections: String
//    var images: String
    
    var dictionary: [String: Any] {
        return ["classNames": classNames, "sections": sections]
    
    }
}



