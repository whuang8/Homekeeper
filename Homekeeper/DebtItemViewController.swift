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
    
    @IBOutlet var personInDebt: UITextField!
    @IBOutlet var debt: UITextField!
    @IBOutlet var message: UITextField!
    @IBOutlet var submit: UIButton!
    @IBOutlet var cancel: UIButton!
    
    var item: DebtItem?
    
    override func viewDidLoad() {
        super.viewDidLoad();
        personInDebt.delegate = self;
        debt.delegate = self;
        message.delegate = self;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    
    /*func textFieldDidEndEditing(textField: UITextField) {
        checkValidItemName();
    }*/
    
    func textFieldDidBeginEditing(textField: UITextField) {
        submit.enabled = false;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if submit === sender {
            let name = personInDebt.text ?? "";
            let owed = Double(debt.text!)
            let threat = message.text;
            
            item = DebtItem(amount: owed!, message: threat!, personInDebt: name)!
        }
    }
    
}