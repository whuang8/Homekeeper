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