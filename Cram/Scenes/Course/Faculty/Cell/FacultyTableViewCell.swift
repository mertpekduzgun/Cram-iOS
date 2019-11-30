//
//  FacultyTableViewCell.swift
//  Cram
//
//  Created by Mert on 7.11.2019.
//  Copyright © 2019 Mert. All rights reserved.
//

import UIKit

class FacultyTableViewCell: BaseTableViewCell {

    @IBOutlet weak var facultyImageView: UIImageView!
    @IBOutlet weak var facultyNameLabel: UILabel!
    
    internal var tapped: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedView)))

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func tappedView() {
        self.tapped?()
    }
    
}
