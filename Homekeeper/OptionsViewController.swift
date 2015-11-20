//
//  OptionsTableViewController.swift
//  Homekeeper
//
//  Created by Tanner Strom on 11/10/15.
//  Copyright © 2015 Team9. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class OptionsViewController: UITableViewController {
    
    let ref = Firebase(url: "https://homekeeper.firebaseio.com/");
    
    let defaults = NSUserDefaults.standardUserDefaults();
    let options = ["User Options", "Home Options"];
    
    var userOptionsCell: UITableViewCell = UITableViewCell();
    var homeOptionsCell: UITableViewCell = UITableViewCell();
    
    var userOptionsButton: UIButton = UIButton();
    var homeOptionsButton: UIButton = UIButton();
    
    var window: UIWindow?
    
    override func loadView() {
        super.loadView()
        
        addCancelButton();

        self.title = "Options"
        
        //I don't know why I didn't make functions for these but whatever. You'll live.

        self.userOptionsCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5);
        self.userOptionsCell.textLabel?.text = "User Options";
        //self.userOptionsCell.targetForAction("toUserOptions:", withSender: self);
        
        self.homeOptionsCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5);
        self.homeOptionsCell.textLabel?.text = "Home Options";
        //self.homeOptionsCell.targetForAction("toHomeOptions:", withSender: self);
        }
    
    //Buttons and their functions
    
    func addCancelButton() {
        let cancel: UIBarButtonItem = UIBarButtonItem(title: "Cancel",
            style: UIBarButtonItemStyle.Done,
            target: self,
            action: "cancelButton:");
        
        self.navigationItem.leftBarButtonItem = cancel;
    }
    
    func cancelButton(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: {});
    }
    
    //View changes
    
    func toUserOptions() {
        let userOptionsView: UserOptionsViewController = UserOptionsViewController();
        self.navigationController?.pushViewController(userOptionsView, animated: true);
    }
    
    func toHomeOptions() {
        let homeOptionsView: HomeOptionsViewController = HomeOptionsViewController();
        self.navigationController?.pushViewController(homeOptionsView, animated: true);
    }
    
    //Overrides
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
        case 0: return 2;
        case 1: return 1;
        default: fatalError("Unknown number of sections");
        }
    }
    
    // Return the row for the corresponding section and row
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch(indexPath.section) {
        case 0:
            switch(indexPath.row) {
            case 0: return self.userOptionsCell;   // section 0, row 0 is the first name
            case 1: return self.homeOptionsCell;    // section 0, row 1 is the last name
            default: fatalError("Unknown row in section 0")
            }
        default: fatalError("Unknown section")
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch(indexPath.section) {
        case 0:
            switch(indexPath.row) {
            case 0: toUserOptions();
            case 1: toHomeOptions();
            default: fatalError("Unknown function");
            }
        default: fatalError("Unknown section");
        }
    }
    
    // Customize the section headings for each section
    /*override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section) {
        case 0: return "Profile"
        case 1: return "User Info"
        default: fatalError("Unknown section")
        }
    }*/
}

