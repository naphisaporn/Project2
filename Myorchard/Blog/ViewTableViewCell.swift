//
//  ViewTableViewCell.swift
//  Myorchard
//
//  Created by PewPew on 6/5/2563 BE.
//  Copyright © 2563 PewPew. All rights reserved.
//

import UIKit

class ViewTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
