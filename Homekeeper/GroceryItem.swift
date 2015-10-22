//
//  GroceryItem.swift
//  Homekeeper
//
//  Created by Grayson Ricketts on 10/10/15.
//  Copyright © 2015 Team9. All rights reserved.
//

import UIKit

class GroceryItem {
    // Mark: Properties
    
    var groceryItem: String
    var additionalInfo: String
    var count: Int
    var checkout: Bool
    
    // Mark: Initializations
    
    init? (groceryItem: String, additionalInfo: String, count: Int) {
        self.groceryItem = groceryItem
        self.additionalInfo = additionalInfo
        self.count = count
        self.checkout = false
        
        if groceryItem.isEmpty || count < 0 {
            return nil
        }
    }
}
