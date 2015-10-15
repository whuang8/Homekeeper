//
//  AddToDo.swift
//  Homekeeper
//
//  Created by Jacob McKesson on 10/14/15.
//  Copyright © 2015 Team9. All rights reserved.
//

import UIKit

class AddToDo: UIViewController {

    //Properties
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var justALabel: UILabel!
    @IBOutlet weak var saveNewItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //inputTextField.delegate = self
        
        checkValidMessage()
    }
    
    var todo: ToDo?
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        //Disable the Save button while editing.
        saveNewItem.enabled = false
    }
    
    func checkValidMessage() {
        // Disable the Save button if the text field is empty.
        let text = inputTextField.text ?? ""
        saveNewItem.enabled = !text.isEmpty
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidMessage()
        navigationItem.title = textField.text
    }
    
    //Actions
    
    //Navigation
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveNewItem === sender {
            let message = inputTextField.text
            todo = ToDo(message: message!)
        }
    }
    
}
