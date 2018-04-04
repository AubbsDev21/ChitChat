//
//  imageExtentions.swift
//  Chitchat
//
//  Created by Aubre Body on 2/4/18.
//  Copyright © 2018 Aubre Body. All rights reserved.
//

import UIKit

let cacheBank = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func loadImagewithURLString(URLString: String) {
        
        
        //fetching preexting images if any
        if let cacheImages = cacheBank.object(forKey: URLString as AnyObject) as? UIImage {
            self.image = cacheImages
            return
        }
        
        let url = NSURL(string: URLString)
        let request = URLRequest(url: url! as URL)
        URLSession.shared.dataTask(with: request, completionHandler: { (data, respone, error) in
            
            if error != nil {
                print(error)
                return
            }
            DispatchQueue.main.async {
                //dowloads everyimage from firebase and puts it into a cache bank
                if let downloadedImage = UIImage(data: data!) {
                    cacheBank.setObject(downloadedImage, forKey: URLString as AnyObject)
                    self.image = downloadedImage
                }
                
                //  cell.imageView?.image = UIImage(data: data!)
            }
        }).resume()
    }
}
