//
//  AppDelegate.swift
//  Homekeeper
//
//  Created by William Huang on 9/11/15.
//  Copyright (c) 2015 Team9. All rights reserved.
//  

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit
//import SlideMenuControllerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    struct constants {
        static let userNameKeyConstant = "userNameKey"
        static let userIdConstant = "userIdKey"
        static let homeNameKeyConstant = "homeNameKey"
        static let firstNameKeyConstant = "firstNameKey"
        static let lastNameKeyConstant = "lastNameKey"
        static let groceryListKeyConstant = "groceryListKey"
        static let toDoListKeyConstant = "toDoListKey"
    }
    
    override init() {
        super.init()
        Firebase.defaultConfig().persistenceEnabled = true;
    }
    
    private func createMenuView() {
        let storyboard = UIStoryboard(name: "Popover", bundle: nil);
        
        let mainViewController = storyboard.instantiateViewControllerWithIdentifier("ChatViewController") as! ChatViewController;
        let leftViewController = storyboard.instantiateViewControllerWithIdentifier("LeftViewController") as! LeftViewController;

        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController);
        
        leftViewController.chatViewController = nvc;
        
        let slideMenuController = SlideMenuController(mainViewController: nvc, leftMenuViewController: leftViewController);
        
        self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0);
        self.window?.rootViewController = slideMenuController;
        self.window?.makeKeyAndVisible();
    }


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.createMenuView();
        
        // Override point for customization after application launch.
        return FBSDKApplicationDelegate.sharedInstance()
            .application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, openURL url: NSURL,
        sourceApplication: String?, annotation: AnyObject?) -> Bool {
            return FBSDKApplicationDelegate.sharedInstance()
                .application(application, openURL: url,
                    sourceApplication: sourceApplication, annotation: annotation)
    }


}

