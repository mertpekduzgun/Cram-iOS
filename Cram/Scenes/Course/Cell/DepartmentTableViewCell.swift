//
//  DepartmentTableViewCell.swift
//  Cram
//
//  Created by Mert on 4.11.2019.
//  Copyright © 2019 Mert. All rights reserved.
//

import UIKit

class DepartmentTableViewCell: BaseTableViewCell {
    
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var departmentImageView: UIImageView!
    @IBOutlet weak var departmentNameLabel: UILabel!
    @IBOutlet weak var numberOfMember: UILabel!
    
    internal var tapped: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.cellView.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(tappedView)))
        
    }
    
    @objc func tappedView() {
        self.tapped?()
    }

}
