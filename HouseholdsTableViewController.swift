//
//  HouseholdsTableViewController.swift
//  Homekeeper
//
//  Created by William Huang on 11/12/15.
//  Copyright © 2015 Team9. All rights reserved.
//

import UIKit
import Firebase

//class HouseholdUser {
//    // Mark: Properties
//    
//    var users: String!
//    var ref: Firebase?
//    
//    // Mark: Initializations
//    
//    init? (users: String!) {
//        self.users = users
//        
//        
//        if users.isEmpty {
//            return nil
//        }
//    }
//    
//    init (snapshot: FDataSnapshot) {
//        users = snapshot.value["user"] as! String
//        ref = snapshot.ref
//    }
//    
//    func toAnyObject() -> AnyObject {
//        return [
//            "user": users
//        ]
//    }
//    
//}


class HouseholdsTableViewController: UITableViewController {
    
    //var users = [HouseholdUser]()
    var ref = Firebase()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //preserve selection between presentations
        self.setNavigationBarItem()
        self.clearsSelectionOnViewWillAppear = false
        self.navigationController!.setToolbarHidden(false, animated: true)
        
        title = NSUserDefaults.standardUserDefaults().stringForKey(AppDelegate.constants.homeNameKeyConstant)
        
        ref = Firebase(url: "https://homekeeper.firebaseio.com/households/")
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(true, animated: animated)
//        ref.observeEventType(.Value, withBlock: { snapshot in
//            // Create and populate new array with database entries
//            var newItems = [HouseholdUser]()
//            for item in snapshot.children {
//                let hh = HouseholdUser(snapshot: item as! FDataSnapshot)
//                newItems.append(hh)
//            }
//            
//            // Set new array equal to old and reload data
//            self.users = newItems
//            self.tableView.reloadData()
//        })
    }
    
    func addHousehold(){
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.setNavigationBarItem()
        self.navigationController?.toolbarHidden = false
    
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return users.count
//    }

//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cellIdentifier = "HouseholdsTableViewCell"
//        
//        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! HouseholdsTableViewCell
//        
//        let home = users[indexPath.row]
//        
//        cell.Label.text = home.users
//        return cell
//    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            let home = users[indexPath.row]
            
            home.ref!.removeValue()
        }
    }
    */

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

    
     //MARK: - Navigation

     //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
         //Get the new view controller using segue.destinationViewController.
         //Pass the selected object to the new view controller.
    }
    
    @IBAction func unwindToHouseholds(sender: UIStoryboardSegue) {
        
       
    }


}
