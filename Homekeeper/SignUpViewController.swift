//
//  SignUpViewController.swift
//  Homekeeper
//
//  Created by William Huang on 10/12/15.
//  Copyright © 2015 Team9. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var key=""
    var created: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)

    }
    
    @IBAction func createUser(sender: AnyObject) {
        addUser()
    }
    
    
    func addUser(){
        let ref = Firebase(url: "https://homekeeper.firebaseio.com/")
        ref.createUser(email.text, password: password.text,
            withValueCompletionBlock: { error, result in
                if error != nil {
                    // There was an error creating the account
                    print("error creating account")
                } else {
                    let uid = result["uid"] as? String
                    print("Successfully created user account with uid: \(uid)")
                    
                    
                    let ref = Firebase(url: "https://homekeeper.firebaseio.com")
                    
                    let userInfo = ["first_name": self.firstName.text!, "last_name": self.lastName.text!, "email": self.email.text!]
                    let usersRef = ref.childByAppendingPath("users")
                    let user = [uid as String!: userInfo]
                
                    usersRef.updateChildValues(user)
                    
                    self.performSegueWithIdentifier("HomeSegue", sender: self)
                    
                }
        })
    }
    
    
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        
        let performSegue = self.created
        self.created = false
        return performSegue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //This is where Tanner starts adding thigns.

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
