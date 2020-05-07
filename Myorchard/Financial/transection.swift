//
//  transection.swift
//  Myorchard
//
//  Created by PewPew on 18/4/2563 BE.
//  Copyright © 2563 PewPew. All rights reserved.
//

import UIKit

enum transType {
    case debit
    case credit
}

class transaction: NSObject {
    var amount:Int = 0
    var date:NSDate = NSDate()
    var type:transType = transType.credit
    
  init(amount:Int, date:NSDate, type:transType) {
        self.amount = amount
        self.date = date
        self.type = type
    }

}
