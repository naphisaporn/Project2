//
//  DataManager.swift
//  Myorchard
//
//  Created by PewPew on 18/4/2563 BE.
//  Copyright © 2563 PewPew. All rights reserved.
//

import UIKit

class DataManager: NSObject {
    static var transactions = [transaction]()
    static func addTransaction(t:transaction){
        DataManager.transactions.append(t)
        DataManager.transactions.sort( by: {$0.date.compare($1.date as Date) == ComparisonResult.orderedAscending })
       /* DataManager.transactions.sortInPlace(
            {$0.date.compare($1.date) == ComparisonResult.OrderedAscending }
        )*/
        
        
     
    }
    
    static func getBalance() -> Int {
        var bal:Int = 0
        for t in DataManager.transactions {
            bal += t.amount
        }
        return bal
    }
    
    static func getDebits() -> Int {
           var bal:Int = 0
           for t in DataManager.transactions {
            bal += t.type == transType.debit ? t.amount : 0
           }
           return bal
       }
    
    static func getCredits() -> Int {
           var bal:Int = 0
           for t in DataManager.transactions {
              bal += t.type == transType.credit ? t.amount : 0
           }
           return bal
       }
    
    static func getDates() -> [String] {
        var dates:[String] = []
        for t in DataManager.transactions {
            dates.append(DataManager.formatDate(date: t.date))
        }
        return dates
    }
    
    static func formatDate(date:NSDate) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"
        return dateFormatter.string(from: date as Date)
    }
}

