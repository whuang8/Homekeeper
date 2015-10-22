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
    var num: Int?
    
    @IBAction func toLogin(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "LogInMain", bundle: nil);
        let controller = storyboard.instantiateViewControllerWithIdentifier("LogInViewController");
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        // Move landing to login if some var is nil
        if num == nil {
            let storyboard = UIStoryboard(name: "LogInMain", bundle: nil);
            let controller = storyboard.instantiateViewControllerWithIdentifier("LogInViewController") as! LogInViewController
            self.slideMenuController()?.changeMainViewController(controller, close: false)
            
            num = 1
        }*/
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