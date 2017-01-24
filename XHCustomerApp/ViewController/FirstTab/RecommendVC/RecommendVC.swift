//
//  RecommendVC.swift
//  XHCustomerApp
//
//  Created by jidanyu on 2016/11/25.
//  Copyright © 2016年 mybook. All rights reserved.
//

import UIKit
import AMScrollingNavbar
import HYBLoopScrollView
import MJRefresh
import SwiftyJSON

class RecommendVC: BaseViewController {
    
    var tableView:UITableView!
    
    var goodCellId = "ContactsCell"
    
    var adsUrlList = [
        "http://a0.att.hudong.com/31/81/19300001363332131674810284674.jpg",
        "http://www.shusp.com/wp-content/uploads/2015/11/23779_neon_genesis_evangelion.jpg",
        "http://eweixin.oss-cn-hangzhou.aliyuncs.com/20150730/1438265842_6796.jpg"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "首页"
        view.backgroundColor = UIColor.ddViewBackGroundColor()
        setTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let navigationController = navigationController as? ScrollingNavigationController {
            navigationController.followScrollView(tableView, delay: 50.0)
        }
        
        tableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if let navigationController = navigationController as? ScrollingNavigationController {
            navigationController.stopFollowingScrollView()
        }
    }
    
    
    func setTableView() {
        tableView = UITableView(frame: view.bounds, style: .grouped)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib1 = UINib(nibName: goodCellId, bundle: nil)
        tableView.register(nib1, forCellReuseIdentifier: goodCellId)
        
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { 
            
            self.getList()
            
        })
        
        tableView.mj_footer.beginRefreshing()
    }
    
    var pageSize = 10
    
    var pageNumber = 1
    
    func getList() {
        
        
        NetworkManager.sharedManager.getGoodListWith(pageSize, pageNumber: pageNumber) { (success, json, error) in
            self.tableView.mj_footer.endRefreshing()
            if success == true {
                self.makeData(json: json!)
            }
            else {
                
            }
            
        }
        
    }
    
    func makeData(json:JSON) {
        
        
    }
    

}

extension RecommendVC:UITableViewDelegate,UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else if section == 1 {
            return 1
        }
        else if section == 2 {
            return 1
        }
        else {
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 150
        }
        else if indexPath.section == 1 {
            return 44
        }
        else if indexPath.section == 2 {
            return 80
        }
        else {
            return 80
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 2  {
            return 5.0
        }
        else if section == 1 {
            return 5.0
        }
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = UITableViewCell()
            let frame = CGRect(x: 0, y: 0, width: self.view.ddWidth, height: 150)
            if let loopView = HYBLoopScrollView(frame: frame, imageUrls: adsUrlList, timeInterval: 3.0, didSelect: { [weak self] (idnex) in
                if let strongSelf = self {
                }
            }, didScroll: { [weak self](index) in
                if let strongSelf = self {
                }
            }) {
                //loopView.shouldAutoClipImageToViewSize = true
                cell.addSubview(loopView)
            }
            
            return cell
        }
        else if indexPath.section == 1 {
            let cell = UITableViewCell()
            let pageView = AutoPagingView(frame: cell.frame)
            cell.addSubview(pageView)
            
            
            return cell
        }
        else if indexPath.section == 2 {
            let cell = UITableViewCell()
            let meunView = SubscriptionTopView.instanceFromNib()
            meunView.frame = cell.frame
            meunView.namesOfForm = ["面部","身体","足部","头部","背部","腰部","腿部"]
            cell.addSubview(meunView)
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: goodCellId, for: indexPath) as! ContactsCell
            
            cell.nameLabel.text = "项目名字"
            cell.avatarImageView.backgroundColor = UIColor.ddViewBackGroundColor()
            
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 3 {
            
            let vc = GoodViewController()
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
