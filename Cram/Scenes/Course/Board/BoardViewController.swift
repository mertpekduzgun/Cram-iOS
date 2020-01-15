//
//  BoardViewController.swift
//  Cram
//
//  Created by Mert on 15.01.2020.
//  Copyright © 2020 Mert. All rights reserved.
//

import UIKit

class BoardViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initUI()
    }
    
    func initUI() {
        initialUI(navigationTitle: .hidden, navigationBarLeft: .whiteBack, navigationBarRight: .hidden, navigationBackground: .blue)
        self.title = "Board"
    }
}
