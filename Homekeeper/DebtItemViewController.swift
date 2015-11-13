//
//  DebtItemViewController.swift
//  Homekeeper
//
//  Created by Tanner Strom on 10/15/15.
//  Copyright © 2015 Team9. All rights reserved.
//

import Foundation
import UIKit

class DebtItemViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var personTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    var debtitem: DebtItem?
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if submitButton === sender {
            let amount = amountTextField.text ?? "";
            let message = messageTextField.text ?? "";
            let person = personTextField.text ?? "";
            
            debtitem = DebtItem(amount: amount, message: message, personInDebt: person);
        }
        
        //dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        personTextField.delegate = self
        
        if let debtitem = debtitem {
            personTextField.text = debtitem.personInDebt;
            amountTextField.text = debtitem.amount;
            messageTextField.text = debtitem.message;
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    
    
    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}