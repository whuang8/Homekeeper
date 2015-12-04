//
//  ChatViewController.swift
//
//
//  Created by Tanner Strom on 10/14/15.
//
//

import Foundation
import UIKit
import JSQMessagesViewController
import Firebase

class ChatViewController: JSQMessagesViewController {
    var messages = [Message]()
    var ref = Firebase()
    var senderImageUrl: String!
    
    let incoming = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImageWithColor(UIColor.blueColor());
    let outgoing = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImageWithColor(UIColor.whiteColor());
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let defaults = NSUserDefaults.standardUserDefaults()
        
        senderDisplayName = "-1"
        senderId = "-1"
        
        // Move landing to login if some var is nil
        if (defaults.stringForKey(AppDelegate.constants.userNameKeyConstant) == nil) {
            let storyboard = UIStoryboard(name: "LogInMain", bundle: nil);
            
            let controller = storyboard.instantiateViewControllerWithIdentifier("LogInViewController") as! LogInViewController
            let navController = UINavigationController(rootViewController: controller);
            
            navController.title = "Options";
            self.presentViewController(navController, animated: false, completion: nil)
        }
        else {
            // Set id and name using NSUser information
            senderId = defaults.stringForKey(AppDelegate.constants.userIdConstant)
            senderDisplayName = defaults.stringForKey(AppDelegate.constants.userNameKeyConstant)
            
            setupFirebase(defaults.stringForKey(AppDelegate.constants.homeNameKeyConstant)!)
            
            ref.queryLimitedToFirst(50).observeEventType(FEventType.ChildAdded, withBlock: { (snapshot) in
                let text = snapshot.value["text"] as? String
                let senderName = snapshot.value["senderName"] as? String
                let senderId = snapshot.value["senderId"] as? String
                
                let message = Message(text: text, senderName: senderName, senderID: senderId)
                self.messages.append(message)
                self.finishReceivingMessage()
            })
        }
        
        automaticallyScrollsToMostRecentMessage = true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        collectionView!.collectionViewLayout.springinessEnabled = true
        
        self.collectionView?.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) { }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupFirebase(homeName: String) {
        ref = Firebase(url: "https://homekeeper.firebaseio.com/messages/" + homeName)
    }
    
    func sendMessage(text: String!, sender: String!, senderName: String!) {
        print(NSUserDefaults.standardUserDefaults().stringForKey(AppDelegate.constants.homeNameKeyConstant))
        ref.childByAutoId().setValue([
            "text":text,
            "senderId":sender,
            "senderName":senderName
        ])
    }
    
    func tempSendMessage(text: String!, senderID: String!, senderName: String!) {
        let message = Message(text: text, senderName: senderName, senderID: senderID, imageUrl: senderImageUrl)
        messages.append(message)
    }
    
    // ACTIONS
    
    func receivedMessagePressed(sender: UIBarButtonItem) {
        // Simulate reciving message
        showTypingIndicator = !showTypingIndicator
        scrollToBottomAnimated(true)
    }
    
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        JSQSystemSoundPlayer.jsq_playMessageSentSound()
        
        sendMessage(text, sender: senderId, senderName: senderDisplayName)
        
        finishSendingMessage()
    }
    
    override func didPressAccessoryButton(sender: UIButton!) {
        print("Camera pressed!", terminator: "")
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        return nil
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath) as! JSQMessagesCollectionViewCell
        
        let message = messages[indexPath.item]
        if message.senderId() == senderId {
            cell.textView!.textColor = UIColor.blackColor()
            cell.textView!.layer.borderColor = CGColorCreate(CGColorSpaceCreateDeviceRGB(), [0.0, 122.0/255.0, 1.0, 1.0]);
            //cell.backgroundColor = UIColor.jsq_messageBubbleLightGrayColor()
        } else {
            cell.textView!.textColor = UIColor.blackColor()
            cell.textView!.layer.borderColor = CGColorCreate(CGColorSpaceCreateDeviceRGB(), [91.0/255.0, 194.0/255.0, 54.0/255.0, 1.0]);
            //cell.backgroundColor = UIColor.jsq_messageBubbleBlueColor()
        }
        
        //let attributes : [NSObject:AnyObject] = [NSForegroundColorAttributeName:cell.textView!.textColor!, NSUnderlineStyleAttributeName: 1]
        //cell.textView!.linkTextAttributes = attributes.description
        //cell.textView!.layer.borderColor = CGColorCreate(CGColorSpaceCreateDeviceRGB(), [0.0, 0.0, 0.0, 1.0]);
        cell.textView!.layer.borderWidth = 1.5;
        cell.textView!.layer.cornerRadius = 15;
        cell.textView!.layer.masksToBounds = true;
        cell.textView!.layer.backgroundColor = CGColorCreate(CGColorSpaceCreateDeviceRGB(), [1.0, 1.0, 1.0, 1.0]);
        
        return cell
    }
    
    // View  usernames above bubbles
    override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
        let message = messages[indexPath.item];
        
        // Sent by me, skip
        if message.senderId() == senderId {
            return nil;
        }
        
        // Same as previous sender, skip
        if indexPath.item > 0 {
            let previousMessage = messages[indexPath.item - 1];
            if previousMessage.senderId() == message.senderId() {
                return nil;
            }
        }
        
        return NSAttributedString(string:message.senderDisplayName())
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        let message = messages[indexPath.item]
        
        // Sent by me, skip
        if message.senderId() == senderId {
            return CGFloat(0.0);
        }
        
        // Same as previous sender, skip
        if indexPath.item > 0 {
            let previousMessage = messages[indexPath.item - 1];
            if previousMessage.senderId() == message.senderId() {
                return CGFloat(0.0);
            }
        }
        
        return kJSQMessagesCollectionViewCellLabelHeightDefault
    }

    
}