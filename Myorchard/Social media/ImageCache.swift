//
//  ImageCache.swift
//  Myorchard
//
//  Created by PewPew on 7/5/2563 BE.
//  Copyright © 2563 PewPew. All rights reserved.
//

import UIKit

class ImageCache: NSCache<NSString, AnyObject> {
    
    func getImage(named imageName: String, completion: @escaping (UIImage?) -> Void) {
        
        if let image = object(forKey: imageName as NSString) as? UIImage {
            completion(image)
        } else {
        let url = URL(string: imageName)!
              
               do {
                    let data = try Data(contentsOf: url)
                    let image = UIImage(data: data)
                setValue(image, forKey: imageName)
                    completion(image)
               } catch {
                   print(error)
                    completion(nil)
               }
        }
    }
}
