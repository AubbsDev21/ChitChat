//
//  ChatMessagecell.swift
//  Chitchat
//
//  Created by Aubre Body on 3/13/18.
//  Copyright © 2018 Aubre Body. All rights reserved.
//

import UIKit
import Firebase

class ChatMessagecell: UICollectionViewCell {
    
    let textview: UITextView = {
        let text = UITextView()
        text.text = "This is a text"
        text.font = UIFont.systemFont(ofSize: 16)
        text.translatesAutoresizingMaskIntoConstraints = false
        
        return text
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(textview)
       // cellSetup()
        textview.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        textview.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        textview.widthAnchor.constraint(equalToConstant: 100).isActive = true
        textview.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func cellSetup() {
        textview.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        textview.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        textview.widthAnchor.constraint(equalToConstant: 200).isActive = true
        textview.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
}
