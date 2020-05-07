//
//  ImageCell.swift
//  Myorchard
//
//  Created by PewPew on 7/5/2563 BE.
//  Copyright © 2563 PewPew. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {
    
    @IBOutlet weak var blogImageView: UIImageView!
    
    var imageCache: ImageCache?
    func populate(with imagePath: String) {
        imageCache?.getImage(named: imagePath, completion: { [weak self] (image) in
            self?.blogImageView.image = image
        })
    }

}
