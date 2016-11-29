//
//  OrderDetailCell.swift
//  XHCustomerApp
//
//  Created by jidanyu on 2016/11/29.
//  Copyright © 2016年 mybook. All rights reserved.
//

import UIKit

class OrderDetailCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var rightLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
