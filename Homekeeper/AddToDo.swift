//
//  AddToDo.swift
//  Homekeeper
//
//  Created by Jacob McKesson on 10/14/15.
//  Copyright © 2015 Team9. All rights reserved.
//

import UIKit

class AddToDo: UIViewController, UITextFieldDelegate {
    
    //Properties
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var justALabel: UILabel!
    @IBOutlet weak var saveNewItem: UIBarButtonItem!
    @IBOutlet weak var messageInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputTextField.delegate = self
        
        if let todo = todo {
            inputTextField.text = todo.task
            messageInput.text = todo.message
        }
        
        //if let todo = todo {
        //navigationItem.title = todo.message
        //}
        
        //checkValidMessage()
    }
    
    var todo: ToDo?
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*func textFieldDidBeginEditing(textField: UITextField) {
    //Disable the Save button while editing.
    saveNewItem.enabled = false
    }*/
    
    /*func checkValidMessage() {
    // Disable the Save button if the text field is empty.
    let text = inputTextField.text ?? ""
    saveNewItem.enabled = !text.isEmpty
    }*/
    
    /*func textFieldDidEndEditing(textField: UITextField) {
    checkValidMessage()
    navigationItem.title = textField.text
    }*/
    
    //Actions
    
    //Navigation
    //@IBAction func cancel(sender: UIBarButtonItem) {
    //    dismissViewControllerAnimated(true, completion: nil)
    //}
    
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
        if saveNewItem === sender {
            let task = inputTextField.text
            let message = messageInput.text
            
            //let username = NSUserName()
            let username = NSUserName()
            
            
            todo = ToDo(message: message!, user: username, task: task!, timeChecked: 0, checkedUser: "none")
        }
    }
    
}
