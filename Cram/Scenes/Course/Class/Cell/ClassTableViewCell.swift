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
    
    internal var tapped: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedView)))
    }

    @objc func tappedView() {
        self.tapped?()
    }
    
}
