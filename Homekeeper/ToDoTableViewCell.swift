//
//  ToDoTableViewCell.swift
//  Homekeeper
//
//  Created by Jacob McKesson on 10/14/15.
//  Copyright © 2015 Team9. All rights reserved.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
    
    //Properties
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var cBox: checkBox!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
