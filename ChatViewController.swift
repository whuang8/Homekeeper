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