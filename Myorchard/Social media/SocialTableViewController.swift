//
//  SocialTableViewController.swift
//  Myorchard
//
//  Created by PewPew on 7/5/2563 BE.
//  Copyright © 2563 PewPew. All rights reserved.
//

import UIKit

class SocialTableViewController: UITableViewController {
    
    var blogs = [Blog]()
    
    let firestore = FirestoreService.shared
    
    let imageCache = ImageCache()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        firestore.configure()
        
        tableView.rowHeight = (tableView.bounds.width * 8) / 15
        firestore.listen{ [weak self] (blogs) in
            self?.blogs = blogs
            self?.tableView.reloadData()
        }

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blogs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BlogCell", for: indexPath)
        
        let blogcells = cell as? BlogTypeCell
        //BlogTypeCell?.imageCache = imageCache
        let blogs2 = blogs[indexPath.row]
        blogcells?.populate(with: blogs2)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let newBlogVC = segue.destination as? NewBlogViewController {
            newBlogVC.firestore = firestore
            
        } else if let BlogDetailsVC = segue.destination as? BlogDetailsViewController, let blog = sender as? Blog {
            BlogDetailsVC.blog = blog
           // BlogDetailsVC.imageCache = imageCache
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let blog =  blogs[indexPath.row]
        performSegue(withIdentifier: "segue", sender: blog)
    }

}
