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
    case Main = 0
    case Debt
    //case ToDo
    case Opt
}

protocol LeftMenuProtocol : class {
    func changeViewController(menu: LeftMenu)
}

class LeftViewController: UIViewController, LeftMenuProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    var menus = ["Main", "Debt", "Options"]
    var mainViewController = UIViewController()
    var debtViewController = UIViewController()
    //var todoViewController = UIViewController()
    var optionsViewController = UIViewController()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorColor = UIColor(white: 0.0, alpha: 0.0)
        self.tableView.backgroundColor = UIColor(white: 0.25, alpha: 1.0)
        self.view.backgroundColor = UIColor(white: 0.25, alpha: 1.0)
        
        let storyboard = UIStoryboard(name: "Menu", bundle: nil);
        
        let debtViewController = storyboard.instantiateViewControllerWithIdentifier("DebtViewController") as! DebtViewController;
        self.debtViewController = UINavigationController(rootViewController: debtViewController);
        
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
        //let optionsButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit, target: nil, action: nil)
        //let toolbarButtons = [optionsButton];
        
        let toolbar = UIToolbar(frame: CGRectMake(0, view.frame.height - 44, 270, 44));
        toolbar.backgroundColor = UIColor.redColor();
        //toolbar.setItems(toolbarButtons, animated: true);
        view.addSubview(toolbar);
        
    }
    
    func changeViewController(menu: LeftMenu) {
        switch menu {
        case .Main:
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true);
        case .Debt:
            self.slideMenuController()?.changeMainViewController(self.debtViewController, close: true);
            break;
        //case .ToDo:
            //self.slideMenuController()?.changeMainViewController(self.todoViewController, close: true);
            //break;
        case .Opt:
            self.slideMenuController()?.changeMainViewController(self.optionsViewController, close: true);
            break;
        default:
            break;
        }
    }
}