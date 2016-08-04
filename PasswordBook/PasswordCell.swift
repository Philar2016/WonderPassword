//
//  PasswordCell.swift
//  PasswordBook
//
//  Created by LiangMinglong on 1/08/2016.
//  Copyright © 2016 LiangMinglong. All rights reserved.
//

import UIKit

class PasswordCell: UITableViewCell {

    @IBOutlet weak var user_type_label: UILabel!
    @IBOutlet weak var site_name_label: UILabel!
    @IBOutlet weak var pass_word_label: UILabel!
    @IBOutlet weak var user_name_label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
