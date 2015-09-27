//
//  ViewController.swift
//  Homekeeper
//
//  Created by William Huang on 9/11/15.
//  Copyright (c) 2015 Team9. All rights reserved.
//  JACOB MCKESSON

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        makeButton();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func makeButton() {
        let button = UIButton.buttonWithType(UIButtonType.System) as! UIButton;
        button.frame = CGRectMake(150,400,50,50);
        button.backgroundColor = UIColor.blueColor();
        button.setTitle("Button", forState: .Normal);
        button.addTarget(self, action: "printMessage:", forControlEvents: UIControlEvents.TouchUpInside);
        
        self.view.addSubview(button);
    }
    
    func printMessage(sender:UIButton!) {
        var label = UILabel(frame: CGRectMake(0, 0, 200, 21));
        label.center = CGPointMake(160, 284);
        label.textAlignment = NSTextAlignment.Center;
        label.text = "#willsux";
        
        self.view.addSubview(label);
    }
}

