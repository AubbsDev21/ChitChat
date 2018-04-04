//
//  UISwipeGestureExtion.swift
//  Chitchat
//
//  Created by Aubre Body on 2/20/18.
//  Copyright © 2018 Aubre Body. All rights reserved.
//

import UIKit

extension UIViewController {
    @objc func swipeAction(swipe:UISwipeGestureRecognizer) {
        
        switch swipe.direction.rawValue {
        case 1:
            present(SignupViewController(), animated: true, completion: nil)
        case 2:
            present(SigninController(), animated: true, completion: nil)
        default:
            break
        }
    }
    
}
