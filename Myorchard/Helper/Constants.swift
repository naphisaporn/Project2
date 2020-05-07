//
//  Constants.swift
//  Myorchard
//
//  Created by PewPew on 30/1/2563 BE.
//  Copyright © 2563 PewPew. All rights reserved.
//

import Foundation

enum Constats {
    static let publishableKey = "pk_test_Wcj6mO3uXOxTHwGhvAbOIXmT00KsmgFUtB"
    static let baseURLString = "http://localhost:3000/"
    static let defaultCurrency = "THB"
    static let defaultDescription = "Purchase from Market"
    
}

//IDS and Keys
public let kFILEREFERENCE = "gs://myorchard-50b1a.appspot.com"
public let kALGOLIA_APP_ID = "JH78YY2V1R"
public let kALGOLIA_SEARCH_KEY = "d5cd7f68e2b43ee27c39b267312c4380"
public let kALGOLIA_ADMIN_KEY = "e8680b972a96acd382156952281b80b8"



//Firebase Headers
public let kUSER_PATH = "User"
public let kCATEGORY_PATH = "Category"
public let kITEMS_PATH = "Items"
public let kBASKET_PATH = "Basket"



//Category
public let kNAME = "name"
public let kIMAGENAME = "imageName"
public let kOBJECTID = "objectId"


//Item
public let kCATEGORYID = "categoryId"
public let kDESCRIPTION = "description"
public let kPRICE = "price"
public let kIMAGELINKS = "imageLinks"

//Basket
public let kOWNERID = "ownerId"
public let kITEMIDS = "itemIds"

//User
public let kEMAIL = "email"
public let kFIRSTNAME = "firstName"
public let kLASTNAME = "lastName"
public let kFULLNAME = "fullName"
public let kCURRENTUSER = "currentUser"
public let kFULLADDRESS = "fullAddress"
public let kONBOARD = "onBoard"
public let kPURCHASEDITEMIDS = "purchasedItemIds"
