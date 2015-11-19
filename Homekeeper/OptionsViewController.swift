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
    
    var firstNameCell: UITableViewCell = UITableViewCell();
    var lastNameCell: UITableViewCell = UITableViewCell();
    var passwordCell: UITableViewCell = UITableViewCell();
    
    var firstNameText: UITextField = UITextField();
    var lastNameText: UITextField = UITextField();
    var passwordText: UITextField = UITextField();
    
    var newPasswordText: String = String();
    
    var window: UIWindow?
    
    override func loadView() {
        super.loadView()

        
        //addCancelButton();
        addSaveButton();
        self.title = "User Options"
        
        self.firstNameCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.firstNameText = UITextField(frame: CGRectInset(self.firstNameCell.contentView.bounds, 15, 0))
        self.firstNameText.placeholder = "First Name"
        self.firstNameText.text = defaults.stringForKey(AppDelegate.constants.firstNameKeyConstant);
        
        self.firstNameCell.addSubview(self.firstNameText);
        
        
        self.lastNameCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.lastNameText = UITextField(frame: CGRectInset(self.lastNameCell.contentView.bounds, 15, 0))
        self.lastNameText.placeholder = "Last Name"
        self.lastNameText.text = defaults.stringForKey(AppDelegate.constants.lastNameKeyConstant);
        
        self.lastNameCell.addSubview(self.lastNameText)
        
        self.passwordCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5);
        self.passwordText = UITextField(frame: CGRectInset(self.passwordCell.contentView.bounds, 15, 0));
        self.passwordText.placeholder = "New Password";
        self.passwordText.secureTextEntry = true;
        self.passwordCell.addSubview(self.passwordText);
    }
    
    func addCancelButton() {
        let cancel: UIBarButtonItem = UIBarButtonItem(title: "Cancel",
            style: UIBarButtonItemStyle.Done,
            target: self,
            action: "cancelButton:");
        
        self.navigationItem.leftBarButtonItem = cancel;
    }
    
    func addSaveButton() {
        let save: UIBarButtonItem = UIBarButtonItem(title: "Save",
            style: UIBarButtonItemStyle.Plain,
            target: self,
            action: "saveButton:");
        
        self.navigationItem.rightBarButtonItem = save;
    }
    
    func cancelButton(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: {});
    }
    
    func saveButton(sender: UIButton) {
        //Update info in database
        let passAlert:UIAlertController = UIAlertController(title: "Password Check",
            message: "Please input your Homekeeper password.",
            preferredStyle: UIAlertControllerStyle.Alert);
        
        passAlert.addAction(UIAlertAction(title: "Cancel",
            style: UIAlertActionStyle.Cancel,
            handler: nil));
        
        passAlert.addTextFieldWithConfigurationHandler({ (textField) in
            textField.secureTextEntry = true;
            textField.placeholder = "Password";
        })
        
        let field = passAlert.textFields![0] as UITextField;
        newPasswordText = field.text!;
        
        passAlert.addAction(UIAlertAction(title: "Submit",
            style: UIAlertActionStyle.Default,
            handler: {(action) -> Void in
                
                self.defaults.setObject(self.firstNameText.text, forKey: AppDelegate.constants.firstNameKeyConstant);
                self.defaults.setObject(self.lastNameText.text, forKey: AppDelegate.constants.lastNameKeyConstant);
                self.ref.changePasswordForUser(AppDelegate.constants.userNameKeyConstant,
                    fromOld: self.newPasswordText,
                    toNew: self.passwordText.text,
                    withCompletionBlock: nil);
        }))
    
        self.presentViewController(passAlert,
            animated: true,
            completion: nil);
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
        case 0: return 3;    // section 0 has 2 rows
        case 1: return 2;    // section 1 has 1 row
        case 2: return 1;
        default: fatalError("Unknown number of sections");
        }
    }
    
    
    
    
    // Return the row for the corresponding section and row
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch(indexPath.section) {
        case 0:
            switch(indexPath.row) {
            case 0: return self.firstNameCell;   // section 0, row 0 is the first name
            case 1: return self.lastNameCell;    // section 0, row 1 is the last name
            case 2: return self.passwordCell;
            default: fatalError("Unknown row in section 0")
            }
        default: fatalError("Unknown section")
        }
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        self.setNavigationBarItem();
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

