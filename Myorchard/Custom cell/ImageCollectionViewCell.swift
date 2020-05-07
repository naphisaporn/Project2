//
//  ImageCollectionViewCell.swift
//  Myorchard
//
//  Created by PewPew on 2/2/2563 BE.
//  Copyright © 2563 PewPew. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func setupImageWith(itemImage: UIImage) {
        
        imageView.image = itemImage
    }
}
