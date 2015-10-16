//
//  GroceryTableViewController.swift
//  Homekeeper
//
//  Created by Grayson Ricketts on 10/11/15.
//  Copyright © 2015 Team9. All rights reserved.
//

import UIKit

class GroceryTableViewController: UITableViewController {
    
    // Mark: Properties
    
    var items = [GroceryItem]()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Load sample items
        loadSampleItems()
        
        // Navigation and toolbar setup
        self.setNavigationBarItem()
        self.navigationController?.toolbarHidden = false
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }
    
    func loadSampleItems() {
        let item1 = GroceryItem(groceryItem: "Blueberries", additionalInfo: "", count: 2)!
        let item2 = GroceryItem(groceryItem: "Waffles", additionalInfo: "Lego my Ego", count: 5)!
        let item3 = GroceryItem(groceryItem: "Hot pockets", additionalInfo: "Yumm", count: 75)!
        
        items += [item1, item2, item3]
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

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            items.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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

    
    // MARK: - Navigation
    
    @IBAction func unwindForSegue(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? GroceryItemViewController, item = sourceViewController.item {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing item
                items[selectedIndexPath.row] = item
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            }
                
            else {
                // Add item
                let newIndexPath = NSIndexPath(forRow: items.count, inSection: 0)
                items.append(item)
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
