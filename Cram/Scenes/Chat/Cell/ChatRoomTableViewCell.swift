//
//  ChatRoomTableViewCell.swift
//  Cram
//
//  Created by Mert on 1.12.2019.
//  Copyright © 2019 Mert. All rights reserved.
//

import UIKit

class ChatRoomTableViewCell: BaseTableViewCell {

    @IBOutlet weak var chatRoomImageView: UIImageView!
    @IBOutlet weak var chatRoomLabel: UILabel!
    @IBOutlet weak var chatRoomSectionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
