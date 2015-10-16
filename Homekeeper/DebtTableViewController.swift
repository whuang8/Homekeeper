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
        //self.setNavigationBarItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func loadSampleItems() {
        let item1 = DebtItem(amount: "69.00", message: "I hate you", personInDebt: "Lee Anne")!;
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
    
    @IBAction func unwindToDebtList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? DebtItemViewController, debtitem = sourceViewController.debtitem {
            let newIndexPath = NSIndexPath(forRow: debts.count, inSection: 0);
            debts.append(debtitem);
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom);
        }
    }
    
}