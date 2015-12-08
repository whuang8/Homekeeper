//
//  GroceryItemTableViewCell.swift
//  Homekeeper
//
//  Created by Grayson Ricketts on 10/11/15.
//  Copyright © 2015 Team9. All rights reserved.
//

import UIKit

class GroceryItemTableViewCell: UITableViewCell {
    
    // Mark: Properties
    
    @IBOutlet weak var groceryItemLabel: UILabel!
    @IBOutlet weak var additionalInfoLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var checkoutSwitch: UISwitch!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
        //checkoutSwitch.on = false
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
