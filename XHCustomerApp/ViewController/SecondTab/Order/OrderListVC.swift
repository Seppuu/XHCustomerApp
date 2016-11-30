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
        
        makeData()
        
    }
    
    var orderList = [Order]()
    
    var cellId = "OrderCell"
    
    func setTableView() {
        
        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        view.addSubview(tableView)
        
        let nib = UINib(nibName: cellId, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
        
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
    
    func makeData() {
        
        var count = 1
        
        for i in 0...2 {
            
            let order = Order()
            order.name = "项目名称"
            order.status = .perchase
            
            if i == 0 {
                count = 1
            }
            else if i == 1{
                count = 2
            }
            else {
                count = 3
            }
            
            for _ in 0...count {
                
                let detail = OrderDetail()
                detail.name = "名字"
                detail.count = 2
                order.detailList.append(detail)
            }
            
            orderList.append(order)
        }
        
        
        tableView.reloadData()
    }

}

extension OrderListVC:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return orderList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //注意这里是使用了sectio,而不是row
        let order = orderList[indexPath.section].detailList
        return 70 + CGFloat(order.count) * 20
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 8.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! OrderCell
        cell.avatarImageView.backgroundColor = UIColor.init(hexString: "4A90E2")
        cell.selectionStyle = .none
        cell.nameLabel.text = "项目名称"
        cell.tagLabel.text = "待付款"
        
        //注意这里是使用了sectio,而不是row
        let order = orderList[indexPath.section]
        cell.order = order
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if hasLoadData == false {
            hasLoadData = true
        }
        
    }
    
    
}
