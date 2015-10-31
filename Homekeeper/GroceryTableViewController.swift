//
//  GroceryTableViewController.swift
//  Homekeeper
//
//  Created by Grayson Ricketts on 10/11/15.
//  Copyright © 2015 Team9. All rights reserved.
//

import UIKit
import Firebase

class GroceryTableViewController: UITableViewController {
    
    // Mark: Properties
    
    var items = [GroceryItem]()
    let ref = Firebase(url: "https://homekeeper.firebaseio.com/grocery-items/" + NSUserDefaults.standardUserDefaults().stringForKey(AppDelegate.constants.homeNameKeyConstant)!)
    
    // Mark: Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation and toolbar setup
        self.setNavigationBarItem()
        self.navigationController?.toolbarHidden = false
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }
    
    override func viewDidAppear(animated: Bool) {
        ref!.observeEventType(.Value, withBlock: { snapshot in
            // Create and populate new array with database entries
            var newItems = [GroceryItem]()
            for item in snapshot.children {
                let groceryItem = GroceryItem(snapshot: item as! FDataSnapshot)
                newItems.append(groceryItem)
            }
            
            // Set new array equal to old and reload data
            self.items = newItems
            self.tableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Mark: Actions
    
    @IBAction func checkoutPressed(sender: UIBarButtonItem) {
        let tableView = self.tableView
        
        // Remove rows that are switched to be checked out
        for var row = items.count - 1; row >= 0; row-- {
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: row, inSection: 0)) as! GroceryItemTableViewCell
            
            if cell.checkoutSwitch.on {
                items.removeAtIndex(row)
                items[row].ref!.removeValue()
            }
        }
        
        tableView.reloadData()
    }
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "GroceryItemTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! GroceryItemTableViewCell

        let item = items[indexPath.row]
        
        cell.groceryItemLabel.text = item.groceryItem
        cell.additionalInfoLabel.text = item.additionalInfo
        cell.countLabel.text = String(format: "%d", item.count)
        cell.checkoutSwitch.setOn(item.checkout, animated: false)

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            let groceryItem = items[indexPath.row]
            
            groceryItem.ref?.removeValue()
        }
    }
    
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

    
    // MARK: - Navigation
    
    @IBAction func unwindForSegue(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? GroceryItemViewController, item = sourceViewController.item {
            let rootRef = Firebase(url: "https://homekeeper.firebaseio.com/")
            let itemsRef = rootRef.childByAppendingPath("grocery-items/testHome")
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update item
                items[selectedIndexPath.row].ref!.updateChildValues(item.toAnyObject() as! [NSObject : AnyObject])
                
                items[selectedIndexPath.row] = item
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            }
                
            else {
                // Add item
                let newIndexPath = NSIndexPath(forRow: items.count, inSection: 0)
                items.append(item)
    
                let groceryItemRef = itemsRef.childByAutoId()
                
                groceryItemRef.setValue(item.toAnyObject())
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Load data for detail view
        if segue.identifier == "ShowDetail" {
            let itemDetailViewController = segue.destinationViewController as! GroceryItemViewController
            
            // Get the cell that generated this view
            if let selectedItemCell = sender as? GroceryItemTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedItemCell)!
                let selectedItem = items[indexPath.row]
                itemDetailViewController.item = selectedItem
            }
        }
    }
    
    
}
