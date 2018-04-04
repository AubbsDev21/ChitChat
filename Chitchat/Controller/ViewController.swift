//
//  ViewController.swift
//  Chitchat
//
//  Created by Aubre Body on 2/4/18.
//  Copyright © 2018 Aubre Body. All rights reserved.
//
////////  NOTE: FromID: Is the
import UIKit
import Firebase
import Parse
class ViewController: UITableViewController {
   
    

    var rootRef : DatabaseReference!
    var users = [Users]()
    var messages = [Messages]()
    var messageDictionary = [String: Messages]()
    //cell idenfier
    let cellId = "cellId"
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //check the chace to see if there is a current user
        
        rootRef = Database.database().reference()
        //the logout button assets
        
        
        
    }
    
    
    
    override func viewDidLoad() {
       super.viewDidLoad()
        
        CheckedifUserLoggedin()
       //loadsenderData()
       
        NavBarHandler()
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
       // observeSenderMassege()
    }
    
   
    ///////////////////Tableview Function /////////////////////////////////////
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserCell
        let mess = messages[indexPath.row]
        cell.message = mess
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let message = self.messages[indexPath.row]
        guard let chatPartnerId = message.chatPartnerId() else {
            return
        }
        let ref = Database.database().reference().child("users").child(chatPartnerId)
        ref.observeSingleEvent(of: .value, with: { (DataSnapshot) in
            print(DataSnapshot)
            guard let dictionary = DataSnapshot.value as? [String: AnyObject]
                else {
                    return
            }
            let user = Users()
            let name = dictionary["username"] as? String ?? " Username not Found"
            let email = dictionary["Email"] as? String ?? "Email not Found"
            let profileImageURL = dictionary["profileImageURL"] as? String ?? "URL not Found"
            user.name = name
            user.email = email
            user.profileImageURL = profileImageURL
           // self.users.append(user)
           self.showChatlogforUser(user: user)

        }, withCancel: nil)
    }
    
    //////////////Functions//////////////////////////////////////////////////
    
    
    //When the button is clicked it brings us to login screen
    @objc func handleLogout() {
        let loginController = SignupViewController()
        //signing the current user out of fire base
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            
        } catch let signOutError as NSError {
            print ("Error singing out: %@", signOutError)
        }
        /////end///////
        present(loginController, animated: true, completion: nil)
        
    }
    
    @objc func handleNewMessage() {
        let newMessageController = NewMessageViewController()
        newMessageController.MessageController1 = self
        let newController = UINavigationController(rootViewController: newMessageController)
        present(newController, animated: true, completion: nil)
        
    }
    
    
    func CheckedifUserLoggedin() {
        if Auth.auth().currentUser == nil {
            present(SignupViewController(), animated: true, completion: nil)
            
        }
        else {
            
            let userID = Auth.auth().currentUser?.uid
            
            let query = PFQuery(className: "Users")
            query.whereKey("uid", equalTo: userID)
            query.findObjectsInBackground(block: { (object, error) -> Void in
                if error != nil {
                    print(error?.localizedDescription)
                }
                if let value = object {
                    for object in value {
                        let name = object["username"] as? String
                        let profileImageURL = object["ProfilePicurl"] as? String
                        let userImageFile = object["ProfilePic"] as? PFFile
                        self.setupNavbarpic(user: name!, url: profileImageURL, pic: userImageFile!)
                    }
                }
            })
            
                
            }
        }
    
    
    func setupNavbarpic(user: String, url: String?, pic: PFFile) {
        // self.navigationItem.title = user
        
        //implameting a titleview container
        let titleVeiw = UIView()
        titleVeiw.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        titleVeiw.backgroundColor = UIColor.red
        //nameview
        let nameVeiw = UILabel()
        nameVeiw.translatesAutoresizingMaskIntoConstraints = false
        nameVeiw.text = user
        nameVeiw.textColor = UIColor.white
        
        //Profile view
        
        let profileviewImage = UIImageView()
        profileviewImage.translatesAutoresizingMaskIntoConstraints = false
        profileviewImage.contentMode = .scaleAspectFill
        profileviewImage.layer.cornerRadius = 23
        profileviewImage.clipsToBounds = true
        
        
        if let profileUrl = url {
            profileviewImage.loadImagewithURLString(URLString: profileUrl)
        }else {
            pic.getDataInBackground(block: { (data, error) -> Void in
                if error == nil {
                    if let imageData = data {
                        let images = UIImage(data: imageData)
                        profileviewImage.image = images
                    }
                }
            })
         
        }
       
        
        
        titleVeiw.addSubview(nameVeiw)
        titleVeiw.addSubview(profileviewImage)
        
        
        //contarist
        profileviewImage.centerXAnchor.constraint(equalTo: titleVeiw.leftAnchor).isActive = true
        profileviewImage.centerYAnchor.constraint(equalTo: titleVeiw.centerYAnchor).isActive = true
        profileviewImage.widthAnchor.constraint(equalToConstant: 46).isActive = true
        profileviewImage.heightAnchor.constraint(equalToConstant: 46).isActive = true
        
        nameVeiw.leftAnchor.constraint(equalTo: profileviewImage.rightAnchor, constant: 4).isActive = true
        nameVeiw.centerYAnchor.constraint(equalTo: titleVeiw.centerYAnchor).isActive = true
        nameVeiw.rightAnchor.constraint(equalTo: titleVeiw.rightAnchor).isActive = true
        nameVeiw.heightAnchor.constraint(equalTo: profileviewImage.heightAnchor).isActive = true
        
        self.navigationItem.titleView = titleVeiw
    }
    
    
    
    func NavBarHandler(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
        //nav bar color
        UINavigationBar.appearance().tintColor = UIColor.clear
        navigationController?.navigationBar.barTintColor = UIColor(red: 171/255, green: 209/255, blue: 181/255, alpha: 0.4)
        
        //new measage button
        let image = UIImage(named: "Users_icon")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleNewMessage) )
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
        // nav bar text color
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes;
        
        
    }
    
    func showChatlogforUser(user: Users){
        let layout = UICollectionViewFlowLayout()
        
        let ChatviewController = ChatlogController(collectionViewLayout: layout)
        let newController = UINavigationController(rootViewController: ChatviewController)
        //passes the user data to the chatlogcontroller
        ChatviewController.user = user
        present(newController, animated: true, completion: nil)
        
    }
    ///////////////Still working on it ///////////////////////////////////
    // error in this function
  /* func observeSenderMassege() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        let ref = Database.database().reference().child("user-Message").child(uid)
        
        ref.observe(.childAdded, with: { (DataSnapshot) in
         let messageId = DataSnapshot.key
         let messageref = Database.database().reference().child("Messages").child(messageId)
            messageref.observeSingleEvent(of: .value, with: { (DataSnapshot) in
                if let dic = DataSnapshot.value as? [String: AnyObject] {
                    let message = Messages()
                    message.setValuesForKeys(dic)
                    // self.message.append(message)
                    if let senderId = message.senderID {
                        self.messageDictionary[senderId] = message
                        
                        self.messages = Array(self.messageDictionary.values)
                        //sorting users inasdending order/////////////////////////////Still working on it
                        self.messages.sort(by: { (Message1, Message2) -> Bool in
                            return Message1.timestamp? > Message2.timestamp?
                            
                        })
                    }
                     DispatchQueue.main.async {self.tableView.reloadData()}
                    
                }
            }, withCancel: nil)
            }, withCancel: nil)
    
    
    
    
    }*/
    
    
        


    

    
  /*  func loadsenderData() {
        rootRef = Database.database().reference()
        let CurrentUID = Auth.auth().currentUser?.uid
        //using a firebase query to retrve all meassges only taking in the ones with matching IDs
        let query =  rootRef.child("Messages").queryOrdered(byChild: "senderID").queryEqual(toValue: CurrentUID)
        
        query.observe(.value, with: { (DataSnapshot) in
            for child in DataSnapshot.children.allObjects as! [DataSnapshot]{
                if let value = child.value as? NSDictionary{
                    let messages = Messages()
                    let FromID = value["FromID"] as? String ?? " "
                    let themessage = value["message"] as? String ?? ""
                    let timestamp = value["timestamp"] as? NSNumber
                    let senderID = value["senderID"] as? String ?? ""
                    
                    //appending values to the NSObject
                    messages.FromID = FromID
                    messages.message = themessage
                    messages.timestamp = timestamp
                    messages.senderID = senderID
                    
                    
                    self.messages.append(messages)
                    // getting the current messages for each users
                /*    if let fromID = messages.FromID {
                        self.messageDictionary[fromID] = messages
                        
                        self.message = Array(self.messageDictionary.values)
                        //sorting users inasdending order/////////////////////////////Still working on it
                        self.message.sort(by: { (Message1, Message2) -> Bool in
                        
                            return (Message1.timestamp?.intValue)! > (Message2.timestamp?.intValue)!
                         })
                    }*/
                    
                    DispatchQueue.main.async {self.tableView.reloadData()}
                    
                }
            }
        })
        { (err) in
            print(err)
        }
    
    }*/
    
    
    
    //Status bar
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    //-------------

}

