//
//  customTableViewCell.swift
//  Myorchard
//
//  Created by PewPew on 11/4/2563 BE.
//  Copyright © 2563 PewPew. All rights reserved.
//

import UIKit

class customTableViewCell: UITableViewCell {
    

    @IBOutlet weak var transAmount: UILabel!
    @IBOutlet weak var transDate: UILabel!
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
