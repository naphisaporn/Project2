//
//  HelperFunctions.swift
//  Myorchard
//
//  Created by PewPew on 2/2/2563 BE.
//  Copyright © 2563 PewPew. All rights reserved.
//

import Foundation

func convertToCurrency(_ number: Double) -> String {
    
    let currencyFormatter = NumberFormatter()
    currencyFormatter.usesGroupingSeparator = true
    currencyFormatter.numberStyle = .currency
    let 🇺🇸 = Locale(identifier: "th_TH")
    currencyFormatter.locale = 🇺🇸
    currencyFormatter.string(for: "1,234.56") // $1,234.57
    //currencyFormatter.locale = [[NSLocale, alloc], initWithLocaleIdentifier,:@"th_TH"]
    //currencyFormatter.currencyCode = "EUR";
    
    
    return currencyFormatter.string(from: NSNumber(value: number))!
}

