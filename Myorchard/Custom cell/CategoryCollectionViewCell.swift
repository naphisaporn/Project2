//
//  CategoryCollectionViewCell.swift
//  Myorchard
//
//  Created by PewPew on 23/1/2563 BE.
//  Copyright © 2563 PewPew. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func generateCell(_ category: Category) {
        
        nameLabel.text = category.name
        imageView.image = category.image
    }
}
