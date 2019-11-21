//
//  DepartmentTableViewCell.swift
//  Cram
//
//  Created by Mert on 4.11.2019.
//  Copyright © 2019 Mert. All rights reserved.
//

import UIKit

class DepartmentTableViewCell: BaseTableViewCell {
    
    @IBOutlet weak var departmentImageView: UIImageView!
    @IBOutlet weak var departmentLabel: UILabel!
    
    internal var tapped: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedView)))
        
    }
    
    @objc func tappedView() {
        self.tapped?()
    }

}
