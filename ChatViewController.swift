//
//  ChatViewController.swift
//
//
//  Created by Tanner Strom on 10/14/15.
//
//

import Foundation
import UIKit

class ChatViewController: UIViewController {
    
    @IBAction func toLogin(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "LogInMain", bundle: nil);
        let controller = storyboard.instantiateViewControllerWithIdentifier("LogInViewController");
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        // Move landing to login if some var is nil
        if (defaults.stringForKey(AppDelegate.constants.userNameKeyConstant) == nil) {
            let storyboard = UIStoryboard(name: "LogInMain", bundle: nil);
            
            let controller = storyboard.instantiateViewControllerWithIdentifier("LogInViewController") as! LogInViewController
            let navController = UINavigationController(rootViewController: controller);
            
            navController.title = "Options";
            self.presentViewController(navController, animated: false, completion: nil)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        //navigationItem.setRightBarButtonItem(UIBarButtonSystemItem.Add, animated: true);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}