//
//  AlgoliaService.swift
//  Myorchard
//
//  Created by PewPew on 7/5/2563 BE.
//  Copyright © 2563 PewPew. All rights reserved.
//

import Foundation
import InstantSearchClient

class AlgoliaService {
    
     static let shared = AlgoliaService()
       
       let client = Client(appID: kALGOLIA_APP_ID, apiKey: kALGOLIA_ADMIN_KEY)
       let index = Client(appID: kALGOLIA_APP_ID, apiKey: kALGOLIA_ADMIN_KEY).index(withName: "item_Name")
       
       private init() {}
}
