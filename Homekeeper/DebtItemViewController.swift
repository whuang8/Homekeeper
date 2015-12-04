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
        
        //self.personTextField = TextField()
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        
        
        //personTextField = UITextField(frame: CGRectMake(0,
            //self.view.bounds.height / 2,
            //self.view.bounds.width / 2,
            //30))
        
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.darkGrayColor().CGColor
        border.frame = CGRect(x: 0,
            y: personTextField.frame.size.height - width,
            width:  personTextField.frame.size.width,
            height: personTextField.frame.size.height)
        
        border.borderWidth = width
        personTextField.layer.addSublayer(border)
        personTextField.layer.masksToBounds = true
        personTextField.clipsToBounds = true;
        
        let border1 = CALayer()
        //let width = CGFloat(2.0)
        border1.borderColor = UIColor.darkGrayColor().CGColor
        border1.frame = CGRect(x: 0,
            y: messageTextField.frame.size.height - width,
            width:  messageTextField.frame.size.width,
            height: messageTextField.frame.size.height);
        
        border1.borderWidth = width;
        messageTextField.layer.addSublayer(border1);
        messageTextField.layer.masksToBounds = true;
        messageTextField.clipsToBounds = true;
        messageTextField.frame.size.height = 30;
        //messageTextField.frame.size.width = 150
        
        let border2 = CALayer()
        //let width = CGFloat(2.0)
        border2.borderColor = UIColor.darkGrayColor().CGColor
        border2.frame = CGRect(x: 0, y: amountTextField.frame.size.height - width, width:  amountTextField.frame.size.width, height: amountTextField.frame.size.height)
        
        border2.borderWidth = width
        amountTextField.layer.addSublayer(border2)
        amountTextField.layer.masksToBounds = true
        amountTextField.clipsToBounds = true;
        //amountTextField.frame.size.height = 30;
        
        submitButton.frame = CGRectMake(submitButton.frame.width / 2,
            self.view.layer.frame.height / 2,
            245,
            30);
        
        //submitButton.frame.size.width = 145;
        //submitButton.frame.size.height = 30;
        
        //submitButton.backgroundColor.
        submitButton.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue:1.0, alpha: 1.0);
        submitButton.tintColor = UIColor.whiteColor();
        submitButton.alpha = 0.85;
        submitButton.layer.cornerRadius = 10;
        //submitButton.layer.borderColor = UIColor.grayColor().CGColor;
        //submitButton.layer.borderWidth = 1.0;
        submitButton.clipsToBounds = true;
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