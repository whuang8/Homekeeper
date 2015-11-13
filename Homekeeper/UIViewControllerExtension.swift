//
//  UIViewControllerExtension.swift
//  Homekeeper
//
//  Created by Tanner Strom on 10/13/15.
//  Copyright © 2015 Team9. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func setNavigationBarItem() {
        self.addLeftBarButtonWithImage(UIImage(named: "ic_menu_black_24dp")!);
        self.slideMenuController()?.removeLeftGestures();
        self.slideMenuController()?.addLeftGestures();
        self.slideMenuController()?.removeRightGestures();
        self.slideMenuController()?.addRightGestures();
    }
    
    func removeNavigationBarItem() {
        self.navigationItem.leftBarButtonItem = nil
        self.slideMenuController()?.removeLeftGestures()
    }
}
