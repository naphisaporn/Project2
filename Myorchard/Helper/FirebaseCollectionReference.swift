//
//  FirebaseCollectionReference.swift
//  Myorchard
//
//  Created by PewPew on 30/1/2563 BE.
//  Copyright © 2563 PewPew. All rights reserved.
//

import Foundation
import FirebaseFirestore

enum FCollectionReference: String {
    case User
    case Category
    case Items
    case Basket
}

func FirebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference {
    
    return Firestore.firestore().collection(collectionReference.rawValue)
}
