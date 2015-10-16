//
//  ToDo.swift
//  Homekeeper
//
//  Created by Jacob McKesson on 10/14/15.
//  Copyright © 2015 Team9. All rights reserved.
//

import UIKit

class ToDo {
    
    //Properties
    var message: String
    
    //initalize
    init?(message: String) {
        self.message = message
        if (message.isEmpty) {
                return nil
        }
    
    }


}
