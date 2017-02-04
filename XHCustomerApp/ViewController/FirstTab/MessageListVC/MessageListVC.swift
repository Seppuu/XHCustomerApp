//
//  MessageListVC.swift
//  XianHui
//
//  Created by Seppuu on 16/7/22.
//  Copyright © 2016年 mybook. All rights reserved.
//

import UIKit
import MJRefresh
import ChatKit
import DZNEmptyDataSet


let NoticeComingNoti = "NoticeComingNoti"

class MessageListVC: LCCKConversationListViewController,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate  {
    
    var model = MessageListModel()
    
    var customStatusView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
        
        
       // ChatKitExample.updateMessageListVC()
        
        self.tableView.mj_header.endRefreshingCompletionBlock = {
            self.hasLoadData = true
        }

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func changeMessageListByAccount() {
        
        self.refresh()
        
    }


    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        
        let text = "暂无消息"
        
        let attrString = NSAttributedString(string: text)
        
        return attrString
    }
    
    var hasLoadData = false {
        didSet {
            if hasLoadData == true {
                self.tableView.reloadData()
            }
        }
    }
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return hasLoadData
    }
    

    override func updateStatusView() {
        super.updateStatusView()
        
    }


}

