//
//  StarWithTagCell.swift
//  XHCustomerApp
//
//  Created by jidanyu on 2016/11/25.
//  Copyright © 2016年 mybook. All rights reserved.
//

import UIKit
import RKTagsView
import Cosmos
import SnapKit

class StarWithTagCell: UITableViewCell {
    
    @IBOutlet weak var tagsContainer: UIView!
    
    @IBOutlet weak var starView: CosmosView!
    
    let tagsView =  RKTagsView()
    
    var tagList = [Tag]() {
        didSet {
            tagsView.removeAllTags()
            for tag in tagList {
                
                tagsView.addTag(tag.name)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setTagsView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func setTagsView() {
        
        tagsContainer.addSubview(tagsView)
        
        tagsView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(tagsContainer)
        }
        
        tagsView.editable = false
        tagsView.selectable = true
        tagsView.allowsMultipleSelection = true
  
    }
    
    
    
}
