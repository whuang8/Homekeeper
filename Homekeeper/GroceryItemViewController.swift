//
//  GroceryItemViewController.swift
//  Homekeeper
//
//  Created by Grayson Ricketts on 10/10/2015.
//  Copyright (c) 2015 Team9. All rights reserved.


import UIKit
import Foundation
import Firebase

class GroceryItemViewController: UIViewController, UITextFieldDelegate {
    // Mark: Properties
    
    @IBOutlet weak var groceryItemTextField: UITextField!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var additionalInfoTextField: UITextField!
    @IBOutlet weak var countStepper: UIStepper!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var item: GroceryItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field's user input through delegate callbacks
        groceryItemTextField.delegate = self
        additionalInfoTextField.delegate = self
        
        // Set countStepper to 1
        countStepper.value = 1
        
        // Set up item info if editing an existing item
        if let item = item {
            groceryItemTextField.text = item.groceryItem
            countStepper.value = Double(item.count)
            additionalInfoTextField.text = item.additionalInfo
            navigationItem.title = item.groceryItem
        }
        
        countLabel.text = String(format:"%d", Int(countStepper.value))
        
        // Enable save button only if text in groceryItem
        checkVaildItemName()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Mark: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard
        textField.resignFirstResponder()
        
        // Update label
        
        
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkVaildItemName()
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable save while editing
        saveButton.enabled = false
    }
    
    func checkVaildItemName() {
        let text = groceryItemTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    
    // Mark: Actions
    
    @IBAction func changeCount(sender: UIStepper) {
        // Set base value for the stepper to 1
        if countStepper.value < 1 {
            countStepper.value = 1
        }
        
        // Update count label when stepper used
        countLabel.text = String(format: "%d", Int(sender.value))
    }
    
    // Mark: Navigation
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        // Determine presentation style (modal or push)
        if presentingViewController != nil {
            dismissViewControllerAnimated(true, completion: nil)
        }
        
        else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let name = groceryItemTextField.text ?? ""
            let count = countLabel.text
            let additionalInfo = additionalInfoTextField.text
            
            // Set the item that needs to be added
            item = GroceryItem(groceryItem: name, additionalInfo: additionalInfo!, count: Int(count!)!)
        }
    }
    
    // Mark: Customization
    
    override func viewDidLayoutSubviews() {
        
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.darkGrayColor().CGColor
        border.frame = CGRect(x: 0,
            y: groceryItemTextField.frame.size.height - width,
            width:  groceryItemTextField.frame.size.width,
            height: groceryItemTextField.frame.size.height)
        
        border.borderWidth = width
        groceryItemTextField.layer.addSublayer(border)
        groceryItemTextField.layer.masksToBounds = true
        groceryItemTextField.clipsToBounds = true;
        
        let border1 = CALayer()
        //let width = CGFloat(2.0)
        border1.borderColor = UIColor.darkGrayColor().CGColor
        border1.frame = CGRect(x: 0,
            y: additionalInfoTextField.frame.size.height - width,
            width:  additionalInfoTextField.frame.size.width,
            height: additionalInfoTextField.frame.size.height)
        
        border1.borderWidth = width
        additionalInfoTextField.layer.addSublayer(border1)
        additionalInfoTextField.layer.masksToBounds = true;
        additionalInfoTextField.clipsToBounds = true;
        //additionalInfoTextField.frame.size.height = 30;
        
        countStepper.layer.cornerRadius = 10;
        countStepper.layer.borderWidth = 1.0;
        countStepper.alpha = 0.5;
    }
}

