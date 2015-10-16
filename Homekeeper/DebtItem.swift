//
//  DebtItem.swift
//  Homekeeper
//
//  Created by Tanner Strom on 10/15/15.
//  Copyright © 2015 Team9. All rights reserved.
//

import Foundation
import UIKit

class DebtItem {
    var amount: Double;
    var message: String;
    var personInDebt: String;
    //var debtor: String;
    var paid: Bool;
    
    init? (amount: Double, message: String, personInDebt: String) {
        self.amount = amount;
        self.message = message;
        self.personInDebt = personInDebt;
        //self.debtor = debtor;
        self.paid = false;
        
        if amount == 0.0 {
            return nil;
        }
    }
}