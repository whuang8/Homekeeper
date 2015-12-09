//
//  checkBox.swift
//  Homekeeper
//
//  Created by Jacob McKesson on 10/22/15.
//  Copyright © 2015 Team9. All rights reserved.
//

import UIKit

class checkBox: UIButton {
    
    let checkedImage = UIImage(named: "checked")
    let unCheckedImage = UIImage(named: "unchecked")
    
    var isChecked:Bool = false{
        didSet{
            if isChecked == true{
                self.setImage(checkedImage, forState: .Normal)
            }else{
                self.setImage(unCheckedImage, forState: .Normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action: "clicked:", forControlEvents: UIControlEvents.TouchUpInside)
        self.isChecked = false
    }
    
    func clicked(sender:UIButton) {
        if(sender == self){
            if isChecked == true{
                isChecked = false
                
            }else{
                isChecked = true
            }
        }
    }
    
}
