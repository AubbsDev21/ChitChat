//
//  LoginController+extension.swift
//  Chitchat
//
//  Created by Aubre Body on 2/4/18.
//  Copyright © 2018 Aubre Body. All rights reserved.
//

import UIKit
import Firebase
import Parse
extension SignupViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
   @objc func handleSelcethandleProfileView(sender: UITapGestureRecognizer){
        print("got it")
        //segueways into the phones picker veiw
        let picker = UIImagePickerController()
        //Helps with the UIpicker control
        picker.delegate = self
        //this allows the profile cropping
        //picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var TheselectedImage: UIImage?
        
        if let orignalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            TheselectedImage = orignalImage
        }
            
        else if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            TheselectedImage = editedImage
            
        }
        
        dismiss(animated: true, completion: nil)
        
        //attaching selected image to view
        if let selectedImage = TheselectedImage  {
            userimageView.image = selectedImage
        }
        else {
            userimageView.image = UIImage(named: "IconProfile")
        }
        
        
    }
    
    
    
   @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("its canlled")
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
   @objc func registerHandlerButton() {
        //to check to see if the feilds are vaild or not
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text
            else {
                print("Text not vaild")
                return
        }
     Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
         guard let imageData = UIImageJPEGRepresentation(self.userimageView.image! , 0.1) else {
            return print("error")
        }
        
        let imageFile = PFFile(name:"image.png", data:imageData)
        
        
        let Puser = PFObject(className: "Users")
        Puser["username"] = name
        Puser["email"] = email
        Puser["password"] = password
        Puser["ProfilePic"] = imageFile
        Puser.saveInBackground { (Bool, Error) in
            if Error != nil {
                print(Error?.localizedDescription)
            }
        }
    }
   
                print("User as been created")
                let layout = UITableViewController()
                let newController = UINavigationController(rootViewController: layout)
                
                self.present(newController, animated: true, completion: nil)
                
        
    
    }
    
    
    
    
    
}
