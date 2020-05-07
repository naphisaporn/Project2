//
//  StorageService.swift
//  Myorchard
//
//  Created by PewPew on 7/5/2563 BE.
//  Copyright © 2563 PewPew. All rights reserved.
//
import UIKit
import Foundation
import FirebaseStorage

class StorageService {
    
    private init() {}
    static let shared = StorageService()
    private let storage = Storage.storage()
    private lazy var imagesReference = storage.reference().child("image")
    
    func upload(_ image: UIImage, completion: @escaping (String) -> Void) {
        let imageRef = imagesReference.child("image/\(UUID().uuidString).jpg")
        
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        
        imageRef.putData(imageData, metadata: nil) { (_, error) in
            
            if let unwrappedError = error {
                print(error)
            } else {
                
                imageRef.downloadURL(completion: { (url, downloadError) in if let unwrappedDownloadError = downloadError {
                    print( unwrappedDownloadError)
                    
                } else if let unwrappedUrl = url{
                    completion(unwrappedUrl.absoluteString)
                    }
                })
            }
        }
    }
    
    func bulkUpload(_ images: [UIImage], completion: @escaping ([String]) -> Void) {
        
        //let semaphore = DispatchSemaphore(value: images.count)
        
        var imagePaths = [String]()
        
        var counter = 0
        
        for image in images {
            upload(image) { (urlPath) in
                imagePaths.append(urlPath)
                counter += 1
                if counter == images.count {
                    completion(imagePaths)
                }
            }
        }
        
        
        
    }
    
}
