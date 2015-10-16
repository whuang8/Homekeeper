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
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.setNavigationBarItem()
        //self.addRightBarButtonWithImage(<#T##buttonImage: UIImage##UIImage#>)
    }
    
    func loadSampleItems() {
        let item1 = DebtItem(amount: 69.00, message: "I hate you", personInDebt: "Lee Anne")!;
        let item2 = DebtItem(amount: 420.00, message: "That good kush", personInDebt: "Lance")!;
        let item3 = DebtItem(amount: 42.00, message: "Nerds are cool", personInDebt: "Tanner")!;
        
        debts += [item1, item2, item3];
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return debts.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "DebtItemTableViewCell";
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! DebtItemTableViewCell;
        let item = debts[indexPath.row];
        
        cell.debtLabel.text = String(item.amount);
        cell.messageLabel.text = item.message;
        cell.debtorLabel.text = item.personInDebt;
        
        return cell;
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true;
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            debts.removeAtIndex(indexPath.row);
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade);
        } else if editingStyle == .Insert {
            
        }
    }
    /*
    @IBAction func unwindForSegue(unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        if let sourceViewController = sender.sourceViewController as? DebtItemViewController, item = sourceViewController.item {
            items[selectedIndexPath.row] = item;
            tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None);
        } else {
            let newIndexPath - NSIndexPath(forRow: items.count, inSection: 0);
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom);
        }
    }
*/
}