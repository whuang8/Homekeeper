//
//  CompletedTableViewCell.swift
//  
//
//  Created by Jacob McKesson on 12/7/15.
//
//

import UIKit

class CompletedTableViewCell: UITableViewCell {

    //Properties
    @IBOutlet weak var task: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var user: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
