//
//  DebtItem.swift
//  Homekeeper
//
//  Created by Tanner Strom on 10/15/15.
//  Copyright © 2015 Team9. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class DebtItem {
    var amount: String;
    var message: String;
    var personInDebt: String;
    //var debtor: String;
    var paid: Bool;
    var ref = Firebase()
    
    init? (amount: String, message: String, personInDebt: String) {
        self.amount = amount;
        self.message = message;
        self.personInDebt = personInDebt;
        //self.debtor = debtor;
        self.paid = false;
        
        if amount.isEmpty {
            return nil;
        }
    }
    
    init (snapshot: FDataSnapshot) {
        amount = snapshot.value["amount"] as! String
        message = snapshot.value["message"] as! String
        personInDebt = snapshot.value["personInDebt"] as! String
        paid = false
        ref = snapshot.ref
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "amount": amount,
            "message": message,
            "personInDebt": personInDebt,
            "paid": paid
        ]
    }
}