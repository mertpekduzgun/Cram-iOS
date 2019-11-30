//
//  BaseTableViewCell.swift
//  Cram
//
//  Created by Mert on 4.11.2019.
//  Copyright © 2019 Mert. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    class var reuseIdentifier: String{
        get{
            return String(describing: self.classForCoder())
        }
    }

    internal var item: Any?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }


    internal func initializeItem(_ item: Any) {
        self.item = item
    }
}
