//
//  HomeOptionsViewController.swift
//  Homekeeper
//
//  Created by Tanner Strom on 11/19/15.
//  Copyright © 2015 Team9. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class HomeOptionsViewController: UITableViewController {
    //Do your thing, Will
    
    let ref = Firebase(url: "https://homekeeper.firebaseio.com/");
    let defaults = NSUserDefaults.standardUserDefaults();
    
    override func loadView() {
        super.loadView();
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
}