//
//  GroceryItemViewController.swift
//  Homekeeper
//
//  Created by Grayson Ricketts on 10/10/2015.
//  Copyright (c) 2015 Team9. All rights reserved.


import UIKit


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
        let isPresentingInAddItemMode = presentingViewController is UINavigationController
        
        if isPresentingInAddItemMode {
            navigationController!.popViewControllerAnimated(true)
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
}

