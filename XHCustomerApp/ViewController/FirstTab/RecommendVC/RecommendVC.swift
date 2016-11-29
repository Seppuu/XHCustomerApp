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

class RecommendVC: BaseViewController {
    
    var tableView:UITableView!
    
    var categoryCellId = "CategoryCell"
    
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
        
        let nib0 = UINib(nibName: "categoryCellId", bundle: nil)
        tableView.register(nib0, forHeaderFooterViewReuseIdentifier: "categoryCellId")
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
            return 4
        }
        else {
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        }
        else if indexPath.section == 1 {
            return 44
        }
        else if indexPath.section == 2 {
            return 60
        }
        else {
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 || section == 1 {
            return 0.01
        }
        return 8.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = UITableViewCell()
            let frame = CGRect(x: 0, y: 0, width: self.view.ddWidth, height: 100)
            if let loopView = HYBLoopScrollView(frame: frame, imageUrls: adsUrlList, timeInterval: 10.0, didSelect: { [weak self] (idnex) in
                if let strongSelf = self {
                }
            }, didScroll: { [weak self](index) in
                if let strongSelf = self {
                }
            }) {
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
//            let cell = tableView.dequeueReusableCell(withIdentifier: categoryCellId, for: indexPath) as! CategoryCell
            let cell = UITableViewCell()
            
            
            return cell
        }
        else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: categoryCellId, for: indexPath) as! CategoryCell
            let cell = UITableViewCell()
            
            
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            tableView.reloadData()
        }
    }
    
    
    
 
    
    
    
    
}
