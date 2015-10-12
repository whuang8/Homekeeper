//
//  LogInViewController.swift
//  Homekeeper
//
//  Created by William Huang on 9/28/15.
//  Copyright © 2015 Team9. All rights reserved.
//

import UIKit
import Firebase


class LogInViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    var loggedIn: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
  
    }
    
    //runs when login button is hit
    @IBAction func logIn(sender: UIButton) {
        checkTextFields()
        let ref = Firebase(url: "https://homekeeper.firebaseio.com/")
        ref.authUser(emailText.text, password: passwordText.text,
            withCompletionBlock: { error, authData in
                if error != nil {
                    // There was an error logging in to this account
                    print("Error in log in")
                    self.emailText.text = ""
                    self.passwordText.text = ""
                    self.loggedIn = false
                    
                    let title = "Wrong Login Credentials"
                    let message = "Please try again."
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
                    
                } else {
                    // We are now logged in
                    print("Log in successful")
                    self.loggedIn = true
                    self.performSegueWithIdentifier("SignInSegue", sender: self)
                }
        })
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        
        let performSegue = self.loggedIn
        self.loggedIn = false
        return performSegue
    }
    
    //runs when sign up button is hit
    @IBAction func signUp(sender: UIButton) {
        self.performSegueWithIdentifier("SignUpSegue", sender: self)
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
    
    
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
