//
//  DebtTableViewController.swift
//  Homekeeper
//
//  Created by Tanner Strom on 10/15/15.
//  Copyright © 2015 Team9. All rights reserved.
//

import Foundation
import UIKit

class DebtTableViewController: UITableViewController {
    var debts = [DebtItem]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleItems()
        self.setNavigationBarItem()
        self.title = "Debt Tracker";
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func loadSampleItems() {
        let item1 = DebtItem(amount: "69.00", message: "idk man", personInDebt: "Lee Anne")!;
        let item2 = DebtItem(amount: "420.00", message: "That good kush", personInDebt: "Lance")!;
        let item3 = DebtItem(amount: "42.00", message: "Nerds are cool", personInDebt: "Tanner")!;
        
        debts += [item1, item2, item3];
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
            debts.removeAtIndex(indexPath.row);
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic);
        }
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let debtDetailViewController = segue.destinationViewController as! DebtItemViewController
            

            if let selectedDebtCell = sender as? DebtItemTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedDebtCell)!
                let selectedMeal = debts[indexPath.row]
                debtDetailViewController.debtitem = selectedMeal
            }
        }
        else if segue.identifier == "AddItem" {
            print("Adding new cell");
        }
    }
    
    @IBAction func unwindToDebtList(sender: UIStoryboardSegue) {
        
        let sourceViewController = sender.sourceViewController as? DebtItemViewController
        
        if (sourceViewController != nil), let debt = sourceViewController?.debtitem {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                debts[selectedIndexPath.row] = debt
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            }
            else {
                let newIndexPath = NSIndexPath(forRow: debts.count, inSection: 0)
                debts.append(debt)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
        }
    }
}