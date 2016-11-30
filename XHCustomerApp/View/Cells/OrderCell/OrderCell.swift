//
//  OrderCell.swift
//  XHCustomerApp
//
//  Created by jidanyu on 2016/11/29.
//  Copyright © 2016年 mybook. All rights reserved.
//

import UIKit

class OrderCell: UITableViewCell {
    
    @IBOutlet weak var topContainer: UIView!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var tagLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var bottomLabel: UILabel!
    
    var order = Order() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var cellId = "OrderDetailCell"
    
    var line = UIView()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarImageView.layer.cornerRadius = avatarImageView.ddWidth/2
        avatarImageView.layer.masksToBounds = true
        
        line.frame = CGRect(x: 46, y: 39.5, width: self.ddWidth - 46, height: 0.5)
        line.backgroundColor = UIColor.lightGray
        topContainer.addSubview(line)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        
        
        let nib = UINib(nibName: cellId, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension OrderCell: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return order.detailList.count
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! OrderDetailCell
        cell.selectionStyle = .none
        let detail = order.detailList[indexPath.row]
        cell.nameLabel.text = detail.name + String(indexPath.row)

        cell.rightLabel.text = String(detail.count)
        
        return cell
        
    }
    
}











