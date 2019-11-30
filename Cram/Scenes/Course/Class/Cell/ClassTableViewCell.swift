//
//  ClassTableViewCell.swift
//  Cram
//
//  Created by Mert on 25.11.2019.
//  Copyright © 2019 Mert. All rights reserved.
//

import UIKit

class ClassTableViewCell: BaseTableViewCell {

    @IBOutlet weak var classImageView: UIImageView!
    @IBOutlet weak var classNameLabel: UILabel!
    @IBOutlet weak var classSectionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
