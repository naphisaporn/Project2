//
//  AddViewController.swift
//  Myorchard
//
//  Created by PewPew on 13/3/2563 BE.
//  Copyright © 2563 PewPew. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    @IBOutlet weak var transactionAmout: UITextField!
    @IBOutlet weak var transMonthDay: UITextField!
    @IBOutlet weak var transYear: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func addButton_click(_ sender: AnyObject) {
        if(transactionAmout.text != nil) {
            let amount = Int(transactionAmout.text!)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            let date = dateFormatter.date(from: "\(transMonthDay.text!)/\(transYear.text!)")
            var type = transType.credit
            
            if(transactionAmout.text?.contains("-") == true) {
                type = transType.debit
            }
            let trans = transaction(amount: amount!, date: date! as NSDate, type: type)
            DataManager.addTransaction(t: trans)
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
