//
//  TransactionViewController.swift
//  Myorchard
//
//  Created by PewPew on 13/3/2563 BE.
//  Copyright © 2563 PewPew. All rights reserved.
//

import UIKit

class TransactionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
     let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return DataManager.transactions.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath) as! customTableViewCell
    
    let trans = DataManager.transactions[indexPath.row]
    cell.transAmount.text = String(trans.amount)
    cell.transDate.text = DataManager.formatDate(date: trans.date)
    if(trans.type == transType.debit) {
        cell.backgroundColor = UIColor(red: 248/255, green: 141/255, blue: 129/255, alpha: 1.0)
    }
    return cell
   }

}
