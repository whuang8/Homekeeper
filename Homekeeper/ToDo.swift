//
//  ToDo.swift
//  Homekeeper
//
//  Created by Jacob McKesson on 10/14/15.
//  Copyright © 2015 Team9. All rights reserved.
//

import UIKit
import Firebase
import Foundation

class ToDo {
    
    //Properties
    var message: String
    var user: String
    var task: String
    var ref: Firebase?
    var timeChecked: Int
    var checkedUser: String
    
    //initalize
    init?(message: String, user: String, task: String, timeChecked: Int, checkedUser: String) {
        self.message = message
        self.user = user
        self.task = task
        self.timeChecked = timeChecked
        self.checkedUser = checkedUser
        if (task.isEmpty) {
                return nil
        }
    }

    init (snapshot: FDataSnapshot) {
        message = snapshot.value["message"] as! String
        user = snapshot.value["user"] as! String
        task = snapshot.value["task"] as! String
        timeChecked = snapshot.value["timeChecked"] as! Int
        checkedUser = snapshot.value["checkedUser"] as! String
        ref = snapshot.ref
    }
    
    func toAnyObject() -> AnyObject {
        return [
            "message": message,
            "user": user,
            "task": task,
            "timeChecked": timeChecked,
            "checkedUser": checkedUser
        ]
    }

}
