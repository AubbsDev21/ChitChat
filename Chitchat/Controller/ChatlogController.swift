//
//  ChatlogController.swift
//  Chitchat
//
//  Created by Aubre Body on 2/4/18.
//  Copyright © 2018 Aubre Body. All rights reserved.
//

import UIKit
import Firebase
import Parse
class ChatlogController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    
    var ref: DatabaseReference!
    let cellId = "cellId"
    var messages = [Messages]()
    var user: Users? {
        didSet {
            //sets the navbar to the username we clicked on
            navigationItem.title = user?.name
           observeMessage()
        }
        
    }
    
    func observeMessage() {
        let message = Messages()
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
       /* let userMessageRef = Database.database().reference().child("user-Message").child(uid)
        userMessageRef.observe(.childAdded, with: { (DataSnapshot) in
           // print(DataSnapshot)
            let messageID = DataSnapshot.key
            let messageref = Database.database().reference().child("Messages").child(messageID)
            messageref.observeSingleEvent(of: .value, with: { (DataSnapshot) in
                
                guard let dic = DataSnapshot.value as? [String: AnyObject] else { return
                }
                let message = Messages()
                message.setValuesForKeys(dic)*/
                // if the meeage deos not have matching ids
           let messageQuery = PFQuery(className: "Messages")
           messageQuery.includeKey(uid)
           messageQuery.addDescendingOrder("createdAt")
            messageQuery.findObjectsInBackground { (objects, error) -> Void in
            if error == nil {
                if let objects = objects {
                    for object in objects {
                        let Message = object["Message"] as? String
                        let SenderID = object["SenderID"] as? String
                        let FromID = object["FromID"] as? String
                        let timestamp = object.createdAt as NSDate?
                        message.message = Message
                        message.senderID = SenderID
                        message.FromID = FromID
                        message.timestamp = timestamp
                       
                    }
                    self.messages.append(message)
                    print(self.messages)
                    //if message.chatPartnerId() == self.user?.id {
                        
                        //DispatchQueue.main.async {self.collectionView?.reloadData()}
                        
                   // }
                }
               
            }
                
                
        }
        
        
    }
    
    let Containermessageinput: UIView = {
        let inputContainer = UIView()    //(red: 225/225, green: 255/255, blue: 255/255, alpha: 0.4)
        inputContainer.backgroundColor = UIColor.white
        inputContainer.translatesAutoresizingMaskIntoConstraints = false
        
        return inputContainer
        
    }()
    
    let SendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SEND", for: .normal)
        button.setTitleColor(UIColor.green, for: .normal)
        button.addTarget(self, action: #selector(SendMessage_Handler), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
   
    
    let MessageInput: UITextField = {
        let Input = UITextField()
        Input.placeholder = "Write Message...."
        Input.translatesAutoresizingMaskIntoConstraints = false
        
        return Input
    }()
    
    let SeperatorLineView: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1)
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    var blurView: UIVisualEffectView = {
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
        blur.translatesAutoresizingMaskIntoConstraints = false
        
        return blur
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(ChatMessagecell.self, forCellWithReuseIdentifier: cellId)
        NavBarHandler()
       // blurView.frame = view.bounds
        view.addSubview(blurView)
        view.addSubview(Containermessageinput)
        view.addSubview(SeperatorLineView)
        messageContainer_setup()
        SepLine_setup()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatMessagecell
        //this opens messages dic and access messages
        let message = messages[indexPath.item]
        cell.textview.text = message.message
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
    
    ///////////////////////Constraints////////////////////////////////
    func messageContainer_setup() {
        Containermessageinput.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        Containermessageinput.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        Containermessageinput.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        Containermessageinput.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        Containermessageinput.addSubview(SendButton)
        Containermessageinput.addSubview(MessageInput)
        print(SendButton)
        SendButton.rightAnchor.constraint(equalTo: Containermessageinput.rightAnchor).isActive = true
        SendButton.centerYAnchor.constraint(equalTo: Containermessageinput.centerYAnchor).isActive = true
        SendButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        SendButton.heightAnchor.constraint(equalTo: Containermessageinput.heightAnchor).isActive = true
        
        MessageInput.leftAnchor.constraint(equalTo: Containermessageinput.leftAnchor, constant: 8).isActive = true
        MessageInput.centerYAnchor.constraint(equalTo: Containermessageinput.centerYAnchor).isActive = true
        MessageInput.rightAnchor.constraint(equalTo: SendButton.leftAnchor).isActive = true
        MessageInput.heightAnchor.constraint(equalTo: Containermessageinput.heightAnchor).isActive = true
    }
    
    func SepLine_setup(){
        SeperatorLineView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        SeperatorLineView.bottomAnchor.constraint(equalTo: Containermessageinput.topAnchor).isActive = true
        SeperatorLineView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        SeperatorLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    ///////////////Functions//////////////////////////
    func NavBarHandler(){
        //nav bar color
        navigationController?.navigationBar.barTintColor = UIColor(red: 171/255, green: 209/255, blue: 181/255, alpha: 1)
        //Back button and back button assets
        let image = UIImage(named: "back_icon")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(backbuttonhandler))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        //nav bar title
        
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes;
        
    }
    
    @objc func backbuttonhandler() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func SendMessage_Handler(){
        // let userID = Auth.auth().currentUser?.uid
        let message = MessageInput.text!
        let senderID = user?.id
        let fromID = Auth.auth().currentUser?.uid
        //timestamp
        //let Timestamp = NSDate().timeIntervalSince1970
        
        let messages = PFObject(className: "Messages")
        messages["Message"] = message
        messages["SenderID"] = senderID
        messages["FromID"] = fromID
      //  messages["Timestamp"] = Timestamp
        messages.saveInBackground { (Bool, Error) in
            if Error != nil {
                print(Error?.localizedDescription)
            }
            
        }
        MessageInput.text = ""
    }
    
    
}
