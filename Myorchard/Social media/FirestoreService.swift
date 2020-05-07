//
//  FirestoreService.swift
//  Myorchard
//
//  Created by PewPew on 7/5/2563 BE.
//  Copyright © 2563 PewPew. All rights reserved.
//

import Foundation
import FirebaseFirestore

class FirestoreService {
    
    private init() {
        
    }
    static let shared = FirestoreService()
    
    private var database: Firestore!
    private lazy var blogReference = database.collection("blog")
    
    func configure(){
        database = Firestore.firestore()
        
    }
    
    func save(_ blog: Blog, completion: @escaping (Result<Bool, NSError>) -> Void) {
        
        var otherImagePathsDict = [String: String]()
        blog.otherImagePaths.forEach { otherImagePathsDict[UUID().uuidString] = $0 }
        
        
        blogReference.addDocument(data: ["mainImagePath" : blog.mainImagePath, "title": blog.title, "otherImagePatchs": otherImagePathsDict]) {
            (error) in
            if let unwrappedError = error {
                completion(.failure(unwrappedError as NSError))
            } else {
                completion(.success(true))
            }
        }
    }
    
    func listen(completion: @escaping ([Blog]) -> Void) {
        blogReference.addSnapshotListener { (snapshot, error) in
            
            guard let unwrappedSnapshot = snapshot else { return }
            
            let documents = unwrappedSnapshot.documents
            
            var blogs = [Blog]()
            for document in documents {
                let documentData = document.data()
                
                guard
                let mainImagePath = documentData["mainImagePath"] as? String,
                let title = documentData["title"] as? String,
                let otherImagePathsDict = documentData["otherImagePaths"] as? [String: String]
                    else { continue }
                
                let otherImagePaths = otherImagePathsDict.map { $0.value}
                let blog = Blog(mainImagePath: mainImagePath, title: title, otherImagePaths: otherImagePaths)
                
                blogs.append(blog)
            }
            completion(blogs)
        }
    }
}
