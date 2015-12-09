//
//  HouseholdsViewController.swift
//  Homekeeper
//
//  Created by William Huang on 11/10/15.
//  Copyright © 2015 Team9. All rights reserved.
//

import UIKit
import Firebase


class HouseholdsViewController: UIViewController {
    @IBOutlet weak var phoneNumber: UITextField!
    
    
    
    @IBAction func createButton(sender: AnyObject) {
//        let ref = Firebase(url: "https://homekeeper.firebaseio.com")
//        
//        let userInfo = ["Users": NSUserDefaults.standardUserDefaults().stringForKey(AppDelegate.constants.userNameKeyConstant)!]
//        let usersRef = ref.childByAppendingPath("households")
//        let user = [homeName.text! as String: userInfo]
//        
//        usersRef.updateChildValues(user)
        
//        let swiftRequest = SwiftRequest();
//        let code = arc4random_uniform(8999) + 1000
//        
//        let data = [
//            "To" : phoneNumber.text! as String,
//            "From" : "+15555556666",
//            "Body" : String(code) as String
//        ];
//        
//        swiftRequest.post("https://api.twilio.com/2010-04-01/Accounts/[YOUR_ACCOUNT_SID]/Messages",
//            auth: ["username" : "AC649285e6c28e16f014f1da368c53967a", "password" : "60d28108598d7bb0b868e8d34e3bc58b"],
//            data: data,
//            callback: {err, response, body in
//                if err == nil {
//                    print("Success: \(response)")
//                } else {
//                    print("Error: \(err)")
//                }
//        });
        
        
        
        dismissViewControllerAnimated(true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
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
