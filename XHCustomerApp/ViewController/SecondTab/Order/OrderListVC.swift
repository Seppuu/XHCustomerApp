//
//  OrderListVC.swift
//  XHCustomerApp
//
//  Created by jidanyu on 2016/11/25.
//  Copyright © 2016年 mybook. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class OrderListVC: UIViewController,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    var tableView:UITableView!
    var parentNavigationController : UINavigationController?
    var parentVC:UIViewController?
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.ddViewBackGroundColor()
        setTableView()
        
    }
    
    
    
    func setTableView() {
        
        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        
        view.addSubview(tableView)
        
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        
        let text = "暂无订单"
        
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

}

extension OrderListVC:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "订单"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if hasLoadData == false {
            hasLoadData = true
        }
        
    }
    
    
}
