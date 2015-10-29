//
//  GroceryItem.swift
//  Homekeeper
//
//  Created by Grayson Ricketts on 10/10/15.
//  Copyright © 2015 Team9. All rights reserved.
//

import UIKit
import Firebase

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
    
    init(snapshot: FDataSnapshot) {
        groceryItem = snapshot.value["item"] as! String
        additionalInfo = snapshot.value["info"] as! String
        count = snapshot.value["count"] as! Int
        checkout = false
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "item": groceryItem,
            "info": additionalInfo,
            "count": count
        ]
    }
}
