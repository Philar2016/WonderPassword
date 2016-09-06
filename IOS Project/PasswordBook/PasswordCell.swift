//
//  PasswordCell.swift
//  PasswordBook
//
//  Created by LiangMinglong on 1/08/2016.
//  Copyright © 2016 LiangMinglong. All rights reserved.
//

import UIKit

class PasswordCell: UITableViewCell {

    @IBOutlet weak var Username_label: UILabel!
    @IBOutlet weak var Account_label: UILabel!
    @IBOutlet weak var Password_label: UILabel!
    @IBOutlet weak var Type_label: UILabel!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
