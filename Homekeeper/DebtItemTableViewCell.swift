//
//  DebtItemTableViewCell.swift
//  Homekeeper
//
//  Created by Tanner Strom on 10/15/15.
//  Copyright © 2015 Team9. All rights reserved.
//

import Foundation
import UIKit

class DebtItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var debtLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var debtorLabel: UILabel!
    //@IBOutlet weak var personInDebtLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}