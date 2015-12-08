//
//  DebtTableViewController.swift
//  Homekeeper
//
//  Created by Tanner Strom on 10/15/15.
//  Copyright © 2015 Team9. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class DebtTableViewController: UITableViewController {
    var debts = [DebtItem]()
    var ref = Firebase()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarItem()
        self.setupFirebase()
        
        
    }
    
    func setupFirebase() {
        ref = Firebase(url: "https://homekeeper.firebaseio.com/debts/" + NSUserDefaults.standardUserDefaults().stringForKey(AppDelegate.constants.homeNameKeyConstant)!)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        ref.observeEventType(.Value, withBlock: { snapshot in
            // Create and populate new array with database entries
            var newDebts = [DebtItem]()
            for item in snapshot.children {
                let debtItem = DebtItem(snapshot: item as! FDataSnapshot)
                newDebts.append(debtItem)
            }
            
            // Set new array equal to old and reload data
            self.debts = newDebts
            self.tableView.reloadData()
        })
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return debts.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellID", forIndexPath: indexPath) as! DebtItemTableViewCell
        
        let debt = debts[indexPath.row];
        
        cell.debtLabel.text = debt.amount;
        cell.messageLabel.text = debt.message;
        cell.debtorLabel.text = debt.personInDebt;
        
        return cell;
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true;
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            // Delete the row from the data source
            let debtItem = debts[indexPath.row]
            debtItem.ref.removeValue()
            debts.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic);
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let debtDetailViewController = segue.destinationViewController as! DebtItemViewController
            

            if let selectedDebtCell = sender as? DebtItemTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedDebtCell)!
                let selectedDebt = debts[indexPath.row]
                debtDetailViewController.debtitem = selectedDebt
            }
        }
    }
    
    @IBAction func unwindToDebtList(sender: UIStoryboardSegue) {
        
        let sourceViewController = sender.sourceViewController as? DebtItemViewController
        
        if (sourceViewController != nil), let debt = sourceViewController?.debtitem {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                debts[selectedIndexPath.row].ref.updateChildValues(debt.toAnyObject() as! [NSObject : AnyObject])
                
                debts[selectedIndexPath.row] = debt
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            }
            else {
                let newIndexPath = NSIndexPath(forRow: debts.count, inSection: 0)
                debts.append(debt)
                
                let debtItemRef = ref.childByAutoId()
                
                debtItemRef.setValue(debt.toAnyObject())
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
        }
    }
    
    //UI Things
    
    
}