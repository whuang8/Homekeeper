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
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func loadSampleItems() {
        let item1 = GroceryItem(groceryItem: "Shit", additionalInfo: "", count: 2)!
        let item2 = GroceryItem(groceryItem: "Other", additionalInfo: "Things go here", count: 5)!
        let item3 = GroceryItem(groceryItem: "Test", additionalInfo: "Stuff", count: 1)!
        
        items += [item1, item2, item3]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    /*
    let cellIdentifier = "GroceryItemCell"
    
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! GroceryItemTableViewCell
    
    // Fetches the meal for the specific row
    let item = items[indexPath.row]
    
    // Configure the cell
    cell.groceryItemLabel.text = item.groceryItem
    cell.additionalInfoLabel.text = item.additionalInfo
    cell.countLabel.text = String(format: "%d", item.count)
    
    return cell
    */

    
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
            // Add item
            let newIndexPath = NSIndexPath(forRow: items.count, inSection: 0)
            items.append(item)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
        }
    }
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
