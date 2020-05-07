//
//  Category.swift
//  Myorchard
//
//  Created by PewPew on 30/1/2563 BE.
//  Copyright © 2563 PewPew. All rights reserved.
//

import Foundation
import UIKit

class Category {
    
    var id: String
    var name: String
    var image: UIImage?
    var imageName: String?
    
    init(_name: String, _imageName: String) {
        
        id = ""
        name = _name
        imageName = _imageName
        image = UIImage(named: _imageName)
    }
    
    init(_dictionary: NSDictionary) {
        id = _dictionary[kOBJECTID] as! String
        name = _dictionary[kNAME] as! String
        image = UIImage(named: _dictionary[kIMAGENAME] as? String ?? "")
    }
}

//MARK: Download category from firebase

func downloadCategoriesFromFirebase(completion: @escaping (_ categoryArray: [Category]) -> Void) {
    
    var categoryArray: [Category] = []
    
    FirebaseReference(.Category).getDocuments { (snapshot, error) in
        
        guard let snapshot = snapshot else {
            completion(categoryArray)
            return
        }
        
        if !snapshot.isEmpty {
            
            for categoryDict in snapshot.documents {
                categoryArray.append(Category(_dictionary: categoryDict.data() as NSDictionary))
            }
        }
        
        completion(categoryArray)
    }
}


//MARK: Save category function

func saveCategoryToFirebase(_ category: Category) {
    
    let id = UUID().uuidString
    category.id = id
    
    FirebaseReference(.Category).document(id).setData(categoryDictionaryFrom(category) as! [String : Any])
}

//MARK: Helpers

func categoryDictionaryFrom(_ category: Category) -> NSDictionary {
    
    return NSDictionary(objects: [category.id, category.name, category.imageName], forKeys: [kOBJECTID as NSCopying, kNAME as NSCopying, kIMAGENAME as NSCopying])
}


//use only one time
//func createCategorySet() {
//
//    let Fruits = Category(_name: "Fruits", _imageName: "Fruit")
//    let Fruitproducts = Category(_name: "Fruit Products", _imageName: "instantFruits")
//    let seeds = Category(_name: "Seed", _imageName: "seed")
//    let soilandFertilizer = Category(_name: "Soil & Fertilizer" , _imageName: "saf")
//    let Other = Category(_name: "Other", _imageName: "Other")
//
//    let arrayOfCategories = [Fruits, Fruitproducts, seeds, soilandFertilizer, Other]
//
//    for category in arrayOfCategories {
//        saveCategoryToFirebase(category)
//    }
//
//}


