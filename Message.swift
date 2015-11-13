//
//  Message.swift
//  Homekeeper
//
//  Created by Grayson Ricketts on 11/11/15.
//  Copyright © 2015 Team9. All rights reserved.
//

import Foundation
import JSQMessagesViewController

class Message : NSObject, JSQMessageData {
    var text_: String
    var senderName: String
    var senderID: String
    var date_: NSDate
    var imageUrl_: String?
    
    convenience init(text: String?, senderName: String?, senderID: String?) {
        self.init(text: text, senderName: senderName, senderID: senderID, imageUrl: nil)
    }
    
    init(text: String?, senderName: String?, senderID: String?, imageUrl: String?) {
        self.text_ = text!
        self.senderName = senderName!
        self.senderID = senderID!
        self.date_ = NSDate()
        self.imageUrl_ = imageUrl
    }
    
    func text() -> String! {
        return text_
    }
    
    func senderDisplayName() -> String! {
        return senderName
    }
    func senderId() -> String! {
        return senderID
    }
    
    func date() -> NSDate! {
        return date_;
    }
    
    func isMediaMessage() -> Bool {
        return false
    }
    
    func messageHash() -> UInt {
        return UInt(hash)
    }
    
    func imageUrl() -> String? {
        return imageUrl_;
    }
}