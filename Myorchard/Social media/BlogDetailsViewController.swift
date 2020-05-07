//
//  BlogDetailsViewController.swift
//  Myorchard
//
//  Created by PewPew on 7/5/2563 BE.
//  Copyright © 2563 PewPew. All rights reserved.
//

import UIKit

class BlogDetailsViewController: UITableViewController {


    var blog: Blog!
    var blogImagePaths: [String] { return blog.allImagePaths }
    var imageCache: ImageCache!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = tableView.bounds.width
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blogImagePaths.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath)
        
        let imageCell = cell as? ImageCell
        imageCell?.imageCache = imageCache
        let imagePath = blogImagePaths[indexPath.row]
        imageCell?.populate(with: imagePath)
        
        return cell
    }

    
   
}
