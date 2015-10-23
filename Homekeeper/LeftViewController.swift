//
//  LeftViewController.swift
//  Homekeeper
//
//  Created by Tanner Strom on 10/13/15.
//  Copyright © 2015 Team9. All rights reserved.
//

import Foundation
import UIKit

enum LeftMenu: Int {
    case Chat = 0
    case Debt
    case Groc
    case Todo
    case Opt
}

protocol LeftMenuProtocol : class {
    func changeViewController(menu: LeftMenu)
}

class LeftViewController: UIViewController, LeftMenuProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    var menus = ["Chat", "Debt", "Groceries", "Todo", "Options"]
    var chatViewController = UIViewController()
    var debtViewController = UIViewController()
    var grocViewController = UIViewController()
    var todoViewController = UIViewController()
    var optionsViewController = UIViewController()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorColor = UIColor(white: 0.0, alpha: 0.0)
        self.tableView.backgroundColor = UIColor(white: 0.25, alpha: 1.0)
        self.view.backgroundColor = UIColor(white: 0.25, alpha: 1.0)
        
        let storyboard = UIStoryboard(name: "Popover", bundle: nil);
        let storyboard2 = UIStoryboard(name: "GroceryList", bundle: nil);
        let storyboard3 = UIStoryboard(name: "ToDo", bundle: nil);
        
        let debtViewController = storyboard.instantiateViewControllerWithIdentifier("DebtViewController") as! DebtViewController;
        self.debtViewController = UINavigationController(rootViewController: debtViewController);
        
        let grocViewController = storyboard2.instantiateViewControllerWithIdentifier("GroceryTableViewController") as!
        GroceryTableViewController
        self.grocViewController = UINavigationController(rootViewController: grocViewController)
        
        let todoViewController = storyboard3.instantiateViewControllerWithIdentifier("ToDoTableViewController") as! ToDoTableViewController;
        self.todoViewController = UINavigationController(rootViewController: todoViewController);
        
        let optionsViewController = storyboard.instantiateViewControllerWithIdentifier("OptionsViewController") as! OptionsViewController;
        self.optionsViewController = UINavigationController(rootViewController: optionsViewController);
        
        self.tableView.registerCellClass(BaseTableViewCell);
        makeToolbar();
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: BaseTableViewCell = BaseTableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: BaseTableViewCell.identifier)
        cell.backgroundColor = UIColor(white: 0.5, alpha: 0.0)
        cell.textLabel?.font = UIFont.boldSystemFontOfSize(18)
        cell.textLabel?.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        cell.textLabel?.text = menus[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let menu = LeftMenu(rawValue: indexPath.item) {
            self.changeViewController(menu)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func makeToolbar() {
        let toolbar = UIToolbar(frame: CGRectMake(0, view.frame.height - 44, 270, 44));
        toolbar.backgroundColor = UIColor.redColor();
        view.addSubview(toolbar);
        
    }
    
    func changeViewController(menu: LeftMenu) {
        switch menu {
        case .Chat:
            self.slideMenuController()?.changeMainViewController(self.chatViewController, close: true);
        case .Debt:
            self.slideMenuController()?.changeMainViewController(self.debtViewController, close: true);
            break;
        case .Groc:
            self.slideMenuController()?.changeMainViewController(self.grocViewController, close: true);
            break;
        case .Todo:
            self.slideMenuController()?.changeMainViewController(self.todoViewController, close: true);
            break;
        case .Opt:
            self.slideMenuController()?.changeMainViewController(self.optionsViewController, close: true);
            break;
        }
    }
}