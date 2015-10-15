//
//  DebtViewController.swift
//  Homekeeper
//
//  Created by Tanner Strom on 10/13/15.
//  Copyright © 2015 Team9. All rights reserved.
//

import Foundation
import UIKit

class DebtViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}