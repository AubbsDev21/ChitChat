//
//  Messages.swift
//  Chitchat
//
//  Created by Aubre Body on 2/4/18.
//  Copyright © 2018 Aubre Body. All rights reserved.
//

import UIKit
import Firebase
class Messages: NSObject {
    @objc var FromID: String?
    @objc var message: String?
    @objc var senderID: String?
    @objc var timestamp: NSDate?
    
    func chatPartnerId() -> String? {
        return FromID == Auth.auth().currentUser?.uid ? senderID : FromID
        
    }
}
