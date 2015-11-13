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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        // Set id and name using NSUser information
        senderId = "0"
        senderDisplayName = "Temp"
        
        // Move landing to login if some var is nil
        if (defaults.stringForKey(AppDelegate.constants.userNameKeyConstant) == nil) {
            let storyboard = UIStoryboard(name: "LogInMain", bundle: nil);
            let controller = storyboard.instantiateViewControllerWithIdentifier("LogInViewController") as! LogInViewController
            self.presentViewController(controller, animated: false, completion: nil)
        }
        else {
            // reset sender id and name
        }
        
        automaticallyScrollsToMostRecentMessage = true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        collectionView!.collectionViewLayout.springinessEnabled = true
        
        if messages.isEmpty {
            // set temp data here
            let msg1 = Message(text: "CS 307", senderName: "Thing 1", senderID: "1")
            let msg2 = Message(text: "E = mc^2", senderName: "Thing 2", senderID: "2")
            messages.append(msg1)
            messages.append(msg2)
        }
        
        self.collectionView?.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func sendMessage(text: String!, sender: String!, senderName: String!) {
        // Add to FIREBASE
        tempSendMessage(text, senderID: sender, senderName: senderName)
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
            cell.backgroundColor = UIColor.jsq_messageBubbleLightGrayColor()
        } else {
            cell.textView!.textColor = UIColor.whiteColor()
            cell.backgroundColor = UIColor.jsq_messageBubbleBlueColor()
        }
        
        //let attributes : [NSObject:AnyObject] = [NSForegroundColorAttributeName:cell.textView!.textColor!, NSUnderlineStyleAttributeName: 1]
        //cell.textView!.linkTextAttributes = attributes.description
        
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