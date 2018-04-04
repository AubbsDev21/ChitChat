//
//  Usercell.swift
//  Chitchat
//
//  Created by Aubre Body on 2/4/18.
//  Copyright © 2018 Aubre Body. All rights reserved.
//

import UIKit
import Firebase
////////////////Cell Class/////////////////////////////////////////////
//this class is to deqeue the cell for memory efficieny
class UserCell: UITableViewCell {
    var rootref: DatabaseReference!
    var message: Messages? {
        didSet {
            //getting the username of the recpenit
            if let toid = message?.FromID {
                let ref = Database.database().reference().child("users").child(toid)
                ref.observeSingleEvent(of: .value, with: { (DataSnapshot) in
                    if let dic = DataSnapshot.value as? [String: AnyObject]
                    {
                        self.textLabel?.text = dic["username"] as? String ?? "Error in getting username"
                        let pic = dic["profileImageURL"] as? String ?? "Error in finding image"
                        self.profileImageView.loadImagewithURLString(URLString: pic)
                        
                    }
                }, withCancel: nil)
            }
            
            detailTextLabel?.text = message?.message
            
         /*   if let secends = message?.timestamp?.doubleValue {
                let timestampDate = NSDate(timeIntervalSince1970: secends)
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "hh:mm a"
                timeStamp.text = dateFormatter.string(from: timestampDate as Date)
            }*/
            
            
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel?.frame = CGRect(x: 80, y: textLabel!.frame.origin.y, width: textLabel!.frame.width, height: textLabel!.frame.height)
        detailTextLabel?.frame = CGRect(x: 80, y: detailTextLabel!.frame.origin.y, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)
        detailTextLabel?.textColor = UIColor.lightGray
        
    }
    
    //this is creating our own imageview instaed of a default one
    var profileImageView: UIImageView = {
        let view = UIImageView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30
        view.layer.masksToBounds = true
        return view
    }()
    var timeStamp: UILabel = {
        let time = UILabel()
        time.translatesAutoresizingMaskIntoConstraints = false
        //time.text = "1h:hh:ss"
        time.font = UIFont.systemFont(ofSize: 14)
        time.textColor = UIColor.lightGray
        return time
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        addSubview(profileImageView)
        addSubview(timeStamp)
        profilecontants()
    }
    
    func profilecontants() {
        //ios 9 constaints
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 9).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        timeStamp.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 20).isActive = true
        timeStamp.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        timeStamp.widthAnchor.constraint(equalToConstant: 100).isActive = true
        timeStamp.heightAnchor.constraint(equalTo: (textLabel?.heightAnchor)!).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
