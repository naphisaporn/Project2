//
//  BlogCellTableViewCell.swift
//  Myorchard
//
//  Created by PewPew on 7/5/2563 BE.
//  Copyright © 2563 PewPew. All rights reserved.
//

import UIKit

class BlogTypeCell: UITableViewCell {
    
    @IBOutlet weak var BlogImageView: UIImageView!
    @IBOutlet weak var BlogLabel: UILabel!
    
    
    var imageCache: ImageCache?

    func populate(with blog: Blog){
        BlogLabel.text = blog.title
        imageCache?.getImage(named: blog.mainImagePath, completion: { [weak self] (image) in
            self?.BlogImageView.image = image
        })
    }
}
