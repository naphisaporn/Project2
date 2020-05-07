//
//  Blog.swift
//  Myorchard
//
//  Created by PewPew on 7/5/2563 BE.
//  Copyright © 2563 PewPew. All rights reserved.
//

import Foundation

struct Blog: Decodable {
    let mainImagePath: String
    let title: String
    let otherImagePaths: [String]
    
    var allImagePaths: [String] { return [mainImagePath] + otherImagePaths }
}
