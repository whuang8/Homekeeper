//
//  LogInViewController.swift
//  Homekeeper
//
//  Created by William Huang on 9/28/15.
//  Copyright © 2015 Team9. All rights reserved.
//

import UIKit


class LogInViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

  
    }
    
    //runs when login button is hit
    @IBAction func logIn(sender: UIButton) {
        
        checkTextFields()
        
    }
    
    //runs when sign up button is hit
    @IBAction func signUp(sender: UIButton) {
        
        
    }
    
    func checkTextFields(){
        var title = ""
        var message = ""
        var missing = false
        if(passwordText.text!.isEmpty && emailText.text!.isEmpty){
            title = "Missing login credentials"
            message = "Please enter an email address and password to log in"
            missing = true
        }
        else if(emailText.text!.isEmpty){
            title = "Email Missing"
            message = "Please enter a email address to log in"
            missing = true
        }
        else if(passwordText.text!.isEmpty){
            title = "Password Missing"
            message = "Please enter a password to log in"
            missing = true
        }
        
        if(missing){
            // Initialize Alert Controller
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
            
            // Initialize Actions
            let okAction = UIAlertAction(title: "Ok", style: .Default) { (action) -> Void in
                print("Ok")
            }
            
            // Add Actions
            alertController.addAction(okAction)
            
            // Present Alert Controller
            self.presentViewController(alertController, animated: true, completion: nil)
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
