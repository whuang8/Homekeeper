//
//  LogInViewController.swift
//  Homekeeper
//
//  Created by William Huang on 9/28/15.
//  Copyright © 2015 Team9. All rights reserved.
//

import UIKit
import AVKit
import MediaPlayer
import Firebase


class LogInViewController: UIViewController, UITextFieldDelegate {
    
    var emailText: UITextField!;
    var passwordText: UITextField!;
    
    var loggedIn: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor.blueColor();
        //setVideoLayer();
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
        drawLoginMenu()
        drawLoginCancelButtons()
        drawSignUpButton()
    }
    
    //runs when login button is hit
    func logIn(sender: UIButton) {
        checkTextFields()
        let ref = Firebase(url: "https://homekeeper.firebaseio.com/")
        ref.authUser(emailText.text, password: passwordText.text,
            withCompletionBlock: { error, authData in
                if error != nil {
                    // There was an error logging in to this account
                    print("Error in log in")
                    self.emailText.text = ""
                    self.passwordText.text = ""
                    self.loggedIn = false
                    
                    let title = "Wrong Login Credentials"
                    let message = "Please try again."
                    // Initialize Alert Controller
                    let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
                    
                    // Initialize Actions
                    let okAction = UIAlertAction(title: "Ok", style: .Default) { (action) -> Void in
                        print("Ok")
                    }
                    
                    // Add Actions
                    alertController.addAction(okAction)
                    
                    // Present Alert Controller
                    self.presentViewController(alertController, animated: true, completion: nil)
                    
                } else {
                    self.loggedIn = true
                    //self.performSegueWithIdentifier("SignInSegue", sender: self)
                    
                    let defaults = NSUserDefaults.standardUserDefaults()
                    
                    defaults.setObject(self.emailText.text, forKey: AppDelegate.constants.userNameKeyConstant)
                    defaults.setObject(ref.authData.uid, forKey: AppDelegate.constants.userIdConstant)
            
                    let userRef = Firebase(url: ("https://homekeeper.firebaseio.com/users/" + ref.authData.uid))
                    userRef.observeEventType(.Value, withBlock: { snapshot in
                        defaults.setObject(snapshot.value["households"] as! String, forKey: AppDelegate.constants.homeNameKeyConstant)
                    })
                    
                    print(defaults.valueForKey(AppDelegate.constants.homeNameKeyConstant))
                        
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
        })
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        
        let performSegue = self.loggedIn
        self.loggedIn = false
        return performSegue
    }
    
    //runs when sign up button is hit
    func signUp(sender: UIButton) {
        self.performSegueWithIdentifier("SignUpSegue", sender: self)
    }
    
    func checkTextFields(){
        var title = ""
        var message = ""
        var missing = false
        if(passwordText.text!.isEmpty && emailText.text!.isEmpty){
            title = "Missing login credentials"
            message = "Please enter an email address and password to log in"
            missing = true
        }
        else if(emailText.text!.isEmpty){
            title = "Email Missing"
            message = "Please enter a email address to log in"
            missing = true
        }
        else if(passwordText.text!.isEmpty){
            title = "Password Missing"
            message = "Please enter a password to log in"
            missing = true
        }
        
        if(missing){
            // Initialize Alert Controller
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
            
            // Initialize Actions
            let okAction = UIAlertAction(title: "Ok", style: .Default) { (action) -> Void in
                print("Ok")
            }
            
            // Add Actions
            alertController.addAction(okAction)
            
            // Present Alert Controller
            self.presentViewController(alertController, animated: true, completion: nil)
            
        }
    }
    
    
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Make that video shit do a full repeat
    func playerItemDidReachEnd(notification: NSNotification) {
        let p: AVPlayerItem = notification.object as! AVPlayerItem
        p.seekToTime(kCMTimeZero)
    }
    
    
    
    //Start Tanner's revamp
    
    func cancel(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: {});
    }
    
    func presentSignup(sender: UIButton) {
        let storyboard = UIStoryboard(name: "LogInMain", bundle: nil);
        let controller = storyboard.instantiateViewControllerWithIdentifier("SignUpViewController");
        self.presentViewController(controller, animated: true, completion: nil);
    }
    
    func drawLoginMenu() {
        let wid:CGFloat = 250.0;
        let hei:CGFloat = 300.0;
        
        let base = UIImageView(frame:CGRectMake(self.view.bounds.width / 2 - (wid / 2),
            self.view.bounds.height / 2 - (hei / 2),
            wid,
            hei));
        
        base.backgroundColor = UIColor.grayColor();
        base.layer.cornerRadius = 8.0;
        base.alpha = 0;
        base.clipsToBounds = true;
        
        self.view.addSubview(base);
        
        //Make the text field
        let inpWid:CGFloat = 200.0;
        let inpHei:CGFloat = 30.0;
        
        emailText = UITextField(frame: CGRectMake(self.view.bounds.width / 2 - (inpWid / 2),
            self.view.bounds.height / 1.9,
            inpWid,
            inpHei));
        
        emailText.clipsToBounds = true;
        emailText.textColor = UIColor.blackColor();
        
        //Only an underline
        let underline = CALayer();
        let undWid:CGFloat = 2.0;
        underline.borderColor = UIColor.blackColor().CGColor;
        underline.frame = CGRectMake(0,
            emailText.frame.size.height - undWid,
            emailText.frame.size.width,
            emailText.frame.size.height)
        
        underline.borderWidth = undWid;
        emailText.layer.addSublayer(underline);
        emailText.layer.masksToBounds = true;
        emailText.placeholder = "Username"
        emailText.textAlignment = NSTextAlignment.Center;
        emailText.keyboardType = UIKeyboardType.EmailAddress;
        emailText.alpha = 0.0;
        
        self.view.addSubview(emailText);
        
        //Make the text field
        let pasWid:CGFloat = 200.0;
        let pasHei:CGFloat = 30.0;
        
        passwordText = UITextField(frame: CGRectMake(self.view.bounds.width / 2 - (pasWid / 2),
            self.view.bounds.height / 1.7,
            pasWid,
            pasHei));
        
        passwordText.clipsToBounds = true;
        passwordText.textColor = UIColor.blackColor();
        
        //Only an underline
        let pUnderline = CALayer();
        let pUndWid:CGFloat = 2.0;
        pUnderline.borderColor = UIColor.blackColor().CGColor;
        pUnderline.frame = CGRectMake(0,
            passwordText.frame.size.height - pUndWid,
            passwordText.frame.size.width,
            passwordText.frame.size.height)
        
        pUnderline.borderWidth = pUndWid;
        passwordText.layer.addSublayer(pUnderline);
        passwordText.layer.masksToBounds = true;
        passwordText.placeholder = "Password"
        passwordText.textAlignment = NSTextAlignment.Center;
        passwordText.enabled = false;
        passwordText.secureTextEntry = true;
        passwordText.alpha = 0;
        
        self.view.addSubview(passwordText);
        
        UIView.animateWithDuration(0.5,
            delay: 2,
            options: UIViewAnimationOptions.CurveEaseIn,
            animations: {
                base.alpha = 0.5;
                self.emailText.alpha = 1.0;
                self.passwordText.alpha = 1.0;
            },
            completion: { finished in
                self.emailText.enabled = true;
                self.passwordText.enabled = true;
        })
    }
    
    func drawLoginCancelButtons() {
        let lgnWid:CGFloat = 200.0;
        let lgnHei:CGFloat = 30.0;
        
        let loginButton: UIButton = UIButton(frame: CGRectMake(self.view.bounds.width / 2 - (lgnWid / 2),
            self.view.bounds.height / 1.47 - (lgnHei / 2),
            lgnWid,
            lgnHei));
        loginButton.backgroundColor = UIColor.clearColor();
        loginButton.layer.cornerRadius = 8.0;
        loginButton.setTitle("Login", forState: UIControlState.Normal);
        loginButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
        loginButton.titleLabel?.font = UIFont(name: "GillSans", size: 20);
        loginButton.addTarget(self, action: "logIn:", forControlEvents: UIControlEvents.TouchUpInside);
        loginButton.alpha = 0.0;
        loginButton.enabled = false;
        
        self.view.addSubview(loginButton);
        
        let canWid:CGFloat = 200.0;
        let canHei:CGFloat = 30.0;
        
        let cancelButton:UIButton = UIButton(frame: CGRectMake(self.view.bounds.width / 2 - (canWid / 2),
            self.view.bounds.height / 1.35,
            canWid,
            canHei))
        cancelButton.backgroundColor = UIColor.clearColor();
        cancelButton.layer.cornerRadius = 8.0;
        cancelButton.setTitle("Cancel", forState: UIControlState.Normal);
        cancelButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
        cancelButton.titleLabel?.font = UIFont(name: "GillSans", size: 20);
        cancelButton.addTarget(self, action: "cancel:", forControlEvents: UIControlEvents.TouchUpInside);
        cancelButton.alpha = 0.0;
        cancelButton.enabled = false;
        
        self.view.addSubview(cancelButton);
        
        UIView.animateWithDuration(0.5,
            delay: 0,
            options: UIViewAnimationOptions.CurveEaseIn,
            animations: {
                loginButton.alpha = 0.5;
                cancelButton.alpha = 0.5;
            },
            completion: { finished in
                loginButton.enabled = true;
                cancelButton.enabled = true;
        })
    }
    
    func drawSignUpButton() {
        let supWid: CGFloat = 200.0;
        let supHei: CGFloat = 40.0;
        
        let signUpButton: UIButton = UIButton(frame: CGRectMake(self.view.bounds.width / 2 - (supWid / 2),
            self.view.bounds.height - supHei,
            supWid,
            supHei));
        
        signUpButton.backgroundColor = UIColor.clearColor();
        signUpButton.layer.cornerRadius = 8.0;
        signUpButton.setTitle("Sign Up", forState: UIControlState.Normal);
        signUpButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
        signUpButton.titleLabel?.font = UIFont(name: "GillSans", size: 20);
        signUpButton.addTarget(self, action: "presentSignup:", forControlEvents: UIControlEvents.TouchUpInside);
        signUpButton.alpha = 0.0;
        signUpButton.enabled = false;
        
        self.view.addSubview(signUpButton);
        
        UIView.animateWithDuration(0.5,
            delay: 0,
            options: UIViewAnimationOptions.CurveEaseIn,
            animations: {
                signUpButton.alpha = 0.5;
            },
            completion: { finished in
                signUpButton.enabled = true;
        })
    }
    /*
    func setVideoLayer() {
        let myPlayerView = UIView(frame: self.view.frame);
        let videoURL: NSURL = NSBundle.mainBundle().URLForResource("ChampsElysees_150610_03_Videvo", withExtension: "mov")!;
        let player = AVPlayer(URL: videoURL);
        
        player.play();
        player.muted = true;
        player.actionAtItemEnd = AVPlayerActionAtItemEnd.None;
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "playerItemDidReachEnd:",
            name: AVPlayerItemDidPlayToEndTimeNotification,
            object: player.currentItem)
        
        let avLayer = AVPlayerLayer(player: player);
        avLayer.frame = myPlayerView.bounds;
        avLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        myPlayerView.layer.addSublayer(avLayer);
        
        let blur = UIBlurEffect(style: UIBlurEffectStyle.Dark);
        let blurView = UIVisualEffectView(effect: blur);
        blurView.alpha = 0.75;
        blurView.frame = self.view.bounds;
        self.view.addSubview(blurView);
    }*/
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
