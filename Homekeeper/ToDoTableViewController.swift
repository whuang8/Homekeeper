//
//  ToDoTableViewController.swift
//  Homekeeper
//
//  Created by Jacob McKesson on 10/14/15.
//  Copyright © 2015 Team9. All rights reserved.
//

import UIKit
import Firebase

class ToDoTableViewController: UITableViewController {
    
    //Properties
    var todos = [ToDo]()
    var todosArchive = [ToDo]()
    var todo: ToDo?
    
    let ref = Firebase(url: "https://homekeeper.firebaseio.com/todo-items/testHome/active")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavigationBarItem()
        self.navigationController?.toolbarHidden = false;
        //loadToDos()
    }
    
    
    override func viewDidAppear(animated: Bool) {
        print(ref)
        
        ref.observeEventType(.Value, withBlock: { snapshot in
            // Create and populate new array with database entries
            var newItems = [ToDo]()
            //var deletedItems = [ToDo]()
            for item in snapshot.children {
                let todoItem = ToDo(snapshot: item as! FDataSnapshot)
                if (todoItem.timeChecked != 100) {
                    newItems.append(todoItem)
                }
                else {
                    print("changing")
                    
                    let r = Firebase(url: "https://homekeeper.firebaseio.com/todo-items/testHome/completed")
                    
                    let task = todoItem.task
                    let message = todoItem.message
                    
                    //let username = NSUserName()
                    let username = NSUserName()
                    
                    
                    let comp = ToDo(message: message, user: username, task: task, timeChecked: 0, checkedUser: todoItem.checkedUser)
                    let todoItemRef = r.childByAutoId()
                    todoItemRef.setValue(comp!.toAnyObject())
                    
                    todoItem.ref?.removeValue()
                }
            }
            
            // Set new array equal to old and reload data
            self.todos = newItems
            
            self.tableView.reloadData()
        })
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "ToDoTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ToDoTableViewCell
        
        let todo = todos[indexPath.row]
        
        cell.testLabel.text = todo.task
        cell.messageLabel.text = todo.message
        cell.userLabel.text = todo.user
        
        if (cell.cBox.isChecked == true && todos[indexPath.row].timeChecked != 50) {
            todos[indexPath.row].checkedUser = NSUserName()
            cell.userLabel.text = NSUserName()
            //todos[indexPath.row].timeChecked = 100
            todos[indexPath.row].ref!.updateChildValues(todo.toAnyObject() as! [NSObject : AnyObject])
            todos[indexPath.row] = todo
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
        }
        else if (cell.cBox.isChecked == true && todos[indexPath.row].timeChecked == 50) {
            cell.cBox.isChecked = false
            todos[indexPath.row].timeChecked = 0
            todos[indexPath.row].checkedUser = ""
            cell.userLabel.text = todos[indexPath.row].user
            todos[indexPath.row].ref!.updateChildValues(todo.toAnyObject() as! [NSObject : AnyObject])
            todos[indexPath.row] = todo
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
        }
        
        
        // Configure the cell...
        
        return cell
    }
    
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? AddToDo, todo = sourceViewController.todo {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                todos[selectedIndexPath.row].ref!.updateChildValues(todo.toAnyObject() as! [NSObject : AnyObject])
                todos[selectedIndexPath.row] = todo
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            }else{
                let newIndexPath = NSIndexPath(forRow: todos.count, inSection: 0)
                
                todos.append(todo)
                
                let todoItemRef = ref.childByAutoId()
                todoItemRef.setValue(todo.toAnyObject())
                
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
        }
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            let todoItem = todos[indexPath.row]
            todoItem.ref?.removeValue()
            print(todoItem.ref)
            
            //todos.removeAtIndex(indexPath.row)
            //tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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
    
    func loadToDos() {
        
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "editItem" {
            let todoDetailViewController = segue.destinationViewController as! AddToDo
            if let selectedToDoCell = sender as? ToDoTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedToDoCell)!
                let selectedToDo = todos[indexPath.row]
                todoDetailViewController.todo = selectedToDo
            }
        }
        else if segue.identifier == "addItem" {
            print("Adding new meal.")
        }
        else if segue.identifier == "showCompleted" {
            print("show completed")
            /*print(todosArchive.count)
            for var i = 0; i < todosArchive.count; i++ {
            todosArchive[i].timeChecked = 50
            
            let tref = todosArchive[i].ref!
            let newTime = ["timeChecked": 50]
            tref.updateChildValues(newTime)
            
            todos.append(todosArchive[i])*/
            
            
            //let newIndexPath = NSIndexPath(forRow: todos.count, inSection: 0)
            //let cellIdentifier = "ToDoTableViewCell"
            //let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: newIndexPath) as! ToDoTableViewCell
            
            //cell.cBox.isChecked = true
            
            //self.tableView.reloadData()
            //}
        }
        
    }
    
    
}
