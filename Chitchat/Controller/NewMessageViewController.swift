//
//  NewMessageViewController.swift
//  Chitchat
//
//  Created by Aubre Body on 2/4/18.
//  Copyright © 2018 Aubre Body. All rights reserved.
//

import UIKit
import Firebase
import Parse
class NewMessageViewController: UITableViewController {
    var ref: DatabaseReference!
    
    let cellId = "cellId"
    var users = [Users]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NavBarHandle()
        fetchUser()
        //this is registering the cell class so we can be able to use it
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
    }
    
    
    
    
    
    
    //////////////////Functions//////////////////////////////
    
    func NavBarHandle() {
        //nav bar color
        navigationController?.navigationBar.barTintColor = UIColor(red: 171/255, green: 209/255, blue: 181/255, alpha: 1)
        //nav bar title and title assets
        navigationItem.title = "Users"
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes;
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(CancelButtonHandler))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
        //new measage button
        // let image = UIImage(named: "settings")
        // navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(settingsHandler) )
        //  navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
        //code for a default image view
        //something.imageView?.image = UIImage(named:"")
    }
    
    
   
    
    func fetchUser(){
        let qeury = PFQuery(className: "Users")
        qeury.addAscendingOrder("username")
        qeury.findObjectsInBackground { (objects, error) -> Void in
            if error == nil {
                if let objects = objects {
                    for object in objects {
                        let user = Users()
                        let id = object["uid"] as? String
                        let name = object["username"] as? String
                        let profileimageURL = object["ProfilePicurl"] as? String
                        let profilePic = object["ProfilePic"] as? PFFile
                        user.id = id
                        user.name = name
                        user.profileImageURL = profileimageURL
                        user.ProfilePicFile = profilePic
                        self.users.append(user)
                    }
                    DispatchQueue.main.async {self.tableView.reloadData()}
                }
            }
        }
     
    } 
    
    
    
    func showChatlog(){
        let layout = UICollectionViewFlowLayout()
        
        let viewController = ChatlogController(collectionViewLayout: layout)
        let newController = UINavigationController(rootViewController: viewController)
        
        present(newController, animated: true, completion: nil)
        
    }
    
    
    @objc func CancelButtonHandler() {
        dismiss(animated: true, completion: nil)
    }
    
    
    //////////////Tableview functions //////////////////////////////////
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserCell
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        
        //imageview and assets
        // cell.imageView?.image = UIImage(named: "Defualt_user")
        // cell.imageView?.contentMode = .scaleAspectFill
        
        print(user.profileImageURL)
        //loading the profile image url
        if let profileImageurl = user.profileImageURL {
            //this is coming from the IUImageview exstion file
            cell.profileImageView.loadImagewithURLString(URLString: profileImageurl)
            
        } else if let userFile =  user.ProfilePicFile {
            userFile.getDataInBackground(block: { (Data, error) -> Void in
                if error == nil {
                    if let filedata = Data {
                        let image = UIImage(data: filedata)
                        cell.profileImageView.image = image
                        
                    }
                }
            })
        }
        
        return cell
    }
    //the height of each cell
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77
    }
    
    var MessageController1: ViewController?
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true) {
            //this grabs the user in the index cell path
            let Theuser = self.users[indexPath.row]
            self.MessageController1?.showChatlogforUser(user: Theuser)
            
            
        }
    }
    
    
    
    
    
}
