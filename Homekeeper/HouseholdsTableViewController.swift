//
//  HouseholdsTableViewController.swift
//  Homekeeper
//
//  Created by William Huang on 11/14/15.
//  Copyright © 2015 Team9. All rights reserved.
//
//

import UIKit
import Firebase

class HouseholdsTableViewController: UITableViewController {


    var ref = Firebase()
    
    // Mark: Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSUserDefaults.standardUserDefaults().stringForKey(AppDelegate.constants.homeNameKeyConstant)
        // Navigation and toolbar setup
        self.setNavigationBarItem()
        self.navigationController?.toolbarHidden = false
        setupFirebase()

    }
    
    func setupFirebase() {
        ref = Firebase(url: "https://homekeeper.firebaseio.com/households" + NSUserDefaults.standardUserDefaults().stringForKey(AppDelegate.constants.homeNameKeyConstant)!)
    }
    
    override func viewDidAppear(animated: Bool) {
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func deleteHousehold(sender: UIBarButtonItem) {
        //self.presentViewController(alertController, animated: true, completion: nil)
        title = "No Home"
    }
    
    
    
    // MARK: - Table view data source
    
    /*override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }*/ 
    
    /*override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      
    }*/
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    // Override to support editing the table view.
    /*override func tableView(tableView: UITableView, commitEditingStyle editingStyle:UITableViewCellEditingStyle,
        forRowAtIndexPath indexPath: NSIndexPath) {
    }*/
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Load data for detail view
        
    }
}
