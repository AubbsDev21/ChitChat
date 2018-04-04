//
//  SigninController.swift
//  Chitchat
//
//  Created by Aubre Body on 2/4/18.
//  Copyright © 2018 Aubre Body. All rights reserved.
//

import UIKit
import Firebase
import Parse
class SigninController: UIViewController {
    
    var ref: DatabaseReference!
    
    var imageView: UIImageView = {
        let image = UIImageView()
        
        image.image = UIImage(named: "Chatme")
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    //////////////NameField////////////////////
    
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
        button.addTarget(self, action: #selector(loginHandlerButton), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //swipe gesture
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        rightSwipe.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(rightSwipe)
        /////////////////////////
        //gradinet veiw
        view.setGientBackground(colorOne: UIColor(red:171/255, green: 209/255, blue:181/255, alpha: 1), colorTwo: UIColor.white)
        
        view.addSubview(imageView)
        view.addSubview(emailView)
        view.addSubview(passwordView)
        view.addSubview(SigninupButton)
        view_setup()
    }
    
    func view_setup(){
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 96).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        emailView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        emailView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 48).isActive = true
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
        
    }
    
    
    //Status bar
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    //-------------}
    
    
    ///////////////////////Functions ////////////////////////////////////////////
    
    
    
    @objc func loginHandlerButton() {
        guard let email = emailTextField.text, let password = passwordTextField.text
            else {
                print("text not vaild")
                return
        }
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print(error?.localizedDescription)
                self.emailTextField.text = ""
                self.passwordTextField.text = ""
                return
            }
            let layout = UITableViewController()
            let newController = UINavigationController(rootViewController: layout)
            
            self.present(newController, animated: true, completion: nil)
            
        }
        }
        //signing in user
     
    }
    

