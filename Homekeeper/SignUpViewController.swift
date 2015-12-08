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
    @IBOutlet weak var submit: UIButton!
    @IBOutlet weak var cancel: UIButton!
    
    var key=""
    var created: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
        self.view.backgroundColor = UIColor.clearColor();
        backgroundImage()
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
    
    //Start Tanner's stuff here
    
    
    @IBAction func cancelAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    override func viewDidLayoutSubviews() {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.darkGrayColor().CGColor
        border.frame = CGRect(x: 0,
            y: firstName.frame.size.height - width,
            width:  firstName.frame.size.width,
            height: firstName.frame.size.height)
        
        border.borderWidth = width
        firstName.layer.addSublayer(border)
        firstName.layer.masksToBounds = true
        firstName.clipsToBounds = true;
        
        let border1 = CALayer()
        //let width = CGFloat(1.0)
        border1.borderColor = UIColor.darkGrayColor().CGColor
        border1.frame = CGRect(x: 0,
            y: email.frame.size.height - width,
            width:  email.frame.size.width,
            height: email.frame.size.height)
        
        border1.borderWidth = width
        email.layer.addSublayer(border1)
        email.layer.masksToBounds = true
        email.clipsToBounds = true;
        
        let border2 = CALayer()
        //let width = CGFloat(1.0)
        border2.borderColor = UIColor.darkGrayColor().CGColor
        border2.frame = CGRect(x: 0,
            y: lastName.frame.size.height - width,
            width:  lastName.frame.size.width,
            height: lastName.frame.size.height)
        
        border2.borderWidth = width
        lastName.layer.addSublayer(border2)
        lastName.layer.masksToBounds = true
        lastName.clipsToBounds = true;
        
        let border3 = CALayer()
        //let width = CGFloat(1.0)
        border3.borderColor = UIColor.darkGrayColor().CGColor
        border3.frame = CGRect(x: 0,
            y: password.frame.size.height - width,
            width:  password.frame.size.width,
            height: password.frame.size.height)
        
        border3.borderWidth = width
        password.layer.addSublayer(border3)
        password.layer.masksToBounds = true
        password.clipsToBounds = true;
        
        submit.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue:1.0, alpha: 1.0);
        submit.tintColor = UIColor.whiteColor();
        submit.alpha = 0.50;
        submit.layer.cornerRadius = 10
        ;
        submit.clipsToBounds = true;
        
        cancel.setTitle("Cancel", forState: .Normal);
        
    }
    
    func backgroundImage() {
        let width = UIScreen.mainScreen().bounds.size.width
        let height = UIScreen.mainScreen().bounds.size.height
        
        let imageViewBackground = UIImageView(frame: CGRectMake(0, 0, width, height))
        imageViewBackground.image = UIImage(named: "background.jpg")
        
        // you can change the content mode:
        imageViewBackground.contentMode = UIViewContentMode.ScaleAspectFill
        
        self.view.addSubview(imageViewBackground);
        self.view.sendSubviewToBack(imageViewBackground);
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
