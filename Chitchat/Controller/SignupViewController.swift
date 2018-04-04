//
//  SignupViewController.swift
//  Chitchat
//
//  Created by Aubre Body on 2/4/18.
//  Copyright © 2018 Aubre Body. All rights reserved.
//

import UIKit
import Firebase
import Parse

class SignupViewController: UIViewController, FBSDKLoginButtonDelegate {
   
    /////////////////////////View elements ////////////////////////////
    let FBButton: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.readPermissions = ["email"]
       
        return button
    }()
    
   
    
    
    var ref: DatabaseReference!
    lazy var userimageView: UIImageView = {
        let image = UIImageView()
        
        image.image = UIImage(named: "Chatme")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        image.layer.cornerRadius = 35
        image.layer.masksToBounds = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSelcethandleProfileView(sender:)))
        image.addGestureRecognizer(tapGesture)
        
        return image
        
    }()
    
    
    let nameView: UIView =  {
        let view = UIView()
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 6
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.masksToBounds = true
        return view
    }()
    
    let nameTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Username"
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
   
    let emailView: UIView =  {
        let view = UIView()
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 6
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.masksToBounds = true
        return view
    }()
    
    let emailTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Example@chatme.com"
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    
    let passwordView: UIView =  {
        let view = UIView()
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 6
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.masksToBounds = true
        return view
    }()
    
    let passwordTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Password"
        text.isSecureTextEntry = true
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    
    let SigninupButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.init(red: 171/255, green: 209/255, blue: 181/225, alpha: 1), for: .normal)
        button.setTitle("SIGNUP", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        //signup action buttton
        button.addTarget(self, action: #selector(registerHandlerButton), for: .touchUpInside)
        
        return button
    }()
    
    let orText: UILabel = {
        let text = UILabel()
        text.text = "OR"
        text.textColor = UIColor.white    //(red: 171/225, green: 181/225, blue: 181/225, alpha: 1)
        text.font = UIFont.boldSystemFont(ofSize: 40)
        text.textAlignment = NSTextAlignment.center
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    ///////////////////////end ///////////////////////
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //swipe gesture
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        leftSwipe.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(leftSwipe)
        /////////////////////////
        
        // Do any additional setup after loading the view.
        view.setGientBackground(colorOne: UIColor(red:171/255, green: 209/255, blue:181/255, alpha: 1), colorTwo:
            UIColor.white)     //UIColor(red: 171/255, green: 209/255, blue: 181/255, alpha: 1)
        FBButton.delegate = self
        FBButton.frame = CGRect(x: 30, y: 600, width: view.frame.width - 60, height: 45)
        view.addSubview(FBButton)
        
        view.addSubview(userimageView)
        view.addSubview(nameView)
        view.addSubview(emailView)
        view.addSubview(passwordView)
        view.addSubview(SigninupButton)
        view.addSubview(orText)
        
        signup_setup()
        
    }
    
    /////////////////Facebook delgate///////////////////////////////
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        
        FBAuth()
    }
    
   
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print()
        
    }
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    /////////////////end //////////////////////
    
    ///////////constanits ////////////////////////////////////////////////
    
    func signup_setup() {
        userimageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        userimageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 96).isActive = true
        userimageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        userimageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        nameView.centerXAnchor.constraint(equalTo: userimageView.centerXAnchor).isActive = true
        nameView.topAnchor.constraint(equalTo: userimageView.bottomAnchor, constant: 48).isActive = true
        nameView.widthAnchor.constraint(equalToConstant: 328).isActive = true
        nameView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        nameView.addSubview(nameTextField)
        
        nameTextField.leftAnchor.constraint(equalTo: nameView.leftAnchor, constant: 10).isActive = true
        nameTextField.topAnchor.constraint(equalTo: nameView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: nameView.widthAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: nameView.heightAnchor).isActive = true
        
        emailView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailView.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 17).isActive = true
        emailView.widthAnchor.constraint(equalToConstant: 328).isActive = true
        emailView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        emailView.addSubview(emailTextField)
        
        emailTextField.leftAnchor.constraint(equalTo: emailView.leftAnchor, constant: 10).isActive = true
        emailTextField.topAnchor.constraint(equalTo: emailView.topAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: emailView.widthAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: emailView.heightAnchor).isActive = true
        
        passwordView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordView.topAnchor.constraint(equalTo: emailView.bottomAnchor, constant: 17).isActive = true
        passwordView.widthAnchor.constraint(equalToConstant: 328).isActive = true
        passwordView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        passwordView.addSubview(passwordTextField)
        
        passwordTextField.leftAnchor.constraint(equalTo: passwordView.leftAnchor, constant: 10).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: passwordView.topAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: passwordView.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: passwordView.heightAnchor).isActive = true
        
        SigninupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        SigninupButton.topAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: 16).isActive = true
        SigninupButton.widthAnchor.constraint(equalToConstant: 271).isActive = true
        SigninupButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        orText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        orText.topAnchor.constraint(equalTo: SigninupButton.bottomAnchor, constant: 30).isActive = true
        orText.widthAnchor.constraint(equalToConstant: 100).isActive = true
        orText.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
       /* FBButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        FBButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -45)
        FBButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20)
        FBButton.heightAnchor.constraint(equalToConstant: 40).isActive = true */
        
        
    }
    
    func FBAuth() {
        //getting facebook Auth
        let asscessToken = FBSDKAccessToken.current()
        
        let credential = FacebookAuthProvider.credential(withAccessToken: (asscessToken?.tokenString)!)
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let user = user {
                let uid = user.uid
                let email = user.email
                let photoURL = user.photoURL
                let name = user.displayName
                
               
            
                    //adding to the database
                if let profileImageURL = photoURL?.absoluteString {
                    
                    let FBuser = PFObject(className: "Users")
                    FBuser["username"] = name
                    FBuser["uid"] = uid
                    FBuser["email"] = email
                    FBuser["ProfilePicurl"] = profileImageURL
                    
                    FBuser.saveInBackground(block: { (Bool, Error) in
                        if Error != nil {
                            print(Error?.localizedDescription)
                        }
                    })
                    
                    }
                    
            }
                
        }
            
            
        
        
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start { (connection, result, err) in
            if err != nil {
                print("Failed to start graph request:", err)
                return
            }
            print(result)
        }
        let layout = UITableViewController()
        let newController = UINavigationController(rootViewController: layout)
        
        present(newController, animated: true, completion: nil)
    }
    
    //Status bar
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    //-------------
    
    
}
